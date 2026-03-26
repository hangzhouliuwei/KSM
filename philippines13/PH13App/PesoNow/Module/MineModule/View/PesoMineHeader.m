//
//  PesoMineHeader.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoMineHeader.h"
@interface PesoMineHeader()
@property (nonatomic, strong) QMUILabel *userNameL;
@end
@implementation PesoMineHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)createUI{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, self.width-30, 185)];
    bgView.backgroundColor = ColorFromHex(0xFFFFFF);
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    
    UIImageView *icon  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_touxiang"]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.frame = CGRectMake(15, 15, 64, 64);
    icon.userInteractionEnabled = YES;
    [bgView addSubview:icon];
    
    QMUILabel *welacomeL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x616C5F)];
    welacomeL.frame = CGRectMake(icon.right+13, icon.top, 200, 30);
    welacomeL.numberOfLines = 0;
    welacomeL.text = @"Hello, Esteemed Member ";
    [bgView addSubview:welacomeL];
    
    QMUILabel *userNameL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(20) textColor:ColorFromHex(0x181818)];
    userNameL.frame = CGRectMake(icon.right+13, welacomeL.bottom, 200, 30);
    userNameL.numberOfLines = 0;
    userNameL.text = [PesoUtil hideMiddleDigitsForPhoneNumber:PesoUserCenter.sharedPesoUserCenter.username];
    [bgView addSubview:userNameL];
    _userNameL = userNameL;
    
    UIImageView *borrowImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_borrowimg"]];
    borrowImage.contentMode = UIViewContentModeScaleAspectFit;
    borrowImage.frame = CGRectMake(15, icon.bottom+15, 153, 70);
    borrowImage.userInteractionEnabled = YES;
    [bgView addSubview:borrowImage];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(borrowClick)];
    [borrowImage addGestureRecognizer:tap1];
    
    UIImageView *orderImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_order"]];
    orderImage.contentMode = UIViewContentModeScaleAspectFit;
    orderImage.frame = CGRectMake(bgView.width-153*2-30+153+15, icon.bottom+15, 153, 70);
    orderImage.userInteractionEnabled = YES;
    [bgView addSubview:orderImage];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderClick)];
    [orderImage addGestureRecognizer:tap2];
}
- (void)updateUI
{
    _userNameL.text = [PesoUtil hideMiddleDigitsForPhoneNumber:PesoUserCenter.sharedPesoUserCenter.username];
}
- (void)borrowClick{
    if (self.borrowClickBlock) {
        self.borrowClickBlock();
    }
}
- (void)orderClick{
    if (self.orderClickBlock) {
        self.orderClickBlock();
    }
}
@end
