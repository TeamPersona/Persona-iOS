//
//  ImageManager.m
//  Persona
//
//  Created by Denny Kim on 2016-02-19.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "ImageManager.h"
#import <SDImageCache.h>
#import <SDWebImageDownloader.h>

static NSString *ImageCacheNamespaceURLs = @"com.uwpib.persona.imageCache.URLs";
static NSString *ImageCacheNamespaceLocal = @"com.uwpib.persona.imageCache.local";

@interface ImageManager()

@property (nonatomic, strong) SDImageCache *webImageCache;
@property (nonatomic, strong) SDImageCache *localImageCache;

@end

@implementation ImageManager

+ (ImageManager *)sharedManager
{
    static ImageManager *manager;
    static dispatch_once_t initManager;
    dispatch_once(&initManager, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.webImageCache = [[SDImageCache alloc] initWithNamespace:ImageCacheNamespaceURLs];
        self.localImageCache = [[SDImageCache alloc] initWithNamespace:ImageCacheNamespaceLocal];
    }
    return self;
}

- (void)getImageName:(NSString *)imgName iconSize:(CGSize)size completion:(ImageCompletionBlock)completionBlock
{
    NSString *imgStr = [NSString stringWithFormat:@"%@%f%f", imgName, size.width, size.height];
    UIImage *img = [self.localImageCache imageFromDiskCacheForKey:imgStr];
    if (img == nil) {
        UIImage *newImage = [self scaleImage:[UIImage imageNamed:imgName] fitToSize:size];
        [self.localImageCache storeImage:newImage forKey:imgStr];
        completionBlock(newImage);
    } else {
        completionBlock(img);
    }
}

- (void)getWebImage:(NSURL *)url iconSize:(CGSize)size completion:(ImageCompletionBlock)completionBlock
{
    NSString *imgStr = [NSString stringWithFormat:@"%@%f%f", url.absoluteString, size.width, size.height];
    UIImage *img = [self.webImageCache imageFromDiskCacheForKey:imgStr];
    if (img == nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
            [downloader downloadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image && finished) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *newImage = [self scaleImage:image fitToSize:size];
                        [self.webImageCache storeImage:newImage forKey:imgStr];
                        completionBlock(newImage);
                    });
                } else if (error) {
                    completionBlock(nil);
                }
            }];
        });
    } else {
        completionBlock(img);
    }
}

- (UIImage *)scaleImage:(UIImage *)img fitToSize:(CGSize)size
{
    CGRect newImgRect;
    CGSize newSize;
    CGSize imgSize = img.size;
    CGFloat aspectRatio = imgSize.width / imgSize.height;
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    if (scale > 1) {
        size = CGSizeMake(size.width * scale, size.height * scale);
    }
    
    if (size.width / aspectRatio <= size.height) {
        newSize.width = size.width;
        newSize.height = newSize.width / aspectRatio;
    } else {
        newSize.height = size.height;
        newSize.width = newSize.height * aspectRatio;
    }
    // Center the image.
    if (newSize.width < size.width) {
        newImgRect = CGRectMake((size.width - newSize.width)/2, 0, newSize.width, newSize.height);
    } else {
        newImgRect = CGRectMake(0, (size.height - newSize.height)/2, newSize.width, newSize.height);
    }

    UIGraphicsBeginImageContext(size);
    [img drawInRect:newImgRect];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

@end
