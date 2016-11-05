//
//  LMWebWKInterfaceImage.h
//  LMWebWKInterfaceImage
//
//  Created by Mikhail Lutsky on 03.11.16.
//  Copyright © 2016 BigBadBird. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface WKInterfaceImage (LMWebWKInterfaceImage)
- (void) setImageWithURL:(NSURL*) url;
- (void) setImageWithURL:(NSURL*) url completion:(void (^)(UIImage* image))completionBlock;

@end
