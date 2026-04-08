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
Do this once (or after runtime updates):

```sh
cd test-c-output/runtime
mulle-sde craft
```

---

## Scripts

### `show` — emit rewritten C to stdout

```sh
./show test.m
./show test.m | less
```

Runs `clang --mulle-objc-emit-c` with the correct `-isystem` path and prints
the C output. Useful for inspecting what the rewriter produces.

### `run` — compile and run a single test

```sh
./run test.m
```

Compiles a `.m` file with `-fobjc-runtime=mulle -fobjc-tao`, links against
the local runtime, and runs the resulting binary. Requires the test to have
a `main` function.

### `run-test` — full test suite

```sh
./run-test                   # rewrite + portability + emit-deps
./run-test --mulle-only      # rewrite + mulle-clang compile only
./run-test --skip-emit-deps  # rewrite + portability, skip emit-deps
```

Rewrites every `t*.m` with mulle-clang, compiles with mulle-clang and every
C compiler found on `PATH` (gcc, clang, tcc, kefir, filc), then runs the
`test_emit_deps.sh` regression. One command tests everything.

Environment overrides: `MULLE_CLANG=`, `CC=` (single compiler), `INC=`.

### `run-emit-deps` — emit-deps regression (called by `run-test`)

Verifies the `--mulle-objc-emit-deps[=<dir>]` flag that writes a `.deps.inc`
sidecar listing all `@implementation` blocks. Can also be run standalone:

```sh
sh run-emit-deps
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

## Compiler compatibility

The rewritten C targets gcc and clang. All `__asm__` symbol names are
quoted (`__asm__("\"name\"")`) so GNU as accepts ObjC-style names like
`-[Foo value]` which contain `-`, `[`, `]`. Non-clang compilers receive
a `--mulle-objc-no-asm-names` variant without those annotations.

---

## Rebuilding the compiler

```sh
cd /path/to/mulle-clang-22.1.2/build && ninja clang
```

Rewriter source: `mulle-clang-project/clang/lib/Frontend/Rewrite/RewriteMulleObjC.cpp`


## Author

Nat! for Mulle kybernetiK
nat@mulle-kybernetik.com
https://github.com/mulle-cc

![footer](https://raw.githubusercontent.com/mulle-cc/test-objc-rewriter/master/heartlessly-vibecoded.png)
