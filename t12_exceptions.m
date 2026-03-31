#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface NSException
@end

@interface Foo
@end

@implementation Foo
- (void) test:(id) obj
{
   @try {
      [obj print];
   }
   @catch (NSException *e) {
      [e handle];
   }
   @finally {
      [obj cleanup];
   }
}

- (void) rethrow:(id) obj
{
   @throw obj;
}
@end

int main( void) { return 0; }
