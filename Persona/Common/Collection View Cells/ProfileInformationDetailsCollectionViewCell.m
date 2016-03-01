//
//  ProfileInformationDetailsCollectionViewCell.m
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "ProfileInformationDetailsCollectionViewCell.h"
#import "ImageManager.h"
#import "UIColor+ProjectColors.h"

@implementation ProfileInformationDetailsCollectionViewCell

- (void)awakeFromNib
{
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor personaLightColor];
    [[ImageManager sharedManager] getImageName:@"Checkmark" iconSize:self.checkmarkImageView.bounds.size completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.checkmarkImageView.image = image;
        });
    }];
}

@end
