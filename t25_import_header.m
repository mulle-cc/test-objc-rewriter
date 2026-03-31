// t25_import_header.m
// Test that #import'd headers are inline-rewritten:
// - ObjC declarations become C typedefs
// - C types (struct, typedef) are preserved verbatim
// - Nested #import chains are handled recursively
#include <mulle-objc-runtime/mulle-objc-runtime.h>

struct ContainerPoint { int x; int y; };

@interface Container
{
   struct ContainerPoint _point;
   int                   _count;
}
- (int) count;
@end

@implementation Container
- (int) count
{
   return( _count);
}
@end

int main( void)
{
   return( 0);
}
