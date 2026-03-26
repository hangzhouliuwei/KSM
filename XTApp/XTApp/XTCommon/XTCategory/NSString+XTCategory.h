//
//  NSString+XTCategory.h
//  XTApp
//
//  Created by xia on 2024/7/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XTCategory)

/**
 过滤手机号里的特殊字符
 */
- (NSString *)xt_trimPhoneNumber;

/**
 url中文转义
 */
- (NSString *)xt_encodeString;

/**
 iOS中十六进制的颜色（以#开头）转换为UIColor
 */
-(UIColor *)xt_hexColor;

/**
 判断有效url
 */
+ (BOOL)xt_isValidateUrl:(NSString *)str;

/**
 按照num均分 并用link连接重新组合成string
 */
- (NSString *)xt_average:(NSInteger)num link:(NSString *)link;

/*
 自定义字体
 */
+ (NSAttributedString *)xt_strs:(NSArray <NSString *>*)strs
                          fonts:(NSArray <UIFont *>*)fonts
                         colors:(NSArray <UIColor *>*)colors;

//截取前三后三中间***
- (NSString *)xt_phonePrivacy;

/**
 是否为空
 */
+ (BOOL)xt_isEmpty:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
