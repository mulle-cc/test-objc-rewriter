#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Foo
@end

@implementation Foo

+ (id) new
{
   return( (Foo *) mulle_objc_infraclass_alloc_instance( (struct _mulle_objc_infraclass *) self));
}

- (void) dealloc
{
   _mulle_objc_instance_free( self);
}

- (int) test
{
   id   x;
   id   y;

   x = [Foo new];
   y = (id) 0;
   if( [x isEqual:y])
      return( 1);
   return( 0);
}

@end

int main( void)
{
   return( 0);
}
