//
//  PesoBankWalletCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import "PesoBankWalletCell.h"
#import "PesoBankModel.h"
@interface PesoBankWalletCell()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) UIImageView *arrow;

@end
@implementation PesoBankWalletCell

- (void)createUI
{
    [super createUI];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth-30, 60)];
    bgView.backgroundColor = ColorFromHex(0xF8F8F8);
    bgView.layer.cornerRadius = 4;
    bgView.layer.masksToBounds = YES;
    bgView.qmui_borderColor = ColorFromHex(0xC5E3BF);
    bgView.qmui_borderWidth = 1;
    [self.contentView addSubview:bgView];
    _bgView = bgView;
    
    UIImageView *icon  = [[UIImageView alloc] initWithImage:[UIImage br_imageWithColor:[UIColor orangeColor]]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.frame = CGRectMake(12, 0, 36, 36);
    icon.userInteractionEnabled = YES;
    icon.centerY = 30;
    [bgView addSubview:icon];
    _icon = icon;
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(14) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(icon.right + 10, 0, 200, 20);
    titleL.numberOfLines = 0;
    titleL.centerY = 30;
    [bgView addSubview:titleL];
    _titleL = titleL;
    
    UIImageView *arrow  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"identify_btn_normal"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    arrow.frame = CGRectMake(bgView.width-12-20, 0, 20, 20);
    arrow.centerY = 30;
    arrow.userInteractionEnabled = YES;
    [bgView addSubview:arrow];
    _arrow = arrow;
    
}
- (void)updateUIWithModel:(PesoBankItemModel *)model isSelect:(BOOL)isSelect
{
    _titleL.text = model.uporthirteennNc;
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.ieNcthirteen] placeholderImage:[UIImage br_imageWithColor:[UIColor orangeColor]]];
    self.arrow.image = [UIImage imageNamed:isSelect ? @"identify_btn_selected": @"identify_btn_normal"];
    self.bgView.backgroundColor = ColorFromHex(isSelect ? 0xC5E3BF : 0xF8F8F8);
}
@end
