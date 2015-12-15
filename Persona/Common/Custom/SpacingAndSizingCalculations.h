//
//  SpacingAndSizingCalculations.h
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SpacingAndSizingCalculations : NSObject

+ (CGFloat)calculateScrollViewHeightForItemCount:(NSInteger)count maxWidth:(CGFloat)maxWidth cellSize:(CGSize)cellSize sectionInset:(UIEdgeInsets)sectionInset minimumSpacing:(CGFloat)minSpacing;

@end
