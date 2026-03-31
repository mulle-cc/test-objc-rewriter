# test-c-output — Rewriter Test Suite

Tests for the `--mulle-objc-emit-c` compiler flag of the [mulle-clang](//github.com/mulle-cc/mulle-clang-project) compiler.
Each `.m` file survives two passes:

1. **Rewrite**: `clang --mulle-objc-emit-c foo.m -o foo.c`
2. **Compile**: `clang -x c -c foo.c -o foo.o`

Tests that have a `main` can also be run directly with the `run` script.

---

## Setup: build the local runtime

The `runtime/` subfolder is a minimal mulle-sde project that builds
`mulle-objc-runtime` and its dependencies as a self-contained local cache.
It is C-only and compiles quickly. Do this once (or after runtime updates):

```sh
cd test-c-output/runtime
mulle-sde craft
```

This populates `~/.mulle/var/cache/sde/runtime-<hash>/dependency/Debug/`.
The `show`, `run`, and test loop scripts all resolve the path automatically
via `mulle-sde dependency-dir`.

---

## Scripts

### `show` — emit rewritten C to stdout

```sh
./show test.m
./show test.m | less
```

Runs `clang --mulle-objc-emit-c` with the correct `-isystem` path and prints
the C output. Useful for inspecting what the rewriter produces.

### `run` — compile and run a test directly

```sh
./run test.m
```

Compiles the `.m` file with `-fobjc-runtime=mulle -fobjc-tao`, links against
the local runtime, and runs the resulting binary. Requires the test to have
a `main` function. Tests that allocate objects need `+new`/`-dealloc` — see
existing tests for the pattern:

```objc
+ (id) new       { return (Foo *) mulle_objc_infraclass_alloc_instance(
                       (struct _mulle_objc_infraclass *) self); }
- (void) dealloc { _mulle_objc_instance_free( self); }
```

Both scripts respect `CLANG=` and `DEPDIR=` environment overrides.

---

## Running the rewriter test suite

```sh
CLANG=/path/to/mulle-clang-21.1.8/build/bin/clang
INC=$(cd runtime && mulle-sde dependency-dir)/include

for f in t*.m; do
  name=$(basename $f .m)
  $CLANG --mulle-objc-emit-c -isystem "$INC" "$f" -o /tmp/${name}.c 2>/dev/null || \
    { echo "REWRITE FAIL $name"; continue; }
  out=$($CLANG -x c -c /tmp/${name}.c -isystem "$INC" -o /tmp/${name}.o 2>&1)
  [ $? -ne 0 ] \
    && echo "COMPILE FAIL $name: $(echo "$out" | grep 'error:' | head -1)" \
    || echo "OK $name"
done
```

Expected: `OK t01_pure_c` through `OK t30_emit_deps` (30 tests).

### `--mulle-objc-emit-deps` tests

```sh
CLANG=/path/to/clang INC=... sh test_emit_deps.sh
```

Verifies the `--mulle-objc-emit-deps[=<dir>]` flag that writes a `.deps.inc`
sidecar listing all `@implementation` blocks. Expected:

```
OK t30-explicit-dir
OK t30-bare-flag
OK t30-with-rewriter
Results: 3 passed, 0 failed
```

---

## Test descriptions

| Test | What it covers |
|------|----------------|
| t01_pure_c | Pure C — no ObjC preamble emitted |
| t02_selector | `@selector(foo)` → hash constant |
| t03_class | `@interface` + `@implementation` |
| t04_message_send | `[obj msg]`, `[obj msg:arg]`, `+new`/`-dealloc` |
| t05_string_literal | `@"str"` → static string |
| t06_classload | Class hierarchy, inheritance, ivars |
| t07_classmethods | `+` class methods |
| t08_super | `[super msg]` → `mulle_objc_object_call_super_c` |
| t09_property | `@property` + `@synthesize` |
| t10_category | `@implementation Foo (Cat)` |
| t11_protocol | `@protocol` adoption |
| t12_exceptions | `@try/@catch/@finally/@throw` |
| t13_id_cast_classmsg | `(id)` cast, class message send |
| t14_autoreleasepool | `@autoreleasepool`, `__unsafe_unretained` |
| t15_loadinfo_bits | `OBJC_IMAGE_INFO` version fields |
| t16_compatibility_alias | `@compatibility_alias` → `typedef` |
| t17_variadic | Variadic method — MetaABI struct with extra args |
| t18_fast_enum | `for (x in coll)` → `NSFastEnumerationState` loop |
| t19_defs | `@defs(Foo)` in struct declaration |
| t20_protocolclass | `@protocolclass` + `@protocolimplementation` |
| t21_method_alias | `@method_implementation - a = - b` |
| t22_string_literal | `@"hello world"` static string |
| t23_struct_metaabi | Large struct param + struct return via MetaABI |
| t24_metaabi_matrix | Full MetaABI matrix: 6 rval × 7 param types (42 methods) |
| t25_import_header | `#import` header handling |
| t26_anon_struct_ivar | Anonymous struct ivar |
| t27_method_bits | Method bits encoding |
| t28_property_sig | Property signature encoding |
| t29_dependency | Dependency directive |
| t30_emit_deps | `--mulle-objc-emit-deps`: class, category, protocolclass entries |

---

## Rebuilding the compiler

```sh
cd /path/to/mulle-clang-21.1.8/build && ninja clang
```

Rewriter source: `mulle-clang-project/clang/lib/Frontend/Rewrite/RewriteMulleObjC.cpp`


## Author

Nat! for Mulle kybernetiK
nat@mulle-kybernetik.com
https://github.com/mulle-cc

![footer](https://raw.githubusercontent.com/mulle-cc/test-objc-rewriter/master/heartlessly-vibecoded.png)
