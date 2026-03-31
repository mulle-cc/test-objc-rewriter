// t18: fast enumeration — for (x in collection) expansion
#include <mulle-objc-runtime/mulle-objc-runtime.h>
#include <mulle-objc-runtime/mulle-objc-fastenumeration.h>

#ifndef NSUInteger
typedef unsigned long NSUInteger;
#endif
#ifndef NSFastEnumerationState
typedef struct
{
   NSUInteger   state;
   void         **itemsPtr;
   NSUInteger   *mutationsPtr;
   NSUInteger   extra[5];
} NSFastEnumerationState;
#endif

@interface Collection
- (NSUInteger) countByEnumeratingWithState:(NSFastEnumerationState *) state
                                   objects:(id *) buf
                                     count:(NSUInteger) len;
@end

@implementation Collection

- (NSUInteger) countByEnumeratingWithState:(NSFastEnumerationState *) state
                                   objects:(id *) buf
                                     count:(NSUInteger) len
{
   (void) state;
   (void) buf;
   (void) len;
   return( 0);
}

@end

void test( Collection *c)
{
   id   item;

   for( item in c)
      mulle_printf( "item: %p\n", item);
   mulle_printf( "done\n");
}

int main( void)
{
   return( 0);
}
