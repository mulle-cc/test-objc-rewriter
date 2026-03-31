#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Foo
{
   int _x;
}
@property int x;
@end

@implementation Foo
+ (id) new          { return( (Foo *) mulle_objc_infraclass_alloc_instance( (struct _mulle_objc_infraclass *) self)); }
- (void) dealloc    { _mulle_objc_instance_free( self); }
@synthesize x = _x;
@end

int main( void) {
   Foo *f = [Foo new];
   [f setX:42];
   mulle_printf( "x: %d\n", [f x]);
   return 0;
}
