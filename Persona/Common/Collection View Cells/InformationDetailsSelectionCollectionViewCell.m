//
//  InformationDetailsSelectionCollectionViewCell.m
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationDetailsSelectionCollectionViewCell.h"
#import "UIColor+ProjectColors.h"

@implementation InformationDetailsSelectionCollectionViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor personaLightColor];
    self.layer.cornerRadius = 6.0;
    self.layer.masksToBounds = YES;
    self.optionLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.backgroundColor = (selected) ? [UIColor personaAltColor] : [UIColor personaLightColor];
    self.optionLabel.textColor = (selected) ? [UIColor blackColor] : [UIColor whiteColor];
}

@end
