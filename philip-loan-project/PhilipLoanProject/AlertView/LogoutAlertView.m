//
//  LogoutAlertView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/10.
//

#import "LogoutAlertView.h"

@implementation LogoutAlertView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        self.layer.cornerRadius = 12;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 21, self.width - 30, 18)];
        [titleLabel pp_setPropertys:@[@"Are you sure?",@(NSTextAlignmentCenter),kFontSize(18),kBlackColor_333333]];
        [self addSubview:titleLabel];
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 21 + titleLabel.bottom, self.width - 30, 43)];
        [infoLabel pp_setPropertys:@[@"you want to leave the software?",@(NSTextAlignmentCenter),kBoldFontSize(16),kBlackColor_333333]];
        [self addSubview:infoLabel];
        infoLabel.numberOfLines = 0;
        self.infoLabel = infoLabel;
        
        NSArray *array = @[@"Confirm",@"Cancel"];
        CGFloat itemWidth = self.width / 2;
        for (int i = 0; i < array.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0 + itemWidth * i, self.height - 47, itemWidth, 47);
            [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = kFontSize(16);
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.tag = 100 + i;
            if (i == 0) {
                [button setTitleColor:kHexColor(0x444444) forState:UIControlStateNormal];
            }else
            {
                [button setTitleColor:kBlueColor_0053FF forState:UIControlStateNormal];
            }
            [self addSubview:button];
        }
    }
    return self;
}
-(void)btnAction:(UIButton *)btn
{
    [self plp_dismiss];
    NSInteger index = btn.tag - 100;
    if (self.tapBlk) {
        self.tapBlk(index);
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
