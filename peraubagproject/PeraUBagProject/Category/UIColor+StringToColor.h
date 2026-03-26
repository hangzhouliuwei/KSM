//
//  UIColor+StringToColor.h
//  PerabagProject
//
//  Created by 刘巍 on 2023/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (StringToColor)
/*
 * 调整当前颜色的透明度，获取新的颜色对象
 * colorString : 字符串支持rgb 和 argb 格式 前缀可以使用‘#’和'0X'
 */
+ (UIColor *)getColorWithColorString:(NSString *)colorString;

@end

NS_ASSUME_NONNULL_END
