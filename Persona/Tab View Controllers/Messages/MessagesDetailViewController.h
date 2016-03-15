//
//  MessagesDetailViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessagesDetailViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (id)initWithMessage:(Message *)message;

@end
