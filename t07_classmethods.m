#include <mulle-objc-runtime/mulle-objc-runtime.h>

@interface Base
{ int x; }
- (int) x;
- (void) setX:(int) v;
@end

@interface Foo : Base
{ int z; }
+ (id) new;
- (int) sum;
@end

@implementation Foo

+ (id) new {
    return 0;
}

- (int) sum {
    int s = [self x];
    mulle_printf( "sum: %d\n", s + self->z);
    return s + self->z;
}

@end

int main( void) { return 0; }
