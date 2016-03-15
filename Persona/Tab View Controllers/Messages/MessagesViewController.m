//
//  MessagesViewController.m
//  Persona
//
//  Created by Denny Kim on 2015-06-23.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "MessagesViewController.h"
#import "Message.h"
#import "MessageDetail.h"
#import "MessagesManager.h"
#import "MessagesTableViewCell.h"
#import "MessagesDataSource.h"
#import "MessagesDetailViewController.h"

@interface MessagesViewController ()
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) MessagesDataSource *dataSource;
@end

@implementation MessagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"MessagesTableViewCell" bundle:nil] forCellReuseIdentifier:MessagesTableViewCellIdentifier];
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messagesManagerDidUpdateMessages) name:MessagesNotificationUpdatedMessages object:nil];
    [[MessagesManager sharedManager] updateMessages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Messages Manager Notification Methods
- (void)messagesManagerDidUpdateMessages
{
    self.messages = [[MessagesManager sharedManager] allMessages];

    if (!self.dataSource) {
        self.dataSource = [[MessagesDataSource alloc] initWithMessages:self.messages];
        self.tableView.dataSource = self.dataSource;
    } else {
        [self.dataSource updateWithMessages:self.messages];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Open messages details view controller
    Message *message = self.messages[indexPath.row];
    message.didRead = YES;
    
    MessagesDetailViewController *vc = [[MessagesDetailViewController alloc] initWithMessage:message];
    [self.navigationController pushViewController:vc animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.tableView reloadData];
}

@end
