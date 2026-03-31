#include <mulle-objc-runtime/mulle-objc-runtime.h>

// Test anonymous struct/union ivars are emitted as inline C definitions
@interface Foo
{
   struct { int x; int y; } _point;
   union  { int i; float f; } _val;
   int _count;
}
- (int) count;
@end

@implementation Foo
- (int) count
{
   return( _count + _point.x + _val.i);
}
@end

int main( void)
{
   return( 0);
}
