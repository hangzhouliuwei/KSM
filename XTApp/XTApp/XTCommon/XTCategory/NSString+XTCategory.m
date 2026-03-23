//
//  NSString+XTCategory.m
//  XTApp
//
//  Created by xia on 2024/7/12.
//

#import "NSString+XTCategory.h"

@implementation NSString (XTCategory)

- (NSString *)xt_trimPhoneNumber {
    return [[self stringByReplacingOccurrencesOfString:@"-" withString:@""]
             stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 url中文转义
 */
- (NSString *)xt_encodeString{
    if (self.length == 0) {
        return @"";
    }
    NSString *encodedString = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodedString;
}

/**
 iOS中十六进制的颜色（以#开头）转换为UIColor
 */
-(UIColor *)xt_hexColor{
    if (self.length == 0) {
        return nil;
    }
    NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀并剪切掉
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

/**
 判断有效url
 */
+ (BOOL)xt_isValidateUrl:(NSString *)str {
    NSString *regex = @"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]";
    NSPredicate *url = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [url evaluateWithObject:str];
}

/**
 按照num均分 并用link连接重新组合成string
 */
- (NSString *)xt_average:(NSInteger)num link:(NSString *)link {
    if([NSString xt_isEmpty:self]) {
        return @"";
    }
    if(num == 0){
        return self;
    }
    if(!link){
        link = @"";
    }
    NSInteger row = self.length / num;
    if(row == 0){
        return self;
    }
    NSMutableArray *arr = [NSMutableArray array];
    
    for(NSInteger i = 0 ; i < row ; i ++){
        NSRange range = NSMakeRange(i * num, num);
        NSString *str = [self substringWithRange:range];
        [arr addObject:str];
        if(i == (row - 1) && i * num < self.length) {
            NSInteger remainder = self.length % num;
            NSString *remainderStr = [self substringFromIndex:self.length - remainder];
            [arr addObject:remainderStr];
        }
    }
    return [arr componentsJoinedByString:link];
}

+ (NSAttributedString *)xt_strs:(NSArray <NSString *>*)strs
                          fonts:(NSArray <UIFont *>*)fonts
                         colors:(NSArray <UIColor *>*)colors {
    if(strs.count == 0 || strs.count != fonts.count || strs.count != colors.count){
        return [[NSAttributedString alloc] init];
    }
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    for(NSInteger i = 0 ; i < strs.count ; i ++) {
        [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:strs[i] attributes:@{
            NSFontAttributeName:fonts[i],
            NSForegroundColorAttributeName:colors[i],
        }]];
    }
    return attStr;
}

//截取前三后三中间***
- (NSString *)xt_phonePrivacy {
    if([NSString xt_isEmpty:self] || self.length < 7) {
        return self;
    }
    NSMutableString *str = [NSMutableString string];
    [str appendString:[self substringToIndex:3]];
    for(NSInteger i = 0 ; i < (self.length - 6) ; i ++ ) {
        [str appendString:@"*"];
    }
    [str appendString:[self substringFromIndex:self.length - 3]];
    return str;
}

/**
 是否为空
 */
+ (BOOL)xt_isEmpty:(NSString *)string {
    if(![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if ([string caseInsensitiveCompare:@"null"] == NSOrderedSame) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    if([string isEqualToString: @"(null)"]){
        return YES;
    }
    return NO;
}

@end
