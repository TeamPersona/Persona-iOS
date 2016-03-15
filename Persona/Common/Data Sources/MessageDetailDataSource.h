//
//  MessageDetailDataSource.h
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MessageDetailDataSource : NSObject <UICollectionViewDataSource>

- (id)initWithMessageDetails:(NSArray *)msgDetails;

@property (nonatomic, strong) NSArray *msgDetails;

@end
