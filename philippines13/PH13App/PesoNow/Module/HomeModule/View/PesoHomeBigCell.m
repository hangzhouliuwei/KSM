//
//  PesoHomeBigCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeBigCell.h"
#import "PesoHomeBigModel.h"
@interface PesoHomeBigCell()
@property (nonatomic, strong) QMUILabel *amountDescL;
@property (nonatomic, strong) QMUILabel *amountL;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) QMUILabel *nameL;
@property (nonatomic, strong) QMUILabel *dayDescL;
@property (nonatomic, strong) QMUILabel *dayL;
@property (nonatomic, strong) QMUILabel *rateDescL;
@property (nonatomic, strong) QMUILabel *rateL;
@property (nonatomic, strong) QMUIButton *applyBtn;


@end
@implementation PesoHomeBigCell
- (void)createUI
{
    self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_big_bg"]];
    bgImage.contentMode = UIViewContentModeScaleAspectFill;
    bgImage.frame = CGRectMake(0, 0, kScreenWidth, 270);
    [self.contentView addSubview:bgImage];
    
    QMUILabel *amountDesc = [[QMUILabel alloc] initWithFrame:CGRectMake(40, 19, 180, 21)];
    amountDesc.textColor = RGBA(0, 0, 0, 0.70);
    amountDesc.font = PH_Font(16);
    amountDesc.text = @"Maximum Loan Amount";
    [bgImage addSubview:amountDesc];
    _amountDescL = amountDesc;
    
    _amountL = [[QMUILabel alloc] initWithFrame:CGRectMake(40, amountDesc.bottom + 5, 180, 39)];
    _amountL.textColor = RGBA(0, 0, 0, 0.70);
    _amountL.font = PH_Font_B(32);
    _amountL.text = @"20,000";
    [bgImage addSubview:_amountL];
    
    _icon  = [[UIImageView alloc] initWithImage:[UIImage br_imageWithColor:[UIColor orangeColor]]];
    _icon.contentMode = UIViewContentModeScaleAspectFill;
    _icon.frame = CGRectMake(kScreenWidth-44-40, 22, 44, 44);
    [bgImage addSubview:_icon];
    
    _nameL = [[QMUILabel alloc] initWithFrame:CGRectMake(40, _icon.bottom + 5, 100, 21)];
    _nameL.centerX = _icon.centerX;
    _nameL.textAlignment = NSTextAlignmentCenter;
    _nameL.textColor = RGBA(0, 0, 0, 0.70);
    _nameL.font = PH_Font(12);
    _nameL.text = @"xxx";
    [bgImage addSubview:_nameL];
    
    UIView *dayBg = [[UIView alloc] initWithFrame:CGRectMake(40, _amountL.bottom+10, kScreenWidth - 80, 54)];
    dayBg.backgroundColor = RGBA(255, 255, 255, 0.41);
    dayBg.layer.cornerRadius = 8;
    dayBg.layer.masksToBounds = YES;
    [bgImage addSubview:dayBg];
    
    UIView *dateBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dayBg.width/2, 54)];
    [dayBg addSubview:dateBg];
    
    UIImageView *datIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_time"]];
    datIcon.frame = CGRectMake(10, 0, 22, 22);
    datIcon.centerY= 27;
    [dateBg addSubview:datIcon];
    
    QMUILabel *dayDesc = [[QMUILabel alloc] initWithFrame:CGRectMake(datIcon.right + 8, 9, 100, 15)];
    dayDesc.textColor = RGBA(0, 0, 0, 0.70);
    dayDesc.font = PH_Font(12);
    dayDesc.text = @"Repayment Term";
    [dateBg addSubview:dayDesc];
    _dayDescL = dayDesc;
    
    _dayL = [[QMUILabel alloc] initWithFrame:CGRectMake(dayDesc.left, dayDesc.bottom + 2, 100, 21)];
    _dayL.textColor = RGBA(0, 0, 0, 1);
    _dayL.font = PH_Font_B(16);
    _dayL.text = @"91-360";
    [dateBg addSubview:_dayL];
    
    UIView *datebg = [[UIView alloc] initWithFrame:CGRectMake(dayBg.width/2, 0, dayBg.width/2, 54)];
    [dayBg addSubview:datebg];
    
    UIImageView *rateIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_rate"]];
    rateIcon.frame = CGRectMake(10, 0, 22, 22);
    rateIcon.centerY= 27;
    [datebg addSubview:rateIcon];
    
    QMUILabel *rateDesc = [[QMUILabel alloc] initWithFrame:CGRectMake(rateIcon.right + 8, 9, 100, 15)];
    rateDesc.textColor = RGBA(0, 0, 0, 0.70);
    rateDesc.font = PH_Font(12);
    rateDesc.text = @"Interest Rate";
    [datebg addSubview:rateDesc];
    _rateDescL = rateDesc;
    
    _rateL = [[QMUILabel alloc] initWithFrame:CGRectMake(rateDesc.left, dayDesc.bottom + 2, 100, 21)];
    _rateL.textColor = RGBA(0, 0, 0, 1);
    _rateL.font = PH_Font_B(16);
    _rateL.text = @"0.05%";
    [datebg addSubview:_rateL];
    
    QMUIButton *applyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    applyBtn.frame = CGRectMake(0, bgImage.bottom - 14 -50, 270, 50);
    applyBtn.centerX = bgImage.centerX;
    [applyBtn setTitle:@"Apply" forState:UIControlStateNormal];
    applyBtn.backgroundColor = ColorFromHex(0xFCE815);
    applyBtn.titleLabel.font = PH_Font_H(18);
    [applyBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    applyBtn.layer.cornerRadius = 25;
    applyBtn.layer.masksToBounds = YES;
    [applyBtn addTarget:self action:@selector(applyClock) forControlEvents:UIControlEventTouchUpInside];
    [bgImage addSubview:applyBtn];
    _applyBtn = applyBtn;
    
    bgImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyClock)];
    [bgImage addGestureRecognizer:tap];
}
- (void)configUIWithModel:(PesoHomeBigModel *)model
{
    PesoBItemModel *item = model.gugothirteenyleNc.firstObject;
    _amountL.text = item.eahothirteenleNc;
    _amountDescL.text = item.cotethirteennderNc;
    
    _dayL.text = item.urtethirteenrNc;
    _dayDescL.text = item.paadthirteenosNc;
    
    _rateL.text = item.fianthirteencialNc;
    _rateDescL.text = item.fatithirteenshNc;

    [_icon sd_setImageWithURL:[NSURL URLWithString:item.sihothirteenuetteNc]];
    _nameL.text = item.moosthirteenyllabismNc;
    
    [_applyBtn setTitle:item.maanthirteenNc forState:UIControlStateNormal];
    _applyBtn.tag = item.regnthirteenNc.intValue;
    _applyBtn.backgroundColor = [UIColor qmui_colorWithHexString:item.spffthirteenlicateNc];
    
}
- (void)applyClock{
    if (self.applyBlock) {
        self.applyBlock(@(_applyBtn.tag).stringValue);
    }
}
@end
