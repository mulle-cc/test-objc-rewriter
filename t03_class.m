// t03: @interface + @implementation — class declaration and method
#define MULLE_OBJC_RUNTIME_LOAD_VERSION 18
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Foo
- (int) value;
@end

@implementation Foo
- (int) value { mulle_printf( "value\n"); return 42; }
@end

int main( void) { return 0; }
