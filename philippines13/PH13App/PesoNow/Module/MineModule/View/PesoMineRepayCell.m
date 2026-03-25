//
//  PesoMineRepayCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoMineRepayCell.h"
#import "PesoMineModel.h"
@interface PesoMineRepayCell()
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) QMUILabel *statusL;
@property (nonatomic, strong) QMUILabel *amountL;
@property (nonatomic, strong) QMUILabel *amountDescL;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) QMUILabel *repayDateL;

@end
@implementation PesoMineRepayCell

- (void)createUI
{
    [super createUI];
    self.contentView.backgroundColor = self.backgroundColor = UIColor.clearColor;

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 156)];
    bgView.backgroundColor = UIColor.whiteColor;
    bgView.layer.cornerRadius = 16;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = ColorFromHex(0x000000).CGColor;
    [self.contentView addSubview:bgView];

    
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
    
    
    QMUILabel *statusL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(12) textColor:ColorFromHex(0xffffff)];
    statusL.frame = CGRectMake(bgView.width- 15-200, 0, 200, 30);
    statusL.numberOfLines = 0;
    statusL.text = @"Outstanding";
    statusL.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:statusL];
    _statusL = statusL;
    
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
    amountDescL.text = @"Loan amount";
    [bgView addSubview:amountDescL];
    _amountDescL = amountDescL;
    
    QMUILabel *repayDateL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(22) textColor:ColorFromHex(0x0B2C04)];
    repayDateL.frame = CGRectMake(amountL.right+15, 0, 200, 26);
    repayDateL.numberOfLines = 0;
    repayDateL.centerY = amountL.centerY;
    [bgView addSubview:repayDateL];
    _repayDateL = repayDateL;
    
    QMUILabel *repayDescDateL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(12) textColor:ColorFromHex(0x616C5F)];
    repayDescDateL.frame = CGRectMake(repayDateL.left, amountL.bottom, 200, 26);
    repayDescDateL.numberOfLines = 0;
    repayDescDateL.text = @"Repayment date";
    repayDescDateL.centerY = amountDescL.centerY;
    [bgView addSubview:repayDescDateL];
    
    QMUIButton *refundBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    refundBtn.frame = CGRectMake(0, bgView.height-15-40, 160, 40);
    refundBtn.centerX = bgView.width/2;
    [refundBtn setTitle:@"Refund" forState:UIControlStateNormal];
    refundBtn.backgroundColor = ColorFromHex(0xFF9200);
    refundBtn.titleLabel.font = PH_Font_B(18);
    [refundBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    refundBtn.layer.cornerRadius = 20;
    refundBtn.layer.masksToBounds = YES;
    refundBtn.userInteractionEnabled = NO;
    [refundBtn addTarget:self action:@selector(repayAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:refundBtn];
    
}
- (void)configUIWithModel:(PesoMineRepayModel *)model
{
    _amountL.text = model.geerthirteenalitatNc;
    _repayDateL.text = model.acepthirteentablyNc;
    _titleL.text = model.harythirteenNc;
    self.statusL.text = @"Overdue payment";
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.ieNcthirteen] placeholderImage:[UIImage br_imageWithColor:ColorFromHex(0xD9EAC9)]];
}
- (void)repayAction{
    if (self.repayBlock) {
        self.repayBlock();
    }
}
@end
