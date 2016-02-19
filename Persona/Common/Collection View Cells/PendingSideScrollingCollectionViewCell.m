//
//  PendingSideScrollingCollectionViewCell.m
//  Persona
//
//  Created by Denny Kim on 2016-02-16.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "PendingSideScrollingCollectionViewCell.h"
#import "DateFormatManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PendingSideScrollingCollectionViewCell

- (void)awakeFromNib
{
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect inRect = CGRectInset(rect, 4.0f, 4.0f);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:inRect cornerRadius:5.0f];
    path.lineWidth = 1.0f;
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    [path stroke];
}

- (void)setOffer:(Offer *)offer
{
    [self.partnerImageView sd_setImageWithURL:offer.partner.partnerImageURL];
    self.partnerTitleLabel.text = offer.partner.name;
    
    self.pendingLabel.text = [NSString stringWithFormat:@"%@ pending", offer.rewardString];
    self.expirationDateLabel.text = [[DateFormatManager sharedManager] formatToShortDateString:offer.expirationDate];
}

@end
