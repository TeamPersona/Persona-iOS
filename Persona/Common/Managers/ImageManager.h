//
//  ImageManager.h
//  Persona
//
//  Created by Denny Kim on 2016-02-19.
//  Copyright © 2016 Persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageManager : NSObject

typedef void(^ImageCompletionBlock)(UIImage *image);

+ (ImageManager *)sharedManager;

- (void)getImageName:(NSString *)imgName iconSize:(CGSize)size completion:(ImageCompletionBlock)completionBlock;
- (void)getWebImage:(NSURL *)url iconSize:(CGSize)size completion:(ImageCompletionBlock)completionBlock;

@end
