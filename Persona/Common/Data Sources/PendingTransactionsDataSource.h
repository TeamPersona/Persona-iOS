//
//  PendingTransactionsDataSource.h
//  Persona
//
//  Created by Denny Kim on 2016-01-11.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PendingTransactionsDataSource : NSObject <UICollectionViewDataSource>

- (id)initWithPendingTransactions:(NSArray *)pendingTransactions;

@property (nonatomic, strong) NSArray *pendingTransactions;

@end
