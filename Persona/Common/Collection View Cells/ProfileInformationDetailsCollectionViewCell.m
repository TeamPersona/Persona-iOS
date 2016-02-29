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

@interface ProfileInformationDetailsCollectionViewCell ()

@property (nonatomic, strong) UIImage *checkmarkImage;

@end

@implementation ProfileInformationDetailsCollectionViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor personaLightColor];
    [[ImageManager sharedManager] getImageName:@"Checkmark" iconSize:self.checkmarkImageView.bounds.size completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.checkmarkImage = image;
            self.checkmarkImageView.image = image;
        });
    }];
}

//- (void)prepareForReuse
//{
//    if (!self.checkmarkImageView.image) {
//        self.checkmarkImageView.image = self.checkmarkImage;
//    }
//}

@end
