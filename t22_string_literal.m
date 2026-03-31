// t22: @string literal — static NSConstantString
#include <mulle-objc-runtime/mulle-objc-runtime.h>

void test( void)
{
   void   *s;

   s = @"hello world";
   mulle_printf( "string: %s\n", (char *) s);
}

int main( void)
{
   test();
   return( 0);
}
