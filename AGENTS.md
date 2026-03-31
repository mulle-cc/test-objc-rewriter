# AGENTS.md

## On startup

1. Read `README.md` for an overview of the test suite and scripts.
2. Build the local runtime if not already done:
   ```sh
   cd runtime && mulle-sde craft && cd ..
   ```
3. Read the coding style guide:
   ```sh
   cd runtime && mulle-sde howto show 1 && mulle-sde howto show 9
   ```

## Style rules (summary)

- 3-space indentation, no tabs
- Allman braces (opening brace on its own line)
- Space after `(` in control structures and function calls: `if( x)`, `foo( x)`
- `return( expr);` — always parenthesize the return value
- Declare all locals at top of function, one per line, alphabetically
- Do not initialize at declaration (except casts from args or aggregate zero-init)

## Running tests

```sh
CLANG=/home/src/srcL/mulle-clang-21.1.8/build/bin/clang
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

## Useful scripts

- `./show test.m` — emit rewritten C to stdout
- `./run test.m`  — compile and run directly (needs `main`)
