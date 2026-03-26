//
//  PesoVerifyWanliuView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/17.
//

#import "PesoVerifyWanliuView.h"
@interface PesoVerifyWanliuView()
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) QMUILabel *contentL;

@property (nonatomic, strong) QMUIButton *cancelBtn;
@property (nonatomic, strong) QMUIButton *confirmBtn;

@end
@implementation PesoVerifyWanliuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = RGBA(0, 0, 0, 0.50);
    }
    return self;
}
- (void)createUI{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 240)];
    bgView.backgroundColor = ColorFromHex(0xffffff);
    bgView.layer.cornerRadius = 16;
    bgView.layer.masksToBounds = YES;
    bgView.center = CGPointMake(self.width/2, self.height/2);
    [self addSubview:bgView];
    
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    top.layer.cornerRadius = 16;
    top.layer.masksToBounds = YES;
    [bgView addSubview:top];
    [top br_setGradientColor:RGBA(213, 252, 174, 1) toColor:RGBA(255, 255, 255, 1) direction:BRDirectionTypeTopToBottom];
    
    UIImageView *topImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_tips"]];
    topImage.contentMode = UIViewContentModeScaleAspectFit;
    topImage.frame = CGRectMake(0, bgView.top-37, 92, 92);
    topImage.centerX = kScreenWidth/2;
    topImage.userInteractionEnabled = YES;
    [self addSubview:topImage];
    
    QMUILabel *descL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(17) textColor:ColorFromHex(0x0B1A3C)];
    descL.frame = CGRectMake(14, 74, bgView.width-28, 36);
    descL.textAlignment = NSTextAlignmentCenter;
    descL.numberOfLines = 0;
    descL.text = @"Are you sure you want to leave ?";
    [bgView addSubview:descL];
    _titleL = descL;
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_M(13) textColor:ColorFromHex(0x616C5F)];
    titleL.frame = CGRectMake(14, descL.bottom+5, bgView.width-28, 18);
    titleL.numberOfLines = 0;
    titleL.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleL];
    _contentL = titleL;
    
    QMUIButton *confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(20, titleL.bottom+20, (bgView.width-50)/2, 50);
    [confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    confirmBtn.backgroundColor = UIColor.whiteColor;
    confirmBtn.titleLabel.font = PH_Font_B(18);
    [confirmBtn setTitleColor:ColorFromHex(0x000000) forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius = 25;
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.layer.borderWidth = 1;
    confirmBtn.layer.borderColor = RGBA(0, 0, 0, 0.50).CGColor;
    [confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:confirmBtn];
    _confirmBtn = confirmBtn;
    
    QMUIButton *cancelBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(20+(bgView.width-50)/2+10, confirmBtn.top, (bgView.width-50)/2, 50);
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = ColorFromHex(0xFCE815);
    cancelBtn.titleLabel.font = PH_Font_B(18);
    [cancelBtn setTitleColor:ColorFromHex(0x000000) forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 25;
    cancelBtn.layer.masksToBounds = YES;
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleL.text = title;
    CGFloat height = [title br_getTextHeight:PH_Font_B(17) width:300-28];
    _titleL.height = height;
    self.confirmBtn.top = self.cancelBtn.top = _titleL.bottom+40;
    [self layoutIfNeeded];
}
- (void)setStep:(NSInteger)step
{
    _step = step;
    NSString *str = @"";
    switch (step) {
        case 1:
            str = @"Complete the form to apply for a loan,and we'll tailor a loan amount just for you.";
            break;
        case 2:
            str = @"Enhance your loan approval chances by providing your emergency contact information now.";
            break;
        case 3:
            str = @"Complete your identification now for a chance to increase your loan limit.";
            break;
        case 4:
            str = @"Boost your credit score by completing facial recognition now.";
            break;
        case 5:
            str = @"Take the final step to apply for your loan- submitting now will enhance your approval rate.";
            break;
        default:
            break;
    }
    _contentL.text = str;
    CGFloat height = [str br_getTextHeight:PH_Font_M(13) width:300-28];
    _contentL.height = height;
    self.confirmBtn.top = self.cancelBtn.top = _contentL.bottom+20;
    [self setNeedsLayout];
}
- (void)confirmClick{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self removeFromSuperview];
}
- (void)cancelClick{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeFromSuperview];
}
- (void)show{
    [UIApplication.sharedApplication.windows.firstObject addSubview:self];
}
@end
