#include <mulle-objc-runtime/mulle-objc-runtime.h>

@protocol Printable
- (void) print;
@end

@interface Foo <Printable>
{ int x; }
@end

@implementation Foo
- (void) print { mulle_printf( "print\n"); }
@end

int main( void) { return 0; }
