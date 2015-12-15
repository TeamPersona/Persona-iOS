//
//  HeightCalculations.m
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SpacingAndSizingCalculations.h"

@interface HeightCalculations : XCTestCase

@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) NSInteger numItems;
@property (nonatomic) CGSize onePerRowCellSize;
@property (nonatomic) CGSize twoPerRowCellSize;
@property (nonatomic) UIEdgeInsets sectionInset;
@property (nonatomic) CGFloat minCellSpacing;

@end

@implementation HeightCalculations

- (void)setUp
{
    [super setUp];
    self.screenWidth = 320.0f;
    self.onePerRowCellSize = CGSizeMake(288.0f, 288.0f);
    self.twoPerRowCellSize = CGSizeMake(139.0f, 139.0f);
    self.sectionInset = UIEdgeInsetsMake(16.0f, 16.0f, 16.0f, 16.0f);
    self.minCellSpacing = 10.0f;
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testHeightBaseCaseOneCellPerRow
{
    CGFloat expectedHeight = self.onePerRowCellSize.height + self.sectionInset.top + self.sectionInset.bottom;
    [self assertHeight:expectedHeight numItems:1 cellSize:self.onePerRowCellSize];
}

- (void)testHeightBaseCaseTwoCellsPerRow
{
    CGFloat expectedHeight = self.twoPerRowCellSize.height + self.sectionInset.top + self.sectionInset.bottom;
    [self assertHeight:expectedHeight numItems:2 cellSize:self.twoPerRowCellSize];
}

- (void)testHeightTwoRowsAndOneCellPerRow {
    CGFloat expectedHeight = (self.onePerRowCellSize.height * 2) + self.sectionInset.top + self.sectionInset.bottom + self.minCellSpacing;
    [self assertHeight:expectedHeight numItems:2 cellSize:self.onePerRowCellSize];
}

- (void)testHeightTwoRowsAndTwoCellsPerRow {
    CGFloat expectedHeight = (self.twoPerRowCellSize.height * 2) + self.sectionInset.top + self.sectionInset.bottom + self.minCellSpacing;
    [self assertHeight:expectedHeight numItems:4 cellSize:self.twoPerRowCellSize];
}

- (void)assertHeight:(CGFloat)expectedHeight numItems:(NSInteger)numItems cellSize:(CGSize)cellSize
{
    XCTAssertEqual(expectedHeight, [SpacingAndSizingCalculations calculateScrollViewHeightForItemCount:numItems
                                                                                              maxWidth:self.screenWidth
                                                                                              cellSize:cellSize
                                                                                          sectionInset:self.sectionInset
                                                                                        minimumSpacing:self.minCellSpacing]
                   );
}

@end
