// t23: MetaABI struct param + struct return (6 doubles wide)
// Verifies: union { struct { BigStruct v; } v; void *space; BigStruct rval; } at call site
//           *(BigStruct *)_param = result; return _param; in method body
#include <mulle-objc-runtime/mulle-objc-runtime.h>

typedef struct { double a, b, c, d, e, f; } BigStruct;

@interface Calc
- (BigStruct) transform:(BigStruct) s;
@end

@implementation Calc

- (BigStruct) transform:(BigStruct) s
{
   s.a += 1.0;
   return( s);
}

@end

void test( Calc *c)
{
   BigStruct   in;
   BigStruct   out;

   in  = (BigStruct) { 1, 2, 3, 4, 5, 6 };
   out = [c transform:in];
   mulle_printf( "out.a: %g\n", out.a);
}

int main( void)
{
   return( 0);
}
