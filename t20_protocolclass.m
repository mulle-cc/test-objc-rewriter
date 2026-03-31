// t20: @protocolclass + @protocolimplementation — default method
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@protocolclass Printable
- (void) print;
@end

@protocolimplementation Printable

- (void) print
{
   mulle_printf( "print\n");
}

@end

@interface Widget <Printable>
@end

@implementation Widget
@end

int main( void)
{
   return( 0);
}
