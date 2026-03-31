// t21: @method_implementation alias — newSel = existingSel
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Aliased
- (void) doWork;
- (void) work;
@end

@implementation Aliased

- (void) doWork
{
   mulle_printf( "doWork\n");
}

@method_implementation - work = - doWork;

@end

int main( void)
{
   return( 0);
}
