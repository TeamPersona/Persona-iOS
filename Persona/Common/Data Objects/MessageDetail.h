//
//  MessageDetail.h
//  Persona
//
//  Created by Denny Kim on 2016-03-15.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MessageDetailType) {
    MessageDetailTypeText,
    MessageDetailTypeImage,
    MessageDetailTypeImageText
};

@interface MessageDetail : NSObject

@property (nonatomic) MessageDetailType type;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic) BOOL isUsersMessage;

@end
