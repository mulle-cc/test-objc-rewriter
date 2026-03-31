#define MULLE_OBJC_RUNTIME_LOAD_VERSION 18
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Base
{
   int   x;
}
- (int) value;
@end

@interface Foo : Base
{
   int   z;
}
- (int) sum;
- (void) setZ:(int) v;
@end

@implementation Foo

- (int) sum
{
   mulle_printf( "sum: %d\n", self->x + self->z);
   return( self->x + self->z);
}

- (void) setZ:(int) v
{
   self->z = v;
}

@end

int main( void)
{
   return( 0);
}
