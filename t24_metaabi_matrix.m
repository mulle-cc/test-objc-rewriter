// t24_metaabi_matrix.m
// MetaABI rewriter coverage: all rval x param type combinations
// rvals:  void, void*, int (scalar), float (FP), TinyStruct (voidptr-packed), BigStruct (large)
// params: 0, int (scalar), float (FP), void*, TinyStruct (voidptr-packed), BigStruct (large), multi (int+double+int)
#include <mulle-objc-runtime/mulle-objc-runtime.h>

typedef struct { char a[3]; }              TinyStruct;  // fits in void*, non-FP -> voidptr-packed
typedef struct { int a; double b; int c; } BigStruct;   // > void* -> struct-packed

@interface A
+ (id) self;
- (void)       v0;
- (void)       vInt:(int) x;
- (void)       vFloat:(float) x;
- (void)       vVoidptr:(void *) x;
- (void)       vTiny:(TinyStruct) x;
- (void)       vBig:(BigStruct) x;
- (void)       vMulti:(int) a b:(double) b c:(int) c;

- (void *)     p0;
- (void *)     pInt:(int) x;
- (void *)     pFloat:(float) x;
- (void *)     pVoidptr:(void *) x;
- (void *)     pTiny:(TinyStruct) x;
- (void *)     pBig:(BigStruct) x;
- (void *)     pMulti:(int) a b:(double) b c:(int) c;

- (int)        i0;
- (int)        iInt:(int) x;
- (int)        iFloat:(float) x;
- (int)        iVoidptr:(void *) x;
- (int)        iTiny:(TinyStruct) x;
- (int)        iBig:(BigStruct) x;
- (int)        iMulti:(int) a b:(double) b c:(int) c;

- (float)      f0;
- (float)      fInt:(int) x;
- (float)      fFloat:(float) x;
- (float)      fVoidptr:(void *) x;
- (float)      fTiny:(TinyStruct) x;
- (float)      fBig:(BigStruct) x;
- (float)      fMulti:(int) a b:(double) b c:(int) c;

- (TinyStruct) t0;
- (TinyStruct) tInt:(int) x;
- (TinyStruct) tFloat:(float) x;
- (TinyStruct) tVoidptr:(void *) x;
- (TinyStruct) tTiny:(TinyStruct) x;
- (TinyStruct) tBig:(BigStruct) x;
- (TinyStruct) tMulti:(int) a b:(double) b c:(int) c;

- (BigStruct)  b0;
- (BigStruct)  bInt:(int) x;
- (BigStruct)  bFloat:(float) x;
- (BigStruct)  bVoidptr:(void *) x;
- (BigStruct)  bTiny:(TinyStruct) x;
- (BigStruct)  bBig:(BigStruct) x;
- (BigStruct)  bMulti:(int) a b:(double) b c:(int) c;
@end

@implementation A
+ (id) self { return self; }
- (void) v0                                    { mulle_printf( "v0\n"); }
- (void) vInt:(int) x                          { mulle_printf( "vInt: %d\n", x); }
- (void) vFloat:(float) x                      { mulle_printf( "vFloat: %g\n", x); }
- (void) vVoidptr:(void *) x                   { mulle_printf( "vVoidptr: %p\n", x); }
- (void) vTiny:(TinyStruct) x                  { mulle_printf( "vTiny: %c%c%c\n", x.a[0], x.a[1], x.a[2]); }
- (void) vBig:(BigStruct) x                    { mulle_printf( "vBig: %d %g %d\n", x.a, x.b, x.c); }
- (void) vMulti:(int) a b:(double) b c:(int) c { mulle_printf( "vMulti: %d %g %d\n", a, b, c); }

- (void *) p0                                    { mulle_printf( "p0\n");                              return (void *) 1; }
- (void *) pInt:(int) x                          { mulle_printf( "pInt: %d\n", x);                    return (void *) 2; }
- (void *) pFloat:(float) x                      { mulle_printf( "pFloat: %g\n", x);                  return (void *) 3; }
- (void *) pVoidptr:(void *) x                   { mulle_printf( "pVoidptr: %p\n", x);                return (void *) 4; }
- (void *) pTiny:(TinyStruct) x                  { mulle_printf( "pTiny: %c%c%c\n", x.a[0], x.a[1], x.a[2]); return (void *) 5; }
- (void *) pBig:(BigStruct) x                    { mulle_printf( "pBig: %d %g %d\n", x.a, x.b, x.c); return (void *) 6; }
- (void *) pMulti:(int) a b:(double) b c:(int) c { mulle_printf( "pMulti: %d %g %d\n", a, b, c);      return (void *) 7; }

- (int) i0                                    { mulle_printf( "i0\n");                              return 10; }
- (int) iInt:(int) x                          { mulle_printf( "iInt: %d\n", x);                    return x + 1; }
- (int) iFloat:(float) x                      { mulle_printf( "iFloat: %g\n", x);                  return (int) x + 1; }
- (int) iVoidptr:(void *) x                   { mulle_printf( "iVoidptr: %p\n", x);                return 13; }
- (int) iTiny:(TinyStruct) x                  { mulle_printf( "iTiny: %c%c%c\n", x.a[0], x.a[1], x.a[2]); return x.a[0]; }
- (int) iBig:(BigStruct) x                    { mulle_printf( "iBig: %d %g %d\n", x.a, x.b, x.c); return x.a + x.c; }
- (int) iMulti:(int) a b:(double) b c:(int) c { mulle_printf( "iMulti: %d %g %d\n", a, b, c);      return a + c; }

- (float) f0                                    { mulle_printf( "f0\n");                              return 1.0f; }
- (float) fInt:(int) x                          { mulle_printf( "fInt: %d\n", x);                    return (float) x; }
- (float) fFloat:(float) x                      { mulle_printf( "fFloat: %g\n", x);                  return x + 1.0f; }
- (float) fVoidptr:(void *) x                   { mulle_printf( "fVoidptr: %p\n", x);                return 2.0f; }
- (float) fTiny:(TinyStruct) x                  { mulle_printf( "fTiny: %c%c%c\n", x.a[0], x.a[1], x.a[2]); return (float) x.a[0]; }
- (float) fBig:(BigStruct) x                    { mulle_printf( "fBig: %d %g %d\n", x.a, x.b, x.c); return (float) x.b; }
- (float) fMulti:(int) a b:(double) b c:(int) c { mulle_printf( "fMulti: %d %g %d\n", a, b, c);      return (float)(a + c); }

- (TinyStruct) t0                                    { mulle_printf( "t0\n");                              TinyStruct r = {{'t','0','!'}}; return r; }
- (TinyStruct) tInt:(int) x                          { mulle_printf( "tInt: %d\n", x);                    TinyStruct r = {{'t','i', x}}; return r; }
- (TinyStruct) tFloat:(float) x                      { mulle_printf( "tFloat: %g\n", x);                  TinyStruct r = {{'t','f','!'}}; return r; }
- (TinyStruct) tVoidptr:(void *) x                   { mulle_printf( "tVoidptr: %p\n", x);                TinyStruct r = {{'t','p','!'}}; return r; }
- (TinyStruct) tTiny:(TinyStruct) x                  { mulle_printf( "tTiny: %c%c%c\n", x.a[0], x.a[1], x.a[2]); return x; }
- (TinyStruct) tBig:(BigStruct) x                    { mulle_printf( "tBig: %d %g %d\n", x.a, x.b, x.c); TinyStruct r = {{'t','b','!'}}; return r; }
- (TinyStruct) tMulti:(int) a b:(double) b c:(int) c { mulle_printf( "tMulti: %d %g %d\n", a, b, c);      TinyStruct r = {{'t','m','!'}}; return r; }

- (BigStruct) b0                                    { mulle_printf( "b0\n");                              BigStruct r = {10, 1.0, 20}; return r; }
- (BigStruct) bInt:(int) x                          { mulle_printf( "bInt: %d\n", x);                    BigStruct r = {x, 0.0, x}; return r; }
- (BigStruct) bFloat:(float) x                      { mulle_printf( "bFloat: %g\n", x);                  BigStruct r = {0, x, 0}; return r; }
- (BigStruct) bVoidptr:(void *) x                   { mulle_printf( "bVoidptr: %p\n", x);                BigStruct r = {0, 0.0, 0}; return r; }
- (BigStruct) bTiny:(TinyStruct) x                  { mulle_printf( "bTiny: %c%c%c\n", x.a[0], x.a[1], x.a[2]); BigStruct r = {x.a[0], 0.0, x.a[2]}; return r; }
- (BigStruct) bBig:(BigStruct) x                    { mulle_printf( "bBig: %d %g %d\n", x.a, x.b, x.c); return x; }
- (BigStruct) bMulti:(int) a b:(double) b c:(int) c { mulle_printf( "bMulti: %d %g %d\n", a, b, c);      BigStruct r = {a, b, c}; return r; }
@end


int main( void)
{
   A          *obj = [A self];
   TinyStruct ts   = {{'X', 'Y', 'Z'}};
   BigStruct  bs   = {1, 2.0, 3};
   void       *p;
   int        i;
   float      f;
   TinyStruct t;
   BigStruct  b;

   [obj v0];
   [obj vInt:42];
   [obj vFloat:1.5f];
   [obj vVoidptr:(void *) 0x1234];
   [obj vTiny:ts];
   [obj vBig:bs];
   [obj vMulti:1 b:2.0 c:3];

   p = [obj p0];          mulle_printf( "-> %p\n", p);
   p = [obj pInt:42];     mulle_printf( "-> %p\n", p);
   p = [obj pFloat:1.5f]; mulle_printf( "-> %p\n", p);
   p = [obj pVoidptr:(void *) 0x1234]; mulle_printf( "-> %p\n", p);
   p = [obj pTiny:ts];    mulle_printf( "-> %p\n", p);
   p = [obj pBig:bs];     mulle_printf( "-> %p\n", p);
   p = [obj pMulti:1 b:2.0 c:3]; mulle_printf( "-> %p\n", p);

   i = [obj i0];          mulle_printf( "-> %d\n", i);
   i = [obj iInt:42];     mulle_printf( "-> %d\n", i);
   i = [obj iFloat:1.5f]; mulle_printf( "-> %d\n", i);
   i = [obj iVoidptr:(void *) 0x1234]; mulle_printf( "-> %d\n", i);
   i = [obj iTiny:ts];    mulle_printf( "-> %d\n", i);
   i = [obj iBig:bs];     mulle_printf( "-> %d\n", i);
   i = [obj iMulti:1 b:2.0 c:3]; mulle_printf( "-> %d\n", i);

   f = [obj f0];          mulle_printf( "-> %g\n", f);
   f = [obj fInt:42];     mulle_printf( "-> %g\n", f);
   f = [obj fFloat:1.5f]; mulle_printf( "-> %g\n", f);
   f = [obj fVoidptr:(void *) 0x1234]; mulle_printf( "-> %g\n", f);
   f = [obj fTiny:ts];    mulle_printf( "-> %g\n", f);
   f = [obj fBig:bs];     mulle_printf( "-> %g\n", f);
   f = [obj fMulti:1 b:2.0 c:3]; mulle_printf( "-> %g\n", f);

   t = [obj t0];          mulle_printf( "-> %c%c%c\n", t.a[0], t.a[1], t.a[2]);
   t = [obj tInt:42];     mulle_printf( "-> %c%c%c\n", t.a[0], t.a[1], t.a[2]);
   t = [obj tFloat:1.5f]; mulle_printf( "-> %c%c%c\n", t.a[0], t.a[1], t.a[2]);
   t = [obj tVoidptr:(void *) 0x1234]; mulle_printf( "-> %c%c%c\n", t.a[0], t.a[1], t.a[2]);
   t = [obj tTiny:ts];    mulle_printf( "-> %c%c%c\n", t.a[0], t.a[1], t.a[2]);
   t = [obj tBig:bs];     mulle_printf( "-> %c%c%c\n", t.a[0], t.a[1], t.a[2]);
   t = [obj tMulti:1 b:2.0 c:3]; mulle_printf( "-> %c%c%c\n", t.a[0], t.a[1], t.a[2]);

   b = [obj b0];          mulle_printf( "-> %d %g %d\n", b.a, b.b, b.c);
   b = [obj bInt:42];     mulle_printf( "-> %d %g %d\n", b.a, b.b, b.c);
   b = [obj bFloat:1.5f]; mulle_printf( "-> %d %g %d\n", b.a, b.b, b.c);
   b = [obj bVoidptr:(void *) 0x1234]; mulle_printf( "-> %d %g %d\n", b.a, b.b, b.c);
   b = [obj bTiny:ts];    mulle_printf( "-> %d %g %d\n", b.a, b.b, b.c);
   b = [obj bBig:bs];     mulle_printf( "-> %d %g %d\n", b.a, b.b, b.c);
   b = [obj bMulti:1 b:2.0 c:3]; mulle_printf( "-> %d %g %d\n", b.a, b.b, b.c);

   return 0;
}
