#include <mulle-objc-runtime/mulle-objc-runtime.h>

// Test @autoreleasepool rewrite: push/pop via _MulleAutoreleasePoolPush.
// The pool helper structs and inline function must be emitted in the C output.

@interface Base
@end

@implementation Base

+ (id) new
{
   return( (Base *) mulle_objc_infraclass_alloc_instance( (struct _mulle_objc_infraclass *) self));
}

- (void) dealloc
{
   _mulle_objc_instance_free( self);
}

@end

@interface Foo : Base
- (void) autorel;
- (void) qualifiers;
+ (id) create;
@end

@implementation Foo

- (void) autorel
{
   @autoreleasepool
   {
      id   x;

      x = [Foo new];
      (void) x;
   }
}

- (void) qualifiers
{
   __unsafe_unretained id   x;

   x = [Foo new];
   (void) x;
}

+ (id) create
{
   return( [self new]);
}

@end

int main( void)
{
   return( 0);
}
