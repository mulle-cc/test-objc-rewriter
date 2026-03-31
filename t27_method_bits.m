// t27: method descriptor .bits — family, variadic, designated_init, user_attrs
// Verified against compiler IR (CGObjCMulleRuntime) for identical bit values.
#include <mulle-objc-runtime/mulle-objc-runtime.h>

__attribute__((objc_root_class))
@interface Foo
- (instancetype) init;
+ (instancetype) new;
+ (instancetype) alloc;
- (id) copy;
- (id) mutableCopy;
- (void) dealloc;
- (void) release;
- (id) retain;
- (NSUInteger) retainCount;
- (instancetype) self;
- (void) finalize;
- (void) initialize;
- (id) autorelease;
- (void) mullePerformSelector:(SEL)sel;
- (void) addToFoo:(id)x;
- (void) removeFromFoo:(id)x;
- (void) setFoo:(id)x;
- (id) foo;
- (void) variadicMethod:(id)first, ...;
- (instancetype) initWithValue:(int)v __attribute__((objc_designated_initializer));
- (void) user0 __attribute__((annotate("objc_user_0")));
- (void) user1 __attribute__((annotate("objc_user_1")));
- (void) user2 __attribute__((annotate("objc_user_2")));
- (void) user3 __attribute__((annotate("objc_user_3")));
- (void) user4 __attribute__((annotate("objc_user_4")));
@end
@implementation Foo
- (instancetype) init              { return self; }
+ (instancetype) new               { return 0; }
+ (instancetype) alloc             { return 0; }
- (id) copy                        { return self; }
- (id) mutableCopy                 { return self; }
- (void) dealloc                   {}
- (void) release                   {}
- (id) retain                      { return self; }
- (NSUInteger) retainCount         { return 1; }
- (instancetype) self              { return self; }
- (void) finalize                  {}
- (void) initialize                {}
- (id) autorelease                 { return self; }
- (void) mullePerformSelector:(SEL)sel {}
- (void) addToFoo:(id)x            {}
- (void) removeFromFoo:(id)x       {}
- (void) setFoo:(id)x              {}
- (id) foo                         { return 0; }
- (void) variadicMethod:(id)first, ... {}
- (instancetype) initWithValue:(int)v  { return self; }
- (void) user0 __attribute__((annotate("objc_user_0"))) {}
- (void) user1 __attribute__((annotate("objc_user_1"))) {}
- (void) user2 __attribute__((annotate("objc_user_2"))) {}
- (void) user3 __attribute__((annotate("objc_user_3"))) {}
- (void) user4 __attribute__((annotate("objc_user_4"))) {}
@end
