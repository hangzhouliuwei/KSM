//
//  HoldAlertView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/29.
//

#import "HoldAlertView.h"

@implementation HoldAlertView


-(instancetype)initWithFrame:(CGRect)frame info:(nonnull NSString *)info
{
    CGFloat infoWidth = frame.size.width - 60;
    UIFont *infoFont = kFontSize(16);
    CGFloat height = [info heightWithWidth:infoWidth font:infoFont];
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.width, height + 185)];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self clipTopLeftAndTopRightCornerRadius:16];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.width, 25)];
        [self.titleLabel pp_setPropertys:@[@(NSTextAlignmentCenter), kBoldFontSize(18),@"Are you sure you want to leave?",kBlackColor_333333]];
        [self addSubview:self.titleLabel];
        
        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 26 + _titleLabel.bottom, infoWidth, height)];
        _infoLabel.numberOfLines = 0;
        [self.infoLabel pp_setPropertys:@[@(NSTextAlignmentCenter),infoFont ,info,kBlackColor_333333]];
        [self addSubview:self.infoLabel];
        
        NSArray *array = @[@"Confirm",@"Cancel"];
        CGFloat itemWidth = (self.width - 13 * 2 - 10) / 2.0;
        for (int i = 0; i < array.count; i++) {
            UIButton *button;
            if (i == 0) {
                button = [UIButton buttonWithType:UIButtonTypeCustom];
                self.confirmButton = button;
                button.frame = CGRectMake(13 + (itemWidth + 10) * i, self.height - 16 - 47, itemWidth, 47);
                [button setBackgroundImage:kImageName(@"alert_confirm_bg") forState:UIControlStateNormal];
                [button setTitleColor:kBlueColor_0053FF forState:UIControlStateNormal];
            }else
            {
                button = [[PLPCapsuleButton alloc] initWithFrame:CGRectMake(13 + (itemWidth + 10) * i, self.height - 16 - 47, itemWidth, 47)];
                [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
                self.cancelButton = button;
            }
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}
-(void)handleButtonAction:(UIButton *)button
{
    [self plp_dismiss];
    if ([button isEqual:self.confirmButton]) {
        if (self.confirmButtonAction) {
            self.confirmButtonAction();
        }
    }else if ([button isEqual:self.cancelButton]) {
        if (self.cancelButtonAction) {
            self.cancelButtonAction();
        }
    }
}
-(void)create_view
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
