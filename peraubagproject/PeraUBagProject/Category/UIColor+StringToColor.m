//
//  UIColor+StringToColor.m
//  PerabagProject
//
//  Created by 刘巍 on 2023/11/10.
//

#import "UIColor+StringToColor.h"

@implementation UIColor (StringToColor)

/*
 * 调整当前颜色的透明度，获取新的颜色对象
 * colorString : 字符串支持rgb 和 argb 格式 前缀可以使用‘#’和'0X'
 */
+ (UIColor *)getColorWithColorString:(NSString *)colorString 
{
    // 获取当前颜色字符串对应的argb数据
    NSDictionary *argb = [self getColorARGBWithColorString:colorString];
    int a = [argb[@"a"] intValue];
    int r = [argb[@"r"] intValue];
    int g = [argb[@"g"] intValue];
    int b = [argb[@"b"] intValue];
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a / 255.0f];
}

// 颜色解析
+ (NSDictionary *)getColorARGBWithColorString:(NSString *)colorString 
{
    if ((colorString.length == 10 && [colorString.uppercaseString hasPrefix:@"0X"]) || (colorString.length == 9 && [colorString hasPrefix:@"#"])) {
        // 1.当前是argb格式 OXFFFFFFFF 或者 #FFFFFFFF
        if ([colorString hasPrefix:@"#"]) {
            colorString = [colorString substringFromIndex:1];
        } else {
            colorString = [colorString substringFromIndex:2];
        }
        NSString *alphaString = [colorString substringWithRange:NSMakeRange(0, 2)];
        //透明度
        NSString *redString = [colorString substringWithRange:NSMakeRange(2, 2)];
        NSString *greenString = [colorString substringWithRange:NSMakeRange(4, 2)];
        NSString *blueString = [colorString substringWithRange:NSMakeRange(6, 2)];
        unsigned int a, r, g, b;
        [[NSScanner scannerWithString:alphaString] scanHexInt:&a];
        [[NSScanner scannerWithString:redString] scanHexInt:&r];
        [[NSScanner scannerWithString:greenString] scanHexInt:&g];
        [[NSScanner scannerWithString:blueString] scanHexInt:&b];
        return @{@"a": @(a),@"r": @(r), @"g": @(g), @"b": @(b)};
    } else if ((colorString.length == 8 && [colorString.uppercaseString hasPrefix:@"0X"]) || (colorString.length == 7 && [colorString hasPrefix:@"#"])) {
        // 1.当前是rgb格式 OXFFFFFF 或者 #FFFFFF
        if ([colorString hasPrefix:@"#"]) {
            colorString = [colorString substringFromIndex:1];
        } else {
            colorString = [colorString substringFromIndex:2];
        }
        NSString *redString = [colorString substringWithRange:NSMakeRange(0, 2)];
        NSString *greenString = [colorString substringWithRange:NSMakeRange(2, 2)];
        NSString *blueString = [colorString substringWithRange:NSMakeRange(4, 2)];
        unsigned int r, g, b;
        [[NSScanner scannerWithString:redString] scanHexInt:&r];
        [[NSScanner scannerWithString:greenString] scanHexInt:&g];
        [[NSScanner scannerWithString:blueString] scanHexInt:&b];
        return @{@"a": @(255),@"r": @(r), @"g": @(g), @"b": @(b)};
    } else {
        return @{@"a": @(255),@"r": @(255), @"g": @(255), @"b": @(255)};
    }
}

@end
