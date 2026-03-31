// t19: @defs — ivar access via @defs() in function-local struct declaration
#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Node
{
   int     value;
   void    *next;
}
- (int) value;
@end

@implementation Node

- (int) value
{
   return( value);
}

@end

void test( Node *n)
{
   struct NodeRaw { @defs(Node) } *raw;

   raw = (struct NodeRaw *) n;
   mulle_printf( "value: %d\n", raw->value);
}

int main( void)
{
   return( 0);
}
