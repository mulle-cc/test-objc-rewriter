#!/bin/sh
# Regression test for --mulle-objc-emit-deps sidecar file generation.
# Tests both --mulle-objc-emit-deps=<dir> and bare --mulle-objc-emit-deps.
#
# Usage: CLANG=/path/to/clang sh test_emit_deps.sh
#
CLANG="${CLANG:-clang}"
INC="${INC:-$(cd "$(dirname "$0")/runtime" && mulle-sde dependency-dir 2>/dev/null)/include}"
TESTDIR="$(cd "$(dirname "$0")" && pwd)"

PASS=0
FAIL=0

ok() {
    PASS=$((PASS+1))
    printf 'OK %s\n' "$1"
}

fail() {
    FAIL=$((FAIL+1))
    printf 'FAIL %s: %s\n' "$1" "$2"
}

# ------------------------------------------------------------------ #
#  Test 1: --mulle-objc-emit-deps=<dir>  with -fsyntax-only
# ------------------------------------------------------------------ #
OUTDIR="$(mktemp -d)"
trap "rm -rf '$OUTDIR'" EXIT INT TERM

"$CLANG" -fsyntax-only \
    --mulle-objc-emit-deps="$OUTDIR" \
    -isystem "$INC" \
    "$TESTDIR/t30_emit_deps.m" >/dev/null 2>&1

DEPSFILE="$OUTDIR/t30_emit_deps.deps.inc"
if [ ! -f "$DEPSFILE" ]; then
    fail "t30-explicit-dir" ".deps.inc not created at $DEPSFILE"
else
    # Check that all three expected entries are present
    FOUND_PROTO=$(grep -c "Printable.*MULLE_OBJC_NO_CATEGORYID" "$DEPSFILE")
    FOUND_CLASS=$(grep -c "Animal.*MULLE_OBJC_NO_CATEGORYID" "$DEPSFILE")
    FOUND_CAT=$(grep -c "Animal.*Taming" "$DEPSFILE")
    FOUND_HASH_PROTO=$(grep -c "4185f60c;Printable;;" "$DEPSFILE")
    FOUND_HASH_CLASS=$(grep -c "48b6b7d3;Animal;;" "$DEPSFILE")
    FOUND_HASH_CAT=$(grep -c "48b6b7d3;Animal;c5d05efb;Taming" "$DEPSFILE")

    ALL_OK=1
    [ "$FOUND_PROTO"      -ge 1 ] || { ALL_OK=0; fail "t30-explicit-dir" "missing Printable entry"; }
    [ "$FOUND_CLASS"      -ge 1 ] || { ALL_OK=0; fail "t30-explicit-dir" "missing Animal entry"; }
    [ "$FOUND_CAT"        -ge 1 ] || { ALL_OK=0; fail "t30-explicit-dir" "missing Animal(Taming) entry"; }
    [ "$FOUND_HASH_PROTO" -ge 1 ] || { ALL_OK=0; fail "t30-explicit-dir" "wrong hash for Printable"; }
    [ "$FOUND_HASH_CLASS" -ge 1 ] || { ALL_OK=0; fail "t30-explicit-dir" "wrong hash for Animal"; }
    [ "$FOUND_HASH_CAT"   -ge 1 ] || { ALL_OK=0; fail "t30-explicit-dir" "wrong hash for Animal(Taming)"; }
    [ $ALL_OK -eq 1 ] && ok "t30-explicit-dir"
fi

# ------------------------------------------------------------------ #
#  Test 2: bare --mulle-objc-emit-deps  — output goes to CWD
#  (with -fsyntax-only there is no -o, so bare flag falls back to ".")
# ------------------------------------------------------------------ #
OUTDIR2="$(mktemp -d)"
trap "rm -rf '$OUTDIR' '$OUTDIR2'" EXIT INT TERM

PREV_DIR="$PWD"
cd "$OUTDIR2"
"$CLANG" -fsyntax-only \
    --mulle-objc-emit-deps \
    -isystem "$INC" \
    "$TESTDIR/t30_emit_deps.m" >/dev/null 2>&1
cd "$PREV_DIR"

DEPSFILE2="$OUTDIR2/t30_emit_deps.deps.inc"
if [ ! -f "$DEPSFILE2" ]; then
    fail "t30-bare-flag" ".deps.inc not created in CWD ($OUTDIR2)"
else
    if grep -q "Animal.*MULLE_OBJC_NO_CATEGORYID" "$DEPSFILE2"; then
        ok "t30-bare-flag"
    else
        fail "t30-bare-flag" "expected Animal entry missing"
    fi
fi

# ------------------------------------------------------------------ #
#  Test 3: --mulle-objc-emit-deps works alongside --mulle-objc-emit-c
# ------------------------------------------------------------------ #
OUTDIR3="$(mktemp -d)"
trap "rm -rf '$OUTDIR' '$OUTDIR2' '$OUTDIR3'" EXIT INT TERM

"$CLANG" --mulle-objc-emit-c \
    --mulle-objc-emit-deps="$OUTDIR3" \
    -isystem "$INC" \
    "$TESTDIR/t30_emit_deps.m" \
    -o "$OUTDIR3/t30_emit_deps.c" >/dev/null 2>&1

DEPSFILE3="$OUTDIR3/t30_emit_deps.deps.inc"
if [ ! -f "$DEPSFILE3" ]; then
    fail "t30-with-rewriter" ".deps.inc not created alongside --mulle-objc-emit-c"
else
    if grep -q "Animal.*MULLE_OBJC_NO_CATEGORYID" "$DEPSFILE3"; then
        ok "t30-with-rewriter"
    else
        fail "t30-with-rewriter" "expected Animal entry missing"
    fi
fi

# ------------------------------------------------------------------ #
#  Summary
# ------------------------------------------------------------------ #
echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ]
