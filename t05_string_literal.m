// t05: @"string" literal — constant string object
#define MULLE_OBJC_RUNTIME_LOAD_VERSION 18
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface NSString
@end

void test(void) {
   void *s = @"hello";
   mulle_printf( "string: %s\n", (char *) s);
}

int main( void) { test(); return 0; }
