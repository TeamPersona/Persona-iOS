//
//  SpacingAndSizingCalculations.m
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "SpacingAndSizingCalculations.h"

@implementation SpacingAndSizingCalculations

+ (CGFloat)calculateScrollViewHeightForItemCount:(NSInteger)count maxWidth:(CGFloat)maxWidth cellSize:(CGSize)cellSize sectionInset:(UIEdgeInsets)sectionInset minimumSpacing:(CGFloat)minSpacing
{
    CGFloat availableWidth = maxWidth - sectionInset.left - sectionInset.right;
    NSInteger numCellsPerRow = availableWidth / cellSize.width;
    CGFloat remainingWidth = availableWidth - (numCellsPerRow * cellSize.width);
    
    if (remainingWidth < ((numCellsPerRow - 1) * minSpacing)) {
        numCellsPerRow--;
    }
    
    NSInteger numRows = count / numCellsPerRow;
    CGFloat totalCellHeight = numRows * cellSize.height;
    CGFloat totalCellVerticalSpacing = (numRows - 1) * minSpacing;
    CGFloat totalCellSectionInset = sectionInset.top + sectionInset.bottom;
    
    return totalCellHeight + totalCellVerticalSpacing + totalCellSectionInset;
}

@end