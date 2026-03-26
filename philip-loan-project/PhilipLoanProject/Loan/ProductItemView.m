//
//  ProductItemView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/2.
//

#import "ProductItemView.h"

@implementation ProductItemView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        self.backgroundColor = kWhiteColor;
        self.layer.cornerRadius = 14;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 12, 29, 29)];
        _iconImageView.layer.masksToBounds = _iconImageView.layer.cornerRadius = 6;
        [self addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + 10, 15, self.width - 14 - _iconImageView.right - 10, 23)];
        [self.titleLabel pp_setPropertys:@[kFontSize(16),kBlackColor_333333]];
        [self addSubview:self.titleLabel];
        
        self.payButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 85 - 14, 56, 85, 34)];
        [_payButton setTitle:@"Repay now" forState:UIControlStateNormal];
        _payButton.titleLabel.font = kFontSize(13);
        _payButton.userInteractionEnabled = false;
        [_payButton setTitleColor:kBlackColor_333333 forState:UIControlStateNormal];
//        _payButton.backgroundColor = kBlueColor_0053FF;
        _payButton.layer.cornerRadius = _payButton.height / 2.0;
        [self addSubview:self.payButton];
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 6 + _titleLabel.bottom, _payButton.left - 14, 47)];
        [self.valueLabel pp_setPropertys:@[kFontSize(34),kBlueColor_0053FF]];
        [self addSubview:self.valueLabel];
        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(14,85, _payButton.left - 14, 19)];
        [self.tipLabel pp_setPropertys:@[kFontSize(13),kGrayColor_999999]];
        [self addSubview:self.tipLabel];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(14, 10 + _tipLabel.bottom, self.width - 2 * 14, 26)];
        bgView.layer.cornerRadius = 4;
        bgView.backgroundColor= kHexColor(0xECF3FF);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 14, 14)];
        imageView.image = [kImageName(@"home_warn_icon")sd_tintedImageWithColor:kBlueColor_0053FF];;
        [bgView addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(21, (bgView.height - 15) / 2.0, bgView.width - 21 - 7, 15)];
        [label pp_setPropertys:@[kFontSize(11),kHexColor(0x666666),@"The more the amount used / The higher the interest rate"]];
        [bgView addSubview:label];
        [self addSubview:bgView];
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",dic[@"moostwelveyllabismNc"]];
    self.valueLabel.text = [NSString stringWithFormat:@"%@",dic[@"eahotwelveleNc"]];
    self.tipLabel.text = [NSString stringWithFormat:@"%@",dic[@"cotetwelvenderNc"]];
    [_iconImageView sd_setImageWithURL:kURL(dic[@"sihotwelveuetteNc"])];
    NSString *bgColor = dic[@"spfftwelvelicateNc"];
    NSString *title = dic[@"maantwelveNc"];
    [self.payButton setTitle:title forState:UIControlStateNormal];
    _payButton.backgroundColor = kStringHexColor(bgColor);
}
-(void)tapAction
{
    if ([_dic[@"pacatwelverditisNc"] boolValue]) {
        if (self.tapItemBlk) {
            self.tapItemBlk();
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
