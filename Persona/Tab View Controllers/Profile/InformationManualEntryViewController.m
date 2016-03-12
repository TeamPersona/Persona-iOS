//
//  InformationManualEntryViewController.m
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationManualEntryViewController.h"
#import "NSString+CamelCase.h"
#import "InformationDataTableViewCell.h"

@interface InformationManualEntryViewController ()

@property (nonatomic, strong) NSString *subCategoryTitle;
@property (nonatomic, strong) InformationDataListDataSource *dataSource;
@property (nonatomic, strong) UITapGestureRecognizer *hideKeyboardGR;
@property (nonatomic) BOOL didUpdateDataPoints;
@end

@implementation InformationManualEntryViewController

- (id)initWithInformationSubCategory:(NSString *)subCategoryTitle
{
    return [self initWithInformationSubCategory:subCategoryTitle existingData:nil];
}

- (id)initWithInformationSubCategory:(NSString *)subCategoryTitle existingData:(NSDictionary *)dataPoints
{
    self = [super init];
    if (self) {
        self.subCategoryTitle = subCategoryTitle;
        self.dataSource = [InformationDataListDataSource new];
        self.dataSource.canEdit = YES;
        
        if (dataPoints != nil) {
            for (NSString *key in dataPoints.allKeys) {
                self.dataSource.dataPoints[key] = dataPoints[key];
            }
        }
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@ Entry", self.subCategoryTitle];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    
    // Add keyboard notifications.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.hideKeyboardGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    [self.view addGestureRecognizer:self.hideKeyboardGR];
    
    [self.dataTableView registerNib:[UINib nibWithNibName:@"InformationDataTableViewCell" bundle:nil] forCellReuseIdentifier:InformationDataTableViewCellIdentifier];
    self.dataTableView.tableFooterView = [UIView new];
    self.dataTableView.dataSource = self.dataSource;
    [self.dataTableView reloadData];
    self.didUpdateDataPoints = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view removeGestureRecognizer:self.hideKeyboardGR];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Methods
- (IBAction)addDataPointButtonPressed:(UIButton *)sender
{
    if (self.dataNameTextField.text.length > 0 && self.dataValueTextField.text.length > 0) {
        NSString *key = self.dataNameTextField.text;
        self.dataSource.dataPoints[key] = self.dataValueTextField.text;
        [self.dataTableView reloadData];

        // Reset data entry textfields.
        self.dataNameTextField.text = @"";
        self.dataValueTextField.text = @"";
        [self.dataNameTextField becomeFirstResponder];
    }
}

- (IBAction)confirmButtonPressed:(UIButton *)sender
{
    if (self.didUpdateDataPoints && self.dataSource.dataPoints.allKeys.count > 0 && [self.delegate respondsToSelector:@selector(informationDidFinishEntryWithData:)]) {
        [self.delegate informationDidFinishEntryWithData:self.dataSource.dataPoints];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelButtonPressed
{
    if ([self.delegate respondsToSelector:@selector(informationDidCancelManualEntry)]) {
        [self.delegate informationDidCancelManualEntry];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextField Delegate Methods
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField layoutIfNeeded];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.dataNameTextField]) {
        [self.dataValueTextField becomeFirstResponder];
    } else if ([textField isEqual:self.dataValueTextField]) {
        [self addDataPointButtonPressed:nil];
    }
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
    
    [self.view layoutIfNeeded];
    
    self.confirmButtonLC.constant = CGRectGetHeight(keyboardFinalFrame);
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:animationCurve
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    [self.view layoutIfNeeded];
    
    self.confirmButtonLC.constant = 0;
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:animationCurve
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                     }];
}

#pragma mark - Helper Methods
- (void)hideKeyboard
{
    [self.dataNameTextField resignFirstResponder];
    [self.dataValueTextField resignFirstResponder];
}

@end
