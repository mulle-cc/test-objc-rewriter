// t17: variadic method — MetaABI struct emitted for variadic args
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Variadic
- (int) sum:(int) first, ...;
@end

@implementation Variadic

- (int) sum:(int) first, ...
{
   mulle_printf( "sum first: %d\n", first);
   return( first);
}

@end

void test( Variadic *v)
{
   int   r;

   r = (int)(intptr_t) [v sum:1, 2, 3, 0];
   mulle_printf( "result: %d\n", r);
}

int main( void)
{
   return( 0);
}
