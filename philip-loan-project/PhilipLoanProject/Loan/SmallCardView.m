//
//  SmallCardView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/31.
//

#import "SmallCardView.h"

@implementation SmallCardView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleButtonAction:)]];
        [self generateSubview];
    }
    return self;
}
-(void)configureCardInfo:(NSDictionary *)dic
{
    NSString *logo = dic[@"sihotwelveuetteNc"];
    [self.logoImageView sd_setImageWithURL:kURL(logo)];
    
    NSString *name = dic[@"moostwelveyllabismNc"];
    _nameLabel.text = [NSString stringWithFormat:@"%@",name];
    
    NSString *productInfo = [NSString stringWithFormat:@"%@",dic[@"cotetwelvenderNc"]];
    self.titleLabel.text = productInfo;
    
    NSString *amount = [NSString stringWithFormat:@"%@",dic[@"eahotwelveleNc"]];
    self.valueLabel.text = amount;
//    _valueLabel.width = [_valueLabel.text widthWithFont:_valueLabel.font];
    
    NSString *title = [NSString stringWithFormat:@"%@",dic[@"maantwelveNc"]];
    [self.applyButton setTitle:title forState:UIControlStateNormal];
    NSString *color = [NSString stringWithFormat:@"%@",dic[@"spfftwelvelicateNc"]];
    self.applyButton.backgroundColor = kStringHexColor(color);
}

-(void)handleButtonAction:(UIButton *)button
{
    if (self.tapAppleyBlk) {
        self.tapAppleyBlk();
    }
}
-(void)generateSubview
{
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _bgImageView.layer.masksToBounds = _bgImageView.layer.cornerRadius = 14;
    _bgImageView.backgroundColor = kBlueColor_0053FF;
    [self addSubview:self.bgImageView];
    
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 27 - 15, 15, 27, 27)];
    _logoImageView.layer.masksToBounds = _logoImageView.layer.cornerRadius = 6;
    [self.bgImageView addSubview:self.logoImageView];
    _logoImageView.layer.borderColor = kWhiteColor.CGColor;
    _logoImageView.layer.borderWidth = 1;
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 57, 4 + _logoImageView.bottom, 57, 11)];
    [_nameLabel pp_setPropertys:@[kFontSize(8),kWhiteColor,@(NSTextAlignmentCenter)]];
    [self addSubview:self.nameLabel];
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 17, self.width - 2 * 24, 47)];
    [_valueLabel pp_setPropertys:@[kWhiteColor,kBoldFontSize(34),@(NSTextAlignmentCenter)]];
    [self.bgImageView addSubview:self.valueLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3 + _valueLabel.bottom, self.width, 20)];
    [_titleLabel pp_setPropertys:@[[UIColor colorWithWhite:1 alpha:0.6],kFontSize(14),@(NSTextAlignmentCenter)]];
    [self.bgImageView addSubview:self.titleLabel];
    
    
    self.applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _applyButton.frame = CGRectMake(27, 17 + _titleLabel.bottom, self.width - 2 * 27, 44);
    _applyButton.layer.cornerRadius = _applyButton.height / 2.0;
    [_applyButton setTitle:@"Apply" forState:UIControlStateNormal];
    _applyButton.titleLabel.font = kFontSize(14);
    _applyButton.backgroundColor = kHexColor(0xFFEF5B);
    [_applyButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [_bgImageView addSubview:_applyButton];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
