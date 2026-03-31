// t04: message send — the core ObjC operation
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Foo
{ int _v; }
- (int) value;
- (void) setValue:(int) x;
@end

@implementation Foo
+ (id) new          { return( (Foo *) mulle_objc_infraclass_alloc_instance( (struct _mulle_objc_infraclass *) self)); }
- (void) dealloc    { _mulle_objc_instance_free( self); }
- (int) value { return _v; }
- (void) setValue:(int) x { mulle_printf( "setValue: %d\n", x); _v = x; }
@end

void test(Foo *f) {
   int v = [f value];
   [f setValue:v + 1];
}

int main( void) {
   Foo *f = [Foo new];
   [f setValue:41];
   mulle_printf( "value: %d\n", [f value]);
   return 0;
}
