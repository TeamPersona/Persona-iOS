//
//  CustomTextField.m
//  Persona
//
//  Created by Denny Kim on 2015-07-15.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self setNeedsLayout];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

@end
