//
//  PPIDFVManagerTools.h
//  LuckyLoan
//
//  Created by jacky on 2024/2/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPIDFVManagerTools : UIView

+ (void)save:(NSString *)service data:(id)data;
 
+ (id)load:(NSString *)service;
 
+ (void)delete:(NSString *)service;
 
+ (NSString *)ppConfiggetIDFV;

@end

NS_ASSUME_NONNULL_END
