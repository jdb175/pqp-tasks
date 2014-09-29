//
//  PQPTasksTests.m
//  PQPTasksTests
//
//  Created by Jason Whitehouse on 9/18/14.
//  Copyright (c) 2014 WPI. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AJVArithTestModel.h"

@interface PQPTasksTests : XCTestCase

@end

@implementation PQPTasksTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAdd
{
    AJVArithTestModel *one = [[AJVArithTestModel alloc] init];
    one.num = 1;
    XCTAssertEqual([one add:2], 3);
    
}

- (void)testMult
{
    AJVArithTestModel *two = [[AJVArithTestModel alloc] init];
    two.num = 2;
    XCTAssertEqual([two mult:3], 6);
}


- (void)testAddMultZero
{
    AJVArithTestModel *two = [[AJVArithTestModel alloc] init];
    two.num = 2;
    int result = [two add:[two mult:-1]];
    XCTAssertEqual(result, 0);
}

@end
