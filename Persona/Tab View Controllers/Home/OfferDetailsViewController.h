//
//  OfferDetailsViewController.h
//  Persona
//
//  Created by Denny Kim on 2015-06-24.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

@interface OfferDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *partnerImageView;
@property (weak, nonatomic) IBOutlet UILabel *partnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *participantsLabel;

@property (weak, nonatomic) IBOutlet UITextView *filterCategoriesTextView;
@property (weak, nonatomic) IBOutlet UITextView *requestedCategoriesTextView;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;

@property (weak, nonatomic) IBOutlet UIButton *participateButton;
@property (weak, nonatomic) IBOutlet UILabel *eligibilityLabel;

// Layout Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterCategoriesTextViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterCategoriesTextViewWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *requestedCategoriesTextViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *requestedCategoriesTextViewWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailsTextViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailsTextViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailsTextViewTopConstraint;

// Methods
- (id)initWithOffer:(Offer *)offer;

@end
