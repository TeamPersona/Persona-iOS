//
//  MessagesDataSource.h
//  Persona
//
//  Created by Denny Kim on 2016-03-01.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MessagesDataSource : NSObject <UITableViewDataSource>

- (id)initWithMessages:(NSArray *)messages;
- (void)updateWithMessages:(NSArray *)messages;

@end
