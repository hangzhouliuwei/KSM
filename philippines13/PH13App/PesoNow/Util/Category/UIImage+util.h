//
//  UIImage+util.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (util)
+ (NSData *)scaleBiteDataImage:(UIImage *)image toKBite:(NSInteger)kbite;
@end

NS_ASSUME_NONNULL_END
