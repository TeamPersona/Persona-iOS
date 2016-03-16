//
//  MessagesDetailViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "MessagesDetailViewController.h"
#import "MessageDetailDataSource.h"
#import "MessageDetailCollectionViewCell.h"
#import "SpacingAndSizingCalculations.h"
#import "Constants.h"

@interface MessagesDetailViewController ()

@property (nonatomic, strong) MessageDetailDataSource *dataSource;

@end

@implementation MessagesDetailViewController

- (id)initWithMessage:(Message *)message
{
    self = [super init];
    if (self) {
        // Add keyboard notifications.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        self.dataSource = [[MessageDetailDataSource alloc] initWithMessageDetails:message.messageDetails];
        self.title = message.partner.name;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MessageDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:MessageDetailCollectionViewCellIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self.dataSource;
}

- (void)viewDidLayoutSubviews
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:self.dataSource.msgDetails.count-1] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Methods
- (IBAction)sendButtonPressed:(UIButton *)sender
{
    NSMutableArray *msgs = [[NSMutableArray alloc] initWithArray:self.dataSource.msgDetails];
    MessageDetail *msgDetail = [[MessageDetail alloc] init];
    msgDetail.type = MessageDetailTypeText;
    msgDetail.text = self.messageTextField.text;
    msgDetail.timestamp = [NSDate new];
    msgDetail.isUsersMessage = YES;
    [msgs addObject:msgDetail];
    
    self.dataSource.msgDetails = msgs;
    [self.collectionView reloadData];
    
    self.messageTextField.text = @"";
}

#pragma mark - TextField Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendButtonPressed:nil];
    return YES;
}

#pragma mark - Keyboard Notifications
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSValue *finalFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFinalFrame = [self.view convertRect:finalFrameValue.CGRectValue fromView:nil];
    
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:animationCurve
                     animations:^{
                         self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, CGRectGetWidth(self.view.frame), CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(keyboardFinalFrame) - 16.0f);
                     } completion:^(BOOL finished) {
                         [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:self.dataSource.msgDetails.count-1] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:animationCurve
                     animations:^{
                         self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, CGRectGetWidth(self.view.frame), CGRectGetHeight([UIScreen mainScreen].bounds) - 65.0f);
                     } completion:^(BOOL finished) {
                     }];
}

#pragma mark - Collection View Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetail *msg = self.dataSource.msgDetails[indexPath.section];
    return [SpacingAndSizingCalculations calculateMessageLabelSize:msg.text];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    MessageDetail *msg = self.dataSource.msgDetails[section];
    CGSize cellSize = [SpacingAndSizingCalculations calculateMessageLabelSize:msg.text];
    CGFloat sidePadding = 22.0f;
    CGFloat topPadding = 8.0f;
    CGFloat bottomPadding = 8.0f;
    if (section > 0 && [self.dataSource.msgDetails[section-1] isUsersMessage] == msg.isUsersMessage) {
        topPadding = 2.0f;
    }
    
    if (section + 1 < self.dataSource.msgDetails.count && [self.dataSource.msgDetails[section+1] isUsersMessage] == msg.isUsersMessage) {
        bottomPadding = 2.0f;
    }
    
    if (msg.isUsersMessage) {
        return UIEdgeInsetsMake(topPadding, SCREEN_SIZE.width - (cellSize.width + sidePadding), bottomPadding, sidePadding);
    } else {
        return UIEdgeInsetsMake(topPadding, sidePadding, bottomPadding, SCREEN_SIZE.width - (cellSize.width + sidePadding));
    }
}

@end
