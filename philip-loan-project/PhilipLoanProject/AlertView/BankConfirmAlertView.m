//
//  BankConfirmAlertView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/10.
//

#import "BankConfirmAlertView.h"

@implementation BankConfirmAlertView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        self.layer.cornerRadius = 12;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, self.width - 32, 68)];
        [self addSubview:titleLabel];
        [titleLabel pp_setPropertys:@[@"Please confrm your withdrawal account informationbelongs to yourself and is correct",kFontSize(16),kBlackColor_333333]];
        titleLabel.numberOfLines = 0;
        
        NSArray *array = @[@"Channel/Bank:",@"Account number:"];
        for (int i = 0; i < array.count; i++) {
            UILabel *tipLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, titleLabel.bottom +  25 + (23 + 58) * i, self.width - 40, 23)];
            [tipLabel1 pp_setPropertys:@[array[i],kFontSize(16),kBlackColor_333333]];
            [self addSubview:tipLabel1];
            
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, tipLabel1.bottom + 6, self.width - 40, 36)];
            view1.backgroundColor = kHexColor(0xF2F2F2);
            view1.layer.cornerRadius = 9;
            view1.layer.borderColor = kGrayColor_999999.CGColor;
            view1.layer.borderWidth = 1;
            [self addSubview:view1];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, view1.width - 26, view1.height)];
            [label pp_setPropertys:@[kFontSize(14),kBlackColor_333333]];
            [view1 addSubview:label];
            if (i == 0) {
                self.label1 = label;
            }else
            {
                self.label2 = label;
            }
        }
        NSArray *array2 = @[@"Replace",@"Comfirm"];
        CGFloat itemWidth = self.width / 2.0;
        for (int i = 0; i < array.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0 + itemWidth * i, self.height - 47, itemWidth, 47);
            [button setTitle:array2[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            if (i == 0) {
                self.replaceButton = button;
                [button setTitleColor:kGrayColor_999999 forState:UIControlStateNormal];
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(itemWidth, self.height - 21 - 13, 1, 21)];
                lineView.backgroundColor = kHexColor(0xd3d3d3);
                [self addSubview:lineView];
                
            }else
            {
                [button setTitleColor:kBlueColor_0053FF forState:UIControlStateNormal];
                self.confirmButton = button;
            }
        }
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 47, self.width, 1)];
        lineView.backgroundColor = kHexColor(0xeeeeee);
        [self addSubview:lineView];
    }
    return self;
}

-(void)handleButtonAction:(UIButton *)button
{
    [self plp_dismiss];
    if ([button isEqual:self.replaceButton]) {
        
    }else
    {
        if (self.tapBtnBlk) {
            self.tapBtnBlk(1);
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
