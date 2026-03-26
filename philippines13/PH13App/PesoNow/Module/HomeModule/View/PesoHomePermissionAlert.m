//
//  PesoHomePermissionAlert.m
//  PesoApp
//
//  Created by Jacky on 2024/9/19.
//

#import "PesoHomePermissionAlert.h"
@interface PesoHomePermissionAlert()
@property (nonatomic, strong) QMUILabel *titleL;
@end
@implementation PesoHomePermissionAlert

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)createUI{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-300, kScreenWidth, 300)];
    bgView.backgroundColor = UIColor.whiteColor;
    bgView.layer.cornerRadius = 10;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    
    
    QMUIButton *closeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(bgView.width-11-11,  20, 11, 12);
    [closeBtn setImage:[UIImage imageNamed:@"home_closeT"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(bgClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:closeBtn];
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_M(14) textColor:ColorFromHex(0x616C5F)];
    titleL.frame = CGRectMake(20, 47, kScreenWidth-40, 121);
    titleL.numberOfLines = 0;
    [bgView addSubview:titleL];
    _titleL = titleL;
    
    QMUIButton *agreeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(30, bgView.height - kBottomSafeHeight - 50 -10, kScreenWidth-60, 50);
    [agreeBtn setTitle:@"Agree" forState:UIControlStateNormal];
    agreeBtn.backgroundColor = ColorFromHex(0xFCE815);
    agreeBtn.titleLabel.font = PH_Font_B(18);
    [agreeBtn setTitleColor:ColorFromHex(0x000000) forState:UIControlStateNormal];
    agreeBtn.layer.cornerRadius = 25;
    agreeBtn.layer.masksToBounds = YES;
    [agreeBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:agreeBtn];
    
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleL.text = title;
}
- (void)agreeAction{
    [self removeFromSuperview];
    if (self.agreeBlock) {
        self.agreeBlock();
    }
}
- (void)bgClick{
    [self removeFromSuperview];
}
- (void)show
{
    [UIApplication.sharedApplication.windows.firstObject addSubview:self];
}
@end
