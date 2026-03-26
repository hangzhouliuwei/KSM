//
//  UIImage+util.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "UIImage+util.h"

@implementation UIImage (util)
+ (NSData *)scaleBiteDataImage:(UIImage *)image toKBite:(NSInteger)kbite {
    if (!image) {
        return nil;
    }
    kbite*=1024;
    CGFloat scale = 0.9f;
    CGFloat maxScale = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, scale);
    while ([imageData length] > kbite && scale > maxScale) {
        scale -= 0.1;
        imageData = UIImageJPEGRepresentation(image, scale);
    }
    return imageData;
}
@end
