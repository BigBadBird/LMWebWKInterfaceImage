//
//  LMWebWKInterfaceImage.m
//  LMWebWKInterfaceImage
//
//  Created by Mikhail Lutsky on 03.11.16.
//  Copyright © 2016 BigBadBird. All rights reserved.
//

#import "LMWebWKInterfaceImage.h"

@implementation WKInterfaceImage (LMWebWKInterfaceImage)
- (void)setImageWithURL:(NSURL *)url {
    __block WKInterfaceImage *weakself = self;
    [self setImageWithURL:url completion:^(UIImage*image){[weakself setImage:image];}];
}
- (void)setImageWithURL:(NSURL *)url completion:(void (^)(UIImage *image))completionBlock {
    NSString *imageName = url.absoluteString;
    UIImage *image = [self fetchImageWithName:imageName];
    if (image != nil) {
        completionBlock(image);
    }
    else {
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [self saveImageData:data withName:imageName];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionBlock([UIImage imageWithData:data]);
            });
        }] resume];
    }
}

- (void)saveImageData:(NSData *)imageData withName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:name];
    [imageData writeToFile:savedImagePath atomically:NO];
}

- (UIImage *)fetchImageWithName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:name];
    NSData *pngData = [NSData dataWithContentsOfFile:savedImagePath];
    return [UIImage imageWithData:pngData];
}
@end
