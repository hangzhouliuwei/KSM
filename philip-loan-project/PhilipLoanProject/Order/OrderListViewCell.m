//
//  OrderListViewCell.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/29.
//

#import "OrderListViewCell.h"

@implementation OrderListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self plpGenerateSubview];
    }
    return self;
}
-(void)setModel:(OrderListModel *)model
{
    _model = model;
    self.bgView.height = model.cellHeight - 14;
    _nameLabel.text = model.moostwelveyllabismNc;
    [_iconImageView sd_setImageWithURL:kURL(model.sihotwelveuetteNc)];
    _statusLabel.text = model.laartwelveckianNc;
    _statusLabel.textColor = kStringHexColor(model.imottwelveenceNc);
    _statusLabel.width = [_statusLabel.text widthWithFont:_statusLabel.font];
    _statusLabel.left = _bgView.width - _statusLabel.width - 14;
    _nameLabel.width = _statusLabel.left - 5 - 49;
    
    _tempView.model = model;
    _refundButton.hidden = ![model.maantwelveNc isReal];
    [_refundButton setTitle:model.maantwelveNc forState:UIControlStateNormal];
    _refundButton.backgroundColor = kStringHexColor(model.shkatwelveriNc);
    
}
-(void)plpGenerateSubview
{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 14, kScreenW - 30, 202)];
    _bgView.backgroundColor = kWhiteColor;
    _bgView.layer.cornerRadius = 12;
    [self.contentView addSubview:self.bgView];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 27, 27)];
    _iconImageView.layer.masksToBounds = _iconImageView.layer.cornerRadius = _iconImageView.height / 2.0;
    [self.bgView addSubview:self.iconImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(49, 18, 10, 20)];
    [self.nameLabel pp_setPropertys:@[kFontSize(14),kBlackColor_333333]];
    [self.bgView addSubview:self.nameLabel];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bgView.width - 14 - 20, 18, 10, 20)];
    [self.statusLabel pp_setPropertys:@[kFontSize(12),kGrayColor_999999,@(NSTextAlignmentRight)]];
    [self.bgView addSubview:self.statusLabel];
    
    self.tempView = [[MoneyDateView alloc] initWithFrame:CGRectMake(14, _iconImageView.bottom + 12, _bgView.width - 28, 76)];
    _tempView.layer.cornerRadius = 11;
    [self.bgView addSubview:self.tempView];
    
    self.refundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _refundButton.frame = CGRectMake(14, 14 + _tempView.bottom , _tempView.width, 40);
    _refundButton.layer.cornerRadius = _refundButton.height / 2.0;
    [_refundButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_refundButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.refundButton];
    
}
-(void)buttonAction:(UIButton *)button
{
    if (self.tapBlk) {
        self.tapBlk();
    }
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
