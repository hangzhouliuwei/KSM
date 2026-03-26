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

@end

NS_ASSUME_NONNULL_END
