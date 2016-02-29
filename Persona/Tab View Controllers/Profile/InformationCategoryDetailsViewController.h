//
//  InformationCategoryDetailsViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-02-25.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationCategoryDetailsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (id)initWithCategoryTitle:(NSString *)title;

@end
