//
//  PersonaExpirationTests.m
//  Persona
//
//  Created by Denny Kim on 2015-07-29.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSDate+EpochTime.h"
#import "NSString+ExpirationTime.h"

@interface EpochAndExpirationTests : XCTestCase
@property (nonatomic, strong) NSDate *currentDate;
@end

@implementation EpochAndExpirationTests

- (void)setUp
{
    [super setUp];
    
    self.currentDate = [NSDate date];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEpochTimeToDate
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:1];
    
    NSTimeInterval timeInterval = date.timeIntervalSince1970;
    NSDate *epochDate = [NSDate dateWithEpochTime:[NSNumber numberWithDouble:timeInterval]];
    
    XCTAssertEqual(date, epochDate);
}

- (void)testExpirationStringExpired
{
    NSTimeInterval oneSecondPast = -1.0;
    [self assertExpirationTimeInterval:oneSecondPast matchesExpectedExpirationString:Expiration_Time_Expired];
}

- (void)testExpirationString1Min
{
    NSTimeInterval oneMinuteBefore = 60.0;
    [self assertExpirationTimeInterval:oneMinuteBefore matchesExpectedExpirationString:Expiration_Time_Less_Than_A_Minute];
}

- (void)testExpirationString2Mins
{
    NSTimeInterval twoMinutesBefore = 60.0 * 2;
    [self assertExpirationTimeInterval:twoMinutesBefore matchesExpectedExpirationString:@"＜2 mins"];
}

- (void)testExpirationString59Mins59Secs
{
    NSTimeInterval twoMinutesBefore = (60.0 * 59) + 59.0;
    [self assertExpirationTimeInterval:twoMinutesBefore matchesExpectedExpirationString:@"＜59 mins"];
}

- (void)testExpirationString1Hour
{
    NSTimeInterval oneHourBefore = (60.0 * 60);
    [self assertExpirationTimeInterval:oneHourBefore matchesExpectedExpirationString:@"＜1 hour"];
}

- (void)testExpirationString23Hours59Mins
{
    NSTimeInterval oneHourBefore = (60.0 * 60 * 23) + (60.0 * 59);
    [self assertExpirationTimeInterval:oneHourBefore matchesExpectedExpirationString:@"＜23 hours"];
}

- (void)testExpirationString1Day
{
    NSTimeInterval oneDayBefore = (60.0 * 60 * 24);
    [self assertExpirationTimeInterval:oneDayBefore matchesExpectedExpirationString:@"＜1 day"];
}

- (void)testExpirationString2Days
{
    NSTimeInterval oneDayBefore = (60.0 * 60 * 24 * 2);
    [self assertExpirationTimeInterval:oneDayBefore matchesExpectedExpirationString:@"＜2 days"];
}

- (void)assertExpirationTimeInterval:(NSTimeInterval)timeInterval matchesExpectedExpirationString:(NSString *)expectedExpirationStr
{
    NSDate *date = [self.currentDate dateByAddingTimeInterval:timeInterval];
    XCTAssertEqualObjects(expectedExpirationStr, [NSString stringWithExpirationDate:date currentDate:self.currentDate]);
}

@end
