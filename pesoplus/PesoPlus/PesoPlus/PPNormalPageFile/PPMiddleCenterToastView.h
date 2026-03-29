//
//  PPMiddleCenterToastView.h
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPMiddleCenterToastView : NSObject

+ (void)show:(NSString *)string;
+ (void)show:(NSString *)string time:(NSTimeInterval)time;

@end

NS_ASSUME_NONNULL_END
