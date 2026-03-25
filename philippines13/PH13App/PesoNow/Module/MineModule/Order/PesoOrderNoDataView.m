//
//  PesoOrderNoDataView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoOrderNoDataView.h"

@implementation PesoOrderNoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    UIImageView *topImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_norecords"]];
    topImage.contentMode = UIViewContentModeScaleAspectFit;
    topImage.frame = CGRectMake(0, 70, 100, 100);
    topImage.userInteractionEnabled = YES;
    topImage.centerX = kScreenWidth/2;
    [self addSubview:topImage];
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(15) textColor:ColorFromHex(0x68728A)];
    titleL.frame = CGRectMake(0, topImage.bottom+17, 100, 20);
    titleL.centerX = kScreenWidth/2;
    titleL.numberOfLines = 0;
    titleL.text = @"No Records";
    [self addSubview:titleL];
    
    QMUIButton *logoutBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(0, titleL.bottom+20, 270, 50);
    logoutBtn.centerX =  kScreenWidth/2;
    logoutBtn.titleLabel.font = PH_Font_B(18.f);
    logoutBtn.backgroundColor = ColorFromHex(0xFCE815);
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"Apply now" forState:UIControlStateNormal];
    logoutBtn.layer.cornerRadius = 25;
    logoutBtn.layer.masksToBounds = YES;
    [logoutBtn addTarget:self action:@selector(applyClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:logoutBtn];
}

- (void)applyClick{
    if (self.applyBlock) {
        self.applyBlock();
    }
}
@end
