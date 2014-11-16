//
//  MABlockClosureFrameworkTests.m
//  MABlockClosureFrameworkTests
//
//  Created by Jason Markham on 11/15/14.
//  Copyright (c) 2014 Jason Markham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <MABlockClosureFramework/MABlockClosureFramework.h>

@interface MABlockClosureFrameworkTests : XCTestCase

@end

@implementation MABlockClosureFrameworkTests


- (void)testOne {
    id block = ^(int x) { return x + 1; };
    MABlockClosure *closure = [[MABlockClosure alloc] initWithBlock: block];
    int ret = ((int (*)(int))closure.fptr)(3);
    XCTAssertEqual(4, ret);
}

- (void)testTwo {
    char * arg = "asdasd";
    id block  = ^{ return arg; };
    MABlockClosure *closure = [[MABlockClosure alloc] initWithBlock: block];
    char *s = ((char *(*)(void))closure.fptr)();
    XCTAssertEqual(arg, s);
    
}
- (void)testTwo2 {
    const char * arg = "asdasd";
    id block  = ^{ return arg; };
    MABlockClosure *closure = [[MABlockClosure alloc] initWithBlock: block];
    char *s = ((char *(*)(void))closure.fptr)();
    XCTAssertEqual(arg, s);
}

- (void)testThree {
    id block = ^{ return CGRectMake(0, 0, 0, 0); };
    MABlockClosure *closure = [[MABlockClosure alloc] initWithBlock: block];
    CGRect r = ((CGRect (*)(void))[closure fptr])();
    XCTAssertTrue( CGRectEqualToRect(CGRectMake(0, 0, 0, 0), r));
}

- (void)testFour {
    const char * arg = "append";
    
    id block;
    block = [^(NSString *s) { return [s stringByAppendingFormat: @" %s", arg]; } copy];
    NSString *strObj = ((id (*)(id))BlockFptr(block))(@"hello");
    
    XCTAssert( [@"hello append" isEqualToString:strObj]);
    
}
- (void)testFive {
    id  block = ^(int x, int y) { return x + y; };
    MABlockClosure * closure = [[MABlockClosure alloc] initWithBlock: block];
    int ret = ((int (*)(int, int))[closure fptr])(5, 10);
    
    XCTAssertEqual(5+10, ret);
}

- (void)testSix {
    __block  BOOL called = false;
    
    typedef void(^B0)();
    
    B0 block0 = ^{
        called=true;
    };
    
    id block =^{
        block0();
    };
    
    MABlockClosure *closure = [[MABlockClosure alloc] initWithBlock: block];
    ((void (*)(void))[closure fptr])();
    XCTAssertTrue(called);
}

- (void)testSeven {
    __block BOOL called = false;
    void (*fptr)(void) = BlockFptrAuto(^{ called = true;});
    fptr();
    
    XCTAssertTrue(called);
    
}




@end
