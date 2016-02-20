//
//  OfferDetailsViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-06-24.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "OfferDetailsViewController.h"
#import "NSString+ExpirationTime.h"
#import "ImageManager.h"

static NSString *OfferDetailsTitle =                    @"Offer Details";
static NSString *FilterCategoriesPrefixDescription =    @"Filtered by:";
static NSString *RequestedCategoriesPrefixDescription = @"You are sending:";
static NSString *EligiblityLabelPrefixDescription =     @"Please enter the required information before you can participate.";
static NSString *FilterNotMatchedPrefixDescription =    @"You are not eligible for this offer at the current moment.";

static const CGFloat TextViewPadding = 16.0f;

@interface OfferDetailsViewController ()
@property (nonatomic, strong) Offer *offer;
@end

@implementation OfferDetailsViewController

- (id)initWithOffer:(Offer *)offer
{
    self = [super init];
    if (self) {
        self.offer = offer;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = OfferDetailsTitle;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self populateViewInformation];
    [self updateDynamicLayoutConstraints];
}

- (void)populateViewInformation
{
    self.partnerImageView.image = nil;
    [[ImageManager sharedManager] getWebImage:self.offer.partner.partnerImageURL iconSize:CGSizeMake(56, 56) completion:^(UIImage *image) {
        if (image) {
            self.partnerImageView.image = image;
        }
    }];
    self.partnerLabel.text = self.offer.partner.name;
    
    NSString *expirationString = [NSString stringWithExpirationDate:self.offer.expirationDate currentDate:[NSDate date]];
    self.expirationDateLabel.text = expirationString;

    if ([expirationString isEqual:Expiration_Time_Less_Than_A_Minute]) {
        self.expirationDateLabel.textColor = [UIColor orangeColor];
    } else if (self.offer.isExpired) {
        self.expirationDateLabel.textColor = [UIColor redColor];
    }
    
    self.rewardLabel.text = self.offer.rewardString;
    self.participantsLabel.text = [NSString stringWithFormat:@"%li/%li participants", (long)self.offer.currentParticipants, self.offer.totalParticipants];
    self.progressView.progress = self.offer.participantsProgress;
    
    self.filterCategoriesTextView.attributedText = [self attributedStringWithInfo:self.offer.infoFilterList andDescription:FilterCategoriesPrefixDescription];
    self.requestedCategoriesTextView.attributedText = [self attributedStringWithInfo:self.offer.infoRequiredList andDescription:RequestedCategoriesPrefixDescription];
    self.detailsTextView.text = self.offer.offerDescription;
    
    if (self.offer.isEligible) {
        self.participateButton.hidden = NO;
        self.eligibilityLabel.hidden = YES;
    } else {
        self.participateButton.hidden = YES;
        self.eligibilityLabel.hidden = NO;
        
        NSString *text;
        if (!self.offer.isEligible) {
            text = [NSString stringWithFormat:@"%@", EligiblityLabelPrefixDescription];
        } else {
            text = [NSString stringWithFormat:@"%@", FilterNotMatchedPrefixDescription];
        }
        
        self.eligibilityLabel.text = text;
    }
}

- (void)updateDynamicLayoutConstraints
{
    CGFloat halfTextViewWidth = ([UIScreen mainScreen].bounds.size.width - TextViewPadding * 3) / 2;
    CGSize filterCategoriesTextViewHeight = [self.filterCategoriesTextView sizeThatFits:CGSizeMake(halfTextViewWidth, MAXFLOAT)];
    self.filterCategoriesTextViewHeightConstraint.constant = filterCategoriesTextViewHeight.height;
    self.filterCategoriesTextViewWidthConstraint.constant = halfTextViewWidth;
    
    CGSize requestedCategoriesTextViewHeight = [self.requestedCategoriesTextView sizeThatFits:CGSizeMake(halfTextViewWidth, MAXFLOAT)];
    self.requestedCategoriesTextViewHeightConstraint.constant = requestedCategoriesTextViewHeight.height;
    self.requestedCategoriesTextViewWidthConstraint.constant = halfTextViewWidth;
    
    CGFloat textViewWidth = ([UIScreen mainScreen].bounds.size.width - TextViewPadding * 2);
    CGSize detailsTextViewHeight = [self.detailsTextView sizeThatFits:CGSizeMake(textViewWidth, MAXFLOAT)];
    self.detailsTextViewHeightConstraint.constant = detailsTextViewHeight.height;
    self.detailsTextViewWidthConstraint.constant = textViewWidth;
    
    CGFloat filterCategoriesTextViewYCoord = self.filterCategoriesTextView.frame.origin.y + filterCategoriesTextViewHeight.height + TextViewPadding;
    CGFloat requestedCategoriesTextViewYCoord = self.requestedCategoriesTextView.frame.origin.y + requestedCategoriesTextViewHeight.height + TextViewPadding;
    self.detailsTextViewTopConstraint.constant = MAX(filterCategoriesTextViewYCoord, requestedCategoriesTextViewYCoord);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Offer Details String Formatter
/**
 Creates the attributed string for a list of personal info.
 
 @param infoList
    The categories parameter is a dictionary where the keys are NSStrings for the categories to list and the
    values are NSNumbers to indicate whether this type of information is missing from the user's profile.
 
 @param descriptionString
        The prefix string before listing the personal info types
 */
- (NSAttributedString *)attributedStringWithInfo:(NSArray *)infoDict andDescription:(NSString *)descriptionString
{
    NSDictionary *prefixStringAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]};
    NSDictionary *defaultStringAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]};
    NSDictionary *missingStringAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0f],
                                                      NSForegroundColorAttributeName: [UIColor colorWithRed:220.0/255.0 green:8.0/255.0 blue:8.0/255.0 alpha:1.0]};
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", descriptionString] attributes:prefixStringAttributes];
    
    for (NSDictionary *info in infoDict) {
        BOOL isMissing = [info[@"informationMissing"] boolValue];
        NSString *infoType = info[@"informationType"];
        NSDictionary *attributes = isMissing ? missingStringAttributes : defaultStringAttributes;
        
        NSMutableAttributedString *infoAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n• %@", infoType]];
        [infoAttrString setAttributes:attributes range:NSMakeRange(3, infoType.length)];
        [attrString appendAttributedString:infoAttrString];
    }
    
    return attrString;
}

@end
