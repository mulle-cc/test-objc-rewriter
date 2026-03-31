// t29: @dependency directive — TU-scope and impl-scope, including category form
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@dependency SharedLib;

__attribute__((objc_root_class))
@interface Foo
@end

@implementation Foo
@dependency Local;
@dependency Foundation(Base);
@end
