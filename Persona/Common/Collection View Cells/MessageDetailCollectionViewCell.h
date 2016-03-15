//
//  MessageDetailCollectionViewCell.h
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDetail.h"

static NSString *MessageDetailCollectionViewCellIdentifier = @"messageDetail";

@interface MessageDetailCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
