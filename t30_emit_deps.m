// t30: --mulle-objc-emit-deps sidecar file
// Tests that all three @implementation forms are captured:
//   - @protocolimplementation  (protocolclass)
//   - @implementation Class
//   - @implementation Class (Category)
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@protocolclass Printable
- (void) print;
@end

@protocolimplementation Printable
- (void) print {}
@end

@interface Animal
@end

@implementation Animal
@end

@implementation Animal (Taming)
@end
