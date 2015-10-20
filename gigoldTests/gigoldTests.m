//
//  gigoldTests.m
//  gigoldTests
//
//  Created by wsc on 15/10/10.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface gigoldTests : XCTestCase

@end

@implementation gigoldTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testOne{
    NSLog(@"testOne");
//    if (0) {
//        NSException *e = [NSException
//                          exceptionWithName: @"异常情况1"
//                          reason: @"number小于0"
//                          userInfo: nil];
//        @throw e;
//    }
}

@end
