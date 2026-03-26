//
//  AuthCertHeaderReusableView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/6.
//

#import "AuthCertHeaderReusableView.h"

@implementation AuthCertHeaderReusableView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 16, 26, 30)];
        self.iconImageView.image = kImageName(@"auth_cert_guard");
        [self addSubview:self.iconImageView];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, self.width - 60 - 10, 20)];
        [self.titleLabel pp_setPropertys:@[@"Certifcation is simple and fast",kFontSize(16),kBlackColor_333333]];
        [self addSubview:self.titleLabel];
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 18 + _titleLabel.bottom, self.width - 36, 164)];
        self.bgImageView.image = kImageName(@"base_head_medium");
        _bgImageView.layer.masksToBounds = _bgImageView.layer.cornerRadius = 12;
        [self addSubview:self.bgImageView];
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((_bgImageView.width - 200) / 2.0, 47, 200, 47)];
        [self.valueLabel pp_setPropertys:@[@(NSTextAlignmentCenter),kBoldFontSize(34),kWhiteColor]];
        [self.bgImageView addSubview:self.valueLabel];
        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 13 + _valueLabel.bottom, self.bgImageView.width - 40, 20)];
        [self.tipLabel pp_setPropertys:@[@(NSTextAlignmentCenter),kFontSize(14),kWhiteColor]];
        [self.bgImageView addSubview:self.tipLabel];
    }
    return self;
}

@end
