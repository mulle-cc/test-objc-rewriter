#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Foo
{
   int   x;
}
- (int) x;
@end

@interface Foo (MyCategory)
- (int) doubled;
@end

@implementation Foo (MyCategory)

- (int) doubled
{
   mulle_printf( "doubled: %d\n", self->x * 2);
   return( self->x * 2);
}

@end

int main( void)
{
   return( 0);
}
