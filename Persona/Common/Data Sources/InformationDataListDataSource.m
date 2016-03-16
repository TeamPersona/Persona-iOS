//
//  InformationDataListDataSource.m
//  Persona
//
//  Created by Denny Kim on 2016-03-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "InformationDataListDataSource.h"
#import "InformationDataTableViewCell.h"
#import "NSString+CamelCase.h"

@implementation InformationDataListDataSource

- (id)init
{
    self = [super init];
    if (self) {
        self.dataPoints = [NSMutableDictionary new];
        self.canEdit = NO;
    }
    return self;
}

#pragma mark - UITableView DataSource Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationDataTableViewCellIdentifier forIndexPath:indexPath];
    
    NSString *key = self.dataPoints.allKeys[indexPath.row];
    cell.detailNameLabel.text = [NSString stringWithFormat:@"%@:", key];
    cell.detailDataLabel.text = self.dataPoints[key];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataPoints.allKeys.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.canEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        InformationDataTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.dataPoints removeObjectForKey:cell.detailNameLabel.text];
        [tableView reloadData];
    }
}

@end
