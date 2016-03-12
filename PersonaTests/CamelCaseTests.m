//
//  CamelCaseTests.m
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+CamelCase.h"

@interface CamelCaseTests : XCTestCase

@end

@implementation CamelCaseTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testToCamelCase
{
    NSString *str = @"Hello World";
    XCTAssertEqualObjects(@"helloWorld", [str toCamelCase]);
}

- (void)testToTitleCase
{
    NSString *str = @"helloWorld";
    XCTAssertEqualObjects(@"Hello World", [str toTitleCase]);
}

@end
