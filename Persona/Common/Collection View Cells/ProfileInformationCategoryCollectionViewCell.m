//
//  ProfileInformationCategoryCollectionViewCell.m
//  Persona
//
//  Created by Denny Kim on 2015-07-20.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "ProfileInformationCategoryCollectionViewCell.h"
#import "UIColor+ProjectColors.h"

@implementation ProfileInformationCategoryCollectionViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor personaLightColor];
}

- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
}

@end
