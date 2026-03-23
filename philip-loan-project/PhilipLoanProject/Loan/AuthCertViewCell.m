//
//  AuthCertViewCell.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/6.
//

#import "AuthCertViewCell.h"

@implementation AuthCertViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, self.width, self.height - 15)];
        self.bgView.backgroundColor = kHexColor(0xE5EEFF);
        self.bgView.layer.cornerRadius = 16;
        [self.contentView addSubview:self.bgView];
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 36) / 2.0, 0, 36, 36)];
        _iconImageView.layer.masksToBounds = _iconImageView.layer.cornerRadius = _iconImageView.height / 2.0;
        [self.contentView addSubview:self.iconImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 25, self.width - 46, 44)];
        [self.nameLabel pp_setPropertys:@[@(NSTextAlignmentCenter),kBoldFontSize(16),kBlackColor_333333]];
        _nameLabel.numberOfLines = 0;
        [self.bgView addSubview:self.nameLabel];
        
        self.statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 21) / 2.0, _nameLabel.bottom + 2, 21, 21)];
        self.statusImageView.layer.masksToBounds = self.statusImageView.layer.cornerRadius = self.statusImageView.height / 2.0;
        [self.bgView addSubview:self.statusImageView];
        
    }
    return self;
}
-(void)setModel:(AuthCertModel *)model
{
    _model = model;
    NSString *imageName = @"";
    if (model.frlltwelveyNc) {
        imageName = @"auth_cert_icon_selected";
    }else
    {
        imageName = @"auth_cert_icon_normal";
    }
    self.statusImageView.image = kImageName(imageName);
//    self.iconImageView.backgroundColor = UIColor.redColor;
    self.nameLabel.text = model.fldgtwelveeNc;
    [self.iconImageView sd_setImageWithURL:kURL(model.doabtwelveleNc)];
}
@end
