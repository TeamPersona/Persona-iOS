//
//  ProfileTierCollectionViewCell.m
//  Persona
//
//  Created by Denny Kim on 2015-07-21.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileTierCollectionViewCell.h"
#import "UIColor+ProjectColors.h"

@implementation ProfileTierCollectionViewCell

- (void)awakeFromNib
{
}

- (void)setProgressPercent:(CGFloat)progressPercent
{
    _progressPercent = progressPercent;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Progress
    CGContextSetLineWidth(context, ProfileTierProgressCircleLineWidth / 2);
    CGContextSetStrokeColorWithColor(context, [UIColor personaAltColor].CGColor);
    CGRect fRect = CGRectInset(self.tierImageView.frame, 8.0f, 8.0f);
    CGRect progressCircleRect = CGRectInset(fRect, ProfileTierProgressCircleDelta, ProfileTierProgressCircleDelta);
    
    CGFloat progressCircleRadius = progressCircleRect.size.width / 2;
    CGFloat progressInRadians = self.progressPercent * 2 * M_PI;
    
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, self.tierImageView.center.x, self.tierImageView.center.y, progressCircleRadius, 3 * M_PI_2, progressInRadians - (M_PI_2), 0);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
    
    // Circle context
    CGContextSetLineWidth(context, ProfileTierOutlineLineWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor personaLightColor].CGColor);
    
    // Outer circle
    CGRect outerCircleRect = CGRectInset(fRect, ProfileTierOuterCircleDelta, ProfileTierOuterCircleDelta);
    CGContextStrokeEllipseInRect(context, outerCircleRect);
    
    // Inner circle
    CGRect innerCircleRect = CGRectInset(fRect, ProfileTierInnerCircleDelta, ProfileTierInnerCircleDelta);
    CGContextStrokeEllipseInRect(context, innerCircleRect);
}



@end
