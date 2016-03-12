//
//  InformationCategoryDetailsViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationCategory.h"
#import "InformationDetailsViewController.h"
#import "InformationManualEntryViewController.h"

@interface InformationCategoryDetailsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, InformationDetailsPopupDelegate, InformationEntryDelegate>

@property (nonatomic, strong) InformationCategory *infoCategory;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (id)initWithInfoCategory:(InformationCategory *)category;

@end
