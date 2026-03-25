//
//  PesoHomeListCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeListCell.h"
#import "PesoHomePLModel.h"
@interface PesoHomeListCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) QMUILabel *amountL;
@property (nonatomic, strong) QMUILabel *amountDescL;
@property (nonatomic, strong) QMUIButton *applyBtn;

@end
@implementation PesoHomeListCell

- (void)createUI
{
    [super createUI];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 140)];
    bgView.backgroundColor = UIColor.whiteColor;
    bgView.layer.cornerRadius = 16;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = ColorFromHex(0x000000).CGColor;
    [self.contentView addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyAction)];
    [bgView addGestureRecognizer:tap];
    
    UIImageView *topImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_list_top"]];
    topImage.contentMode = UIViewContentModeScaleAspectFill;
    topImage.frame = CGRectMake(0, 0, bgView.width, 30);
    topImage.userInteractionEnabled = YES;
    [bgView addSubview:topImage];
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(16) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(15, 0, 200, 30);
    titleL.numberOfLines = 0;
    titleL.text = @"xxx";
    [bgView addSubview:titleL];
    _titleL = titleL;
    
    UIImageView *icon  = [[UIImageView alloc] initWithImage:[UIImage br_imageWithColor:ColorFromHex(0xD9EAC9)]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.frame = CGRectMake(15, topImage.bottom+10, 44, 44);
    icon.userInteractionEnabled = YES;
    [bgView addSubview:icon];
    _icon = icon;
    
    QMUILabel *amountL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(22) textColor:ColorFromHex(0x0B2C04)];
    amountL.frame = CGRectMake(icon.right+15, icon.top, 100, 26);
    amountL.numberOfLines = 0;
    [bgView addSubview:amountL];
    _amountL = amountL;
    
    QMUILabel *amountDescL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(12) textColor:ColorFromHex(0x616C5F)];
    amountDescL.frame = CGRectMake(icon.right+15, amountL.bottom, 200, 26);
    amountDescL.numberOfLines = 0;
    [bgView addSubview:amountDescL];
    _amountDescL = amountDescL;
    
    QMUIButton *applyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    applyBtn.frame = CGRectMake(bgView.width-85-15, 0, 85, 34);
    applyBtn.centerY = icon.centerY;
    [applyBtn setTitle:@"Apply now" forState:UIControlStateNormal];
    applyBtn.backgroundColor = ColorFromHex(0xFCE815);
    applyBtn.titleLabel.font = PH_Font_B(13);
    [applyBtn setTitleColor:ColorFromHex(0x0B2C04) forState:UIControlStateNormal];
    applyBtn.layer.cornerRadius = 17;
    applyBtn.layer.masksToBounds = YES;
    [applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:applyBtn];
    _applyBtn = applyBtn;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, amountDescL.bottom+10, bgView.width - 30, 1)];
    line.backgroundColor = ColorFromHex(0xEEF0F4);
    [bgView addSubview:line];
    
    QMUILabel *tipL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(12) textColor:ColorFromHex(0x2A9313)];
    tipL.text = @"The more the amount used /The higher the interest rate";
    tipL.frame = CGRectMake(12, line.bottom+10, bgView.width - 24, 15);
    tipL.numberOfLines = 0;
    [bgView addSubview:tipL];
    
}
- (void)configUIWithModel:(PesoHomePLItemModel *)model
{
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.sihothirteenuetteNc] placeholderImage:[UIImage br_imageWithColor:ColorFromHex(0xD9EAC9)]];
    _titleL.text = model.moosthirteenyllabismNc;
    _amountL.text = model.eahothirteenleNc;
    _amountDescL.text = model.cotethirteennderNc;
    [self.applyBtn setTitle:model.maanthirteenNc.length > 0 ?  model.maanthirteenNc : @"Apply" forState:UIControlStateNormal];
    self.applyBtn.backgroundColor = model.spffthirteenlicateNc.length > 0 ? [UIColor qmui_colorWithHexString:model.spffthirteenlicateNc] : ColorFromHex(0xFCE815);
    CGFloat btnWidth = [PesoUtil getTextVieWideForString:model.maanthirteenNc.length > 0 ?  model.maanthirteenNc : @"Apply" andHigh:34.f andFont:PH_Font_B(13.f) andnumberOfLines:1] + 20;
    self.applyBtn.width = btnWidth;
    self.applyBtn.left = kScreenWidth - 30 - btnWidth - 15;
    [self.contentView layoutIfNeeded];
}
- (void)applyAction{
    if (self.applyBlock) {
        self.applyBlock();
    }
}
@end
