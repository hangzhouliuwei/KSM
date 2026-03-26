//
//  PesoBankConfirmView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import "PesoBankConfirmView.h"
@interface PesoBankConfirmView()
@property (nonatomic, strong) QMUILabel *nameL;
@property (nonatomic, strong) QMUILabel *bankNumbeL;

@end
@implementation PesoBankConfirmView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = RGBA(0, 0, 0, 0.50);
    }
    return self;
}
- (void)createUI{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 325, 337)];
    bgView.backgroundColor = ColorFromHex(0xffffff);
    bgView.layer.cornerRadius = 16;
    bgView.layer.masksToBounds = YES;
    bgView.center = CGPointMake(self.width/2, self.height/2);
    [self addSubview:bgView];
    
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 325, 100)];
    top.layer.cornerRadius = 16;
    top.layer.masksToBounds = YES;
    [bgView addSubview:top];
    [top br_setGradientColor:RGBA(213, 252, 174, 1) toColor:RGBA(255, 255, 255, 1) direction:BRDirectionTypeTopToBottom];
    
    UIImageView *topImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_tips"]];
    topImage.contentMode = UIViewContentModeScaleAspectFit;
    topImage.frame = CGRectMake(0, bgView.top-24, 78, 78);
    topImage.centerX = kScreenWidth/2;
    topImage.userInteractionEnabled = YES;
    [self addSubview:topImage];
    
    QMUILabel *descL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(13) textColor:ColorFromHex(0x0B1A3C)];
    descL.frame = CGRectMake(14, 55, bgView.width-28, 36);
    descL.numberOfLines = 0;
    descL.text = @"Please confirm your withdrawal account information belongs to yourself and is correct";
    [bgView addSubview:descL];
    
    QMUILabel *nameL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x0B2C04)];
    nameL.frame = CGRectMake(14, descL.bottom+15, bgView.width-28, 18);
    nameL.numberOfLines = 0;
    nameL.text = @"Channel/Bank:";
    [bgView addSubview:nameL];
    
    
    QMUILabel *nameValueL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_M(14) textColor:ColorFromHex(0x0B2C04)];
    nameValueL.frame = CGRectMake(14, nameL.bottom+10, bgView.width-28, 30);
    nameValueL.numberOfLines = 0;
    nameValueL.text = @"xxx";
    nameValueL.layer.cornerRadius = 4;
    nameValueL.layer.masksToBounds = YES;
    nameValueL.backgroundColor = ColorFromHex(0xFBFBFB);
    [bgView addSubview:nameValueL];
    _nameL = nameValueL;

    
    QMUILabel *phoneL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x0B2C04)];
    phoneL.frame = CGRectMake(14, nameValueL.bottom+4, bgView.width-28, 18);
    phoneL.numberOfLines = 0;
    phoneL.text = @"Account number:";
    [bgView addSubview:phoneL];
    
    QMUILabel *phoneValueL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_M(14) textColor:ColorFromHex(0x0B2C04)];
    phoneValueL.frame = CGRectMake(14, phoneL.bottom+10, bgView.width-28, 30);
    phoneValueL.numberOfLines = 0;
    phoneValueL.text = @"xxx";
    phoneValueL.layer.cornerRadius = 4;
    phoneValueL.layer.masksToBounds = YES;
    phoneValueL.backgroundColor = ColorFromHex(0xFBFBFB);
    [bgView addSubview:phoneValueL];
    _bankNumbeL = phoneValueL;
    
    QMUIButton *backBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(18, phoneValueL.bottom+30, (bgView.width-36-20)/2, 50);
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    backBtn.backgroundColor = UIColor.whiteColor;
    backBtn.titleLabel.font = PH_Font_B(18);
    [backBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 25;
    backBtn.layer.masksToBounds = YES;
    backBtn.layer.borderWidth = 1;
    backBtn.layer.borderColor = RGBA(0, 0, 0, 0.50).CGColor;
    [backBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:backBtn];
    
    QMUIButton *confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(backBtn.right+20, phoneValueL.bottom+30, (bgView.width-36-20)/2, 50);
    [confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    confirmBtn.backgroundColor = RGBA(252, 232, 21, 1);
    confirmBtn.titleLabel.font = PH_Font_B(18);
    [confirmBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius = 25;
    confirmBtn.layer.masksToBounds = YES;
//    confirmBtn.qmui_borderWidth = 1;
//    confirmBtn.qmui_borderColor = RGBA(0, 0, 0, 0.50);
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:confirmBtn];
}

- (void)show
{
    [[UIApplication sharedApplication].windows.firstObject addSubview:self];
}
- (void)cancelAction{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeFromSuperview];
}
- (void)confirmAction{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self removeFromSuperview];
}
- (void)setBank:(NSString *)bank
{
    _bank = bank;
    _nameL.text = bank;
}
- (void)setBankNumber:(NSString *)bankNumber
{
    _bankNumber = bankNumber;
    _bankNumbeL.text = bankNumber;
}
@end
