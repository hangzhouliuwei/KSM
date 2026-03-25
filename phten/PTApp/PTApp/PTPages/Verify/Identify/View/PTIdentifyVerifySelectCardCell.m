//
//  PTIdentifyVerifySelectCardCell.m
//  PTApp
//
//  Created by Jacky on 2024/8/25.
//

#import "PTIdentifyVerifySelectCardCell.h"
#import "PTIdentifyModel.h"
@interface PTIdentifyVerifySelectCardCell ()
@property (nonatomic, strong) QMUILabel *cardTitle;
@property (nonatomic, strong) UIImageView *cardImage;

@end
@implementation PTIdentifyVerifySelectCardCell

- (void)setupUI
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.cardTitle];
    [self.contentView addSubview:self.cardImage];
    [self.cardTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(23);
        make.left.mas_equalTo(16);
    }];
    [self.cardImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cardTitle.mas_bottom).offset(17);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo((kScreenWidth-32)/342*219);
    }];
}
- (void)configUIWithModel:(PTIdentifyListModel *)model
{
    self.cardTitle.text = model.rotenanizeNc;
    [self.cardImage sd_setImageWithURL:[NSURL URLWithString:model.ovtenrpunchNc] placeholderImage:[UIImage imageNamed:@"pt_identify_idcard"]];
}
- (QMUILabel *)cardTitle
{
    if (!_cardTitle) {
        _cardTitle = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(16) textColor:PTUIColorFromHex(0x111111)];
    }
    return _cardTitle;
}
- (UIImageView *)cardImage
{
    if (!_cardImage) {
        _cardImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _cardImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _cardImage;
}
@end
