//
//  MessageDetailCollectionViewCell.m
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "MessageDetailCollectionViewCell.h"

@implementation MessageDetailCollectionViewCell

- (void)awakeFromNib
{
    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = YES;
}

@end
