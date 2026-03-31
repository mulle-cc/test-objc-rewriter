// t28: property with observable, assign, custom getter — signature must include V_ivarname
// Verified against compiler output: signature = "i,O,N,GisEnabled,V_enabled"
#include <mulle-objc-runtime/mulle-objc-runtime.h>

__attribute__((objc_root_class))
@interface Foo
@property( observable, assign, getter=isEnabled) int enabled;
@end

@implementation Foo
@synthesize enabled = _enabled;
@end
