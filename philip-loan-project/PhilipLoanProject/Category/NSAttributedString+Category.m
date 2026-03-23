//
//  NSAttributedString+Category.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/26.
//

#import "NSAttributedString+Category.h"

@implementation NSAttributedString (Category)
-(CGFloat)width
{
    return [self boundingRectWithSize:CGSizeMake(9999, 10) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine context:nil].size.width;
}
-(CGFloat)heightWithWidth:(CGFloat)width
{
    return [self boundingRectWithSize:CGSizeMake(width, 999) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine context:nil].size.height;
}
-(CGFloat)yy_heightWithAttrString:(NSAttributedString *)attr width:(CGFloat)width
{
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(width, 9999) text:self];
    return layout.textBoundingSize.height;
}
@end
