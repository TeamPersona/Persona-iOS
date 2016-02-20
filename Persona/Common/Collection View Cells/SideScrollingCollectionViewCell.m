//
//  SideScrollingCollectionViewCell.m
//  Persona
//
//  Created by Denny Kim on 2016-01-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "SideScrollingCollectionViewCell.h"
#import "NSDate+EpochTime.h"
#import "DateFormatManager.h"
#import "ImageManager.h"

static NSString *MESSAGE_READ_IMAGE_NAME = @"EnvelopeRead";
static NSString *MESSAGE_UNREAD_IMAGE_NAME = @"EnvelopeUnread";

@implementation SideScrollingCollectionViewCell

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
    self.partnerImageView.image = nil;
    self.messageImageView.image = nil;
    
    [[ImageManager sharedManager] getWebImage:offer.partner.partnerImageURL iconSize:CGSizeMake(62, 62) completion:^(UIImage *image) {
        self.partnerImageView.image = image;
    }];
    self.partnerTitleLabel.text = offer.partner.name;
    
    self.earnedLabel.text = [NSString stringWithFormat:@"%@ earned!", offer.rewardString];
    self.dateEarnedLabel.text = [[DateFormatManager sharedManager] formatToShortDateString:offer.expirationDate];
    
    NSString *imgName;
    if (offer.didReadMessage) {
        imgName = MESSAGE_READ_IMAGE_NAME;
    } else {
        imgName = MESSAGE_UNREAD_IMAGE_NAME;
    }
    
    [[ImageManager sharedManager] getImageName:imgName iconSize:self.messageImageView.bounds.size completion:^(UIImage *image) {
        self.messageImageView.image = image;
    }];
}

@end
