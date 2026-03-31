// t16: @compatibility_alias — must emit typedef
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Animal
- (void) breathe;
@end

@compatibility_alias Creature Animal;

@implementation Animal
+ (id) new          { return( (Animal *) mulle_objc_infraclass_alloc_instance( (struct _mulle_objc_infraclass *) self)); }
- (void) dealloc    { _mulle_objc_instance_free( self); }
- (void) breathe { mulle_printf( "breathe\n"); }
@end

void test(void) {
    Creature *c = (Creature *) [Animal new];
    [c breathe];
    (void) c;
}

int main( void) { test(); return 0; }
