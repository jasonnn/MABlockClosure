
#import <Foundation/Foundation.h>





@interface MABlockClosure : NSObject

@property(nonatomic,readonly) void *fptr;

- (instancetype)initWithBlock: (id)block;


@end

// convenience function, returns a function pointer
// whose lifetime is tied to 'block'
// block MUST BE a heap block (pre-copied)
// or a global block
void *BlockFptr(id block);

// copies/autoreleases the block, then returns
// function pointer associated to it
void *BlockFptrAuto(id block);
