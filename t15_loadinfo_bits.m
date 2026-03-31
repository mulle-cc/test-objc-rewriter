// t15: OBJC_IMAGE_INFO bits — verify optlevel/inlinelevel encoded in bits field
// The bits field must encode TPS/FCS/TAO flags and opt/inline level.
// We just check it compiles; runtime sanity-checks the bits on load.
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Bits
- (void) noop;
@end

@implementation Bits

- (void) noop
{
   mulle_printf( "noop\n");
}

@end

int main( void)
{
   return( 0);
}
