//
//  BankHeaderView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/10.
//

#import "BankHeaderView.h"

@implementation BankHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = @[@"E-Wallet",@"Bank"];
        CGFloat itemWidth = self.width / 2.0;
        CGFloat itemHeight = self.height;
        for (int i = 0; i < array.count; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth * i, 0, itemWidth, itemHeight)];
            label.tag = 100 + i;
            label.userInteractionEnabled = true;
            label.backgroundColor = kHexColor(0xeeeee);
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelTapgestureAction:)]];
            [label pp_setPropertys:@[@(NSTextAlignmentCenter),kFontSize(16),array[i],kBlackColor_333333]];
            [self addSubview:label];
            if (i == 0) {
                label.textColor = kBlueColor_0053FF;
                label.backgroundColor = kWhiteColor;
            }
        }
        self.tipView = [[UIView alloc] initWithFrame:CGRectMake((itemWidth - 40) / 2.0, 43, 40, 3)];
        _tipView.backgroundColor = kBlueColor_0053FF;
        [self addSubview:self.tipView];
    }
    return self;
}
-(void)handelTapgestureAction:(UITapGestureRecognizer *)tapG
{
    UILabel *label = tapG.view;
    NSInteger index = label.tag - 100;
    if (index != self.index) {
        [self configureHilightStyle:label];
        self.index = label.tag - 100;
        if (self.tapIndex) {
            self.tapIndex(self.index);
        }
    }
}
-(void)setIndex:(NSInteger)index
{
    _index = index;
    UILabel *label = [self viewWithTag:100 + index];
    [self configureHilightStyle:label];
}
-(void)configureHilightStyle:(UILabel *)label
{
    label.textColor = kBlueColor_0053FF;
    if (label.tag == 100) {
        UILabel *oldLabel = [self viewWithTag: 101];
        oldLabel.textColor = kBlackColor_333333;
        oldLabel.backgroundColor = kHexColor(0xeeeeee);
    }else
    {
        UILabel *oldLabel = [self viewWithTag: 100];
        oldLabel.textColor = kBlackColor_333333;
        oldLabel.backgroundColor = kHexColor(0xeeeeee);
    }
    label.textColor = kBlueColor_0053FF;
    label.backgroundColor = kWhiteColor;
    self.tipView.centerX = label.centerX;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
