#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Base
{
   int   x;
}
- (int) value;
@end

@interface Foo : Base
- (int) value;
@end

@implementation Foo

- (int) value
{
   int   r;

   r = [super value] + 1;
   mulle_printf( "Foo value: %d\n", r);
   return( r);
}

@end

int main( void)
{
   return( 0);
}
