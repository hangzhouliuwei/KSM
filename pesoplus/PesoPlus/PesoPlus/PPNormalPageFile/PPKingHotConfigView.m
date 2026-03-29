//
//  PPKingHotConfigView.m
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import "PPKingHotConfigView.h"

@implementation PPKingHotConfigView
+ (UIButton *)normalBtn:(CGRect)frame title:(NSString *)title font:(int)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor = MainColor;
    btn.titleLabel.font = FontCustom(font);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn showAddToRadius:frame.size.height/2];
    return btn;
}
@end
