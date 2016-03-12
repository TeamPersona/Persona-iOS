//
//  InformationManualEntryViewController.h
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationDataListDataSource.h"

@protocol InformationEntryDelegate <NSObject>

- (void)informationDidFinishEntryWithData:(NSDictionary *)dataDict;
@optional
- (void)informationDidCancelManualEntry;

@end

@interface InformationManualEntryViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate>

- (id)initWithInformationSubCategory:(NSString *)subCategoryTitle;
- (id)initWithInformationSubCategory:(NSString *)subCategoryTitle existingData:(NSDictionary *)dataPoints;

@property (weak, nonatomic) IBOutlet UITextField *dataNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dataValueTextField;
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@property (nonatomic, assign) id <InformationEntryDelegate> delegate;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmButtonLC;
@end
