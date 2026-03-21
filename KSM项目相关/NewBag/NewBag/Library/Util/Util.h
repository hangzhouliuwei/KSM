//
//  Util.h
//  NewBag
//
//  Created by Jacky on 2024/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject
+ (BOOL)isValidString:(NSString *)str;

+(NSDictionary*)getNowDeviceInfo;

+(NSURL*)loadImageUrl:(NSString*)imageUrl;

+ (UIImage *)imageResize:(UIImage*)img ResizeTo:(CGSize)newSize;

+(void)startNetWorkMonitor;

+ (UINib *)getNibFromeBundle:(NSString *)name;

+ (id)getSourceFromeBundle:(NSString *)name;

+ (NSBundle *)getBundle;

@end

NS_ASSUME_NONNULL_END
