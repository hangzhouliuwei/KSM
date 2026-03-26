//
//  PesoHomeSmallCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeSmallCell.h"
#import "PesoHomeSmallModel.h"
@interface PesoHomeSmallCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) QMUILabel *amountL;
@property (nonatomic, strong) QMUILabel *amountDescL;
@property (nonatomic, strong) QMUIButton *applyBtn;

@end
@implementation PesoHomeSmallCell

- (void)createUI
{
    [super createUI];
    self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_small_bg"]];
    bgImage.contentMode = UIViewContentModeScaleAspectFill;
    bgImage.frame = CGRectMake(20, 0, kScreenWidth-40,(kScreenWidth-40)/335*196);
    bgImage.userInteractionEnabled = YES;
    [self.contentView addSubview:bgImage];
    
    UIView *centerBg = [[UIView alloc] initWithFrame:CGRectMake(20, 30, bgImage.width-40, 76)];
    centerBg.backgroundColor = RGBA(255, 255, 255, 0.41);
    [bgImage addSubview:centerBg];
    
    UIImageView *icon  = [[UIImageView alloc] initWithImage:[UIImage br_imageWithColor:ColorFromHex(0xffffff)]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.frame = CGRectMake(10, 10, 56, 56);
    icon.userInteractionEnabled = YES;
    [centerBg addSubview:icon];
    _icon = icon;
    
    QMUILabel *amountL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(32) textColor:UIColor.blackColor];
    amountL.frame = CGRectMake(icon.right+12, 7, 200, 39);
    amountL.numberOfLines = 0;
    amountL.text = @"20,000";
    [centerBg addSubview:amountL];
    _amountL = amountL;
    
    QMUILabel *amountDescL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(12) textColor:RGBA(0, 0, 0, 0.70)];
    amountDescL.frame = CGRectMake(amountL.left, amountL.bottom+6, 200, 15);
    amountDescL.numberOfLines = 0;
    amountDescL.text = @"Maximum Borrowable Amount";
    [centerBg addSubview:amountDescL];
    _amountDescL = amountDescL;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, (kScreenWidth-40)/335*196 - 40, kScreenWidth, 40)];
    [bottomView br_setRoundedCorners: UIRectCornerTopLeft | UIRectCornerTopRight withRadius:CGSizeMake(16, 16)];
    bottomView.backgroundColor = RGBA(255, 255, 255, 0.80);
    [self.contentView addSubview:bottomView];
    
    QMUIButton *applyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    applyBtn.frame = CGRectMake(0, bottomView.top  - 25, 270, 50);
    applyBtn.centerX = kScreenWidth/2;
    [applyBtn setTitle:@"Apply" forState:UIControlStateNormal];
    applyBtn.backgroundColor = ColorFromHex(0xFCE815);
    applyBtn.titleLabel.font = PH_Font_H(18);
    [applyBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    applyBtn.layer.cornerRadius = 25;
    applyBtn.layer.masksToBounds = YES;
    [applyBtn addTarget:self action:@selector(applyClock) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:applyBtn];
    _applyBtn = applyBtn;
    
    centerBg.centerY = (((kScreenWidth-40)/335*196) - 40 - 25)/2;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyClock)];
    [bgImage addGestureRecognizer:tap];
    
}
- (void)applyClock{
    if (self.applyBlock) {
        self.applyBlock(@(_applyBtn.tag).stringValue);
    }
}
- (void)configUIWithModel:(PesoHomeSmallModel *)model
{
    PesoHomeSmallItemModel *item = model.gugothirteenyleNc.firstObject;
    _amountL.text = item.eahothirteenleNc;
    _amountDescL.text = item.cotethirteennderNc;
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:item.sihothirteenuetteNc]];
    [_applyBtn setTitle:item.maanthirteenNc ? : @"Apply" forState:UIControlStateNormal];
    _applyBtn.backgroundColor = [UIColor qmui_colorWithHexString:item.spffthirteenlicateNc];
    _applyBtn.tag = item.regnthirteenNc.intValue;
}
@end
