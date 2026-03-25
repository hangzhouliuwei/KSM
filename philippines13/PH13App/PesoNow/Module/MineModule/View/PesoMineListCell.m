//
//  PesoMineListCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoMineListCell.h"
#import "PesoMineModel.h"
@interface PesoMineListCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) UIView *bgView;

@end
@implementation PesoMineListCell

- (void)createUI
{
    [super createUI];
    self.contentView.backgroundColor = self.backgroundColor = ColorFromHex(0xF8F8F8);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 60)];
    bgView.backgroundColor = UIColor.whiteColor;
   
    [self.contentView addSubview:bgView];
    _bgView = bgView;
    
    UIImageView *icon  = [[UIImageView alloc] initWithImage:[UIImage br_imageWithColor:UIColor.clearColor]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.frame = CGRectMake(15, 19, 24, 24);
    icon.userInteractionEnabled = YES;
    [bgView addSubview:icon];
    _icon = icon;
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_M(14) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(icon.right+10, 0, 200, 30);
    titleL.centerY = icon.centerY;
    titleL.numberOfLines = 0;
    [bgView addSubview:titleL];
    _titleL = titleL;
    
    UIImageView *arrow  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_right"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    arrow.frame = CGRectMake(bgView.width-15, 0, 6, 10);
    arrow.centerY = icon.centerY;
    arrow.userInteractionEnabled = YES;
    [bgView addSubview:arrow];
}
- (void)configUIWithModel:(PesoMineItemModel *)model
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:NotNil(model.ieNcthirteen)]];
    self.titleL.text = NotNil(model.fldgthirteeneNc);
}
- (void)setIndex:(NSInteger)index isLast:(BOOL)last
{
    if (index == 0) {
        [_bgView br_setRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadius:CGSizeMake(16, 16)];
    }
    if (last) {
        [_bgView br_setRoundedCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight withRadius:CGSizeMake(16, 16)];
    }
}
@end
