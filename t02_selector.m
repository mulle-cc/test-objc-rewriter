// t02: @selector — simplest ObjC expression, just a hash constant
#include <mulle-objc-runtime/mulle-objc-runtime.h>

void test(void) {
   mulle_objc_methodid_t sel = @selector(length);
   mulle_printf( "sel: %u\n", (unsigned) sel);
}

int main( void) { test(); return 0; }
