//
//  EmailValidationTests.m
//  Persona
//
//  Created by Denny Kim on 2015-07-29.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSString+EmailValidation.h"

@interface EmailValidationTests : XCTestCase

@end

@implementation EmailValidationTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidEmail
{
    XCTAssertTrue([@"valid.email@email.com" isValidEmail]);
}

- (void)testInvalidEmailEmpty
{
    XCTAssertFalse([@"" isValidEmail]);
}

- (void)testInvalidEmailNoLocal
{
    XCTAssertFalse([@"@email.com" isValidEmail]);
}

- (void)testInvalidEmailNoDomain
{
    XCTAssertFalse([@"invalid.email" isValidEmail]);
}

- (void)testInvalidEmailNoSeparator
{
    XCTAssertFalse([@"validEmailemail.com" isValidEmail]);
}

- (void)testInvalidEmailMultipleSeparator
{
    XCTAssertFalse([@"invalid@email@email.com" isValidEmail]);
}


@end
