//
//  AuthBankViewCell.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/10.
//

#import "AuthBankViewCell.h"

@implementation AuthBankViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(14, 0, kScreenW - 28, 60)];
        self.bgView.backgroundColor = kWhiteColor;
        [self.contentView addSubview:self.bgView];
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 16, 32, 32)];
        self.iconImageView.layer.masksToBounds = self.iconImageView.layer.cornerRadius = _iconImageView.height / 2.0;
        [self.bgView addSubview:self.iconImageView];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(kScreenW - 30 - 14 - 20, 22, 20, 20);
        [_button setBackgroundImage:kImageName(@"auth_cert_icon_normal") forState:UIControlStateNormal];
        [_button setBackgroundImage:kImageName(@"auth_cert_icon_selected") forState:UIControlStateSelected];
        _button.userInteractionEnabled = false;
        [self.bgView addSubview:self.button];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + 12, 21, _button.left - 17 - _iconImageView.right, 23)];
        [_nameLabel pp_setPropertys:@[kFontSize(16),kBlackColor_333333]];
        [self.bgView addSubview:self.nameLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(14, 58, kScreenW - 30 - 28, 1)];
        self.lineView.backgroundColor = kHexColor(0xd7d7d7);
        [self.bgView addSubview:self.lineView];
        
    }
    return self;
}
-(void)setModel:(AuthBankModel *)model
{
    _model = model;
    [self.iconImageView sd_setImageWithURL:kURL(model.ieNctwelve)];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.uportwelvenNc];
    self.button.selected = model.isSelected;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
