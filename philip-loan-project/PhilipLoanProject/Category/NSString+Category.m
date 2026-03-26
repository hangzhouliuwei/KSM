//
//  NSString+Category.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/26.
//

#import "NSString+Category.h"


@implementation NSString (Category)



-(BOOL)isReal
{
    if (self == nil) {
        return NO;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (self.length == 0) {
        return NO;
    }
    return YES;
}



-(CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font
{
    return [self boundingRectWithSize:CGSizeMake(width, 9999) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size.height;
}
-(CGFloat)widthWithFont:(UIFont *)font
{
    return [self boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size.width;
}



@end



@implementation NSNull (Category)

-(BOOL)isReal
{
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return YES;
}
@end
