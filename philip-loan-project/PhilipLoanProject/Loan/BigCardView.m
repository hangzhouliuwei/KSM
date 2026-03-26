//
//  BigCardView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/28.
//

#import "BigCardView.h"

@implementation BigCardView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self plp_generateSubview];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleButtonAction:)]];
    }
    return self;
}

-(void)configureCardInfo:(NSDictionary *)dic isBigCard:(BOOL)isBigCard
{
    NSString *logo = dic[@"sihotwelveuetteNc"];
    [self.logoImageView sd_setImageWithURL:kURL(logo)];
    
    NSString *name = dic[@"moostwelveyllabismNc"];
    _nameLabel.text = [NSString stringWithFormat:@"%@",name];
    
    NSString *productInfo = [NSString stringWithFormat:@"%@",dic[@"cotetwelvenderNc"]];
    self.titleLabel.text = productInfo;
    
    NSString *amount = [NSString stringWithFormat:@"%@",dic[@"eahotwelveleNc"]];
    self.valueLabel.text = amount;
    _valueLabel.width = [_valueLabel.text widthWithFont:_valueLabel.font];
    
    NSString *title = [NSString stringWithFormat:@"%@",dic[@"maantwelveNc"]];
    [self.applyButton setTitle:title forState:UIControlStateNormal];
    NSString *color = [NSString stringWithFormat:@"%@",dic[@"spfftwelvelicateNc"]];
    self.applyButton.backgroundColor = kStringHexColor(color);
    _applyButton.width = [title widthWithFont:_applyButton.titleLabel.font] + 32;
    _applyButton.left = _valueLabel.right + 13;
    
    NSString *termTitle = [NSString stringWithFormat:@"%@",dic[@"paadtwelveosNc"]];
    NSString *termDes = [NSString stringWithFormat:@"%@",dic[@"urtetwelverNc"]];
    self.termLabel.text = [NSString stringWithFormat:@"%@:%@",termTitle, termDes];
    
    NSString *rateTitle = [NSString stringWithFormat:@"%@",dic[@"fatitwelveshNc"]];
    NSString *rateDes = [NSString stringWithFormat:@"%@",dic[@"fiantwelvecialNc"]];
    self.rateLabel.text = [NSString stringWithFormat:@"%@:%@",rateTitle, rateDes];
}
-(void)handleButtonAction:(UIButton *)button
{
    if (self.tapAppleyBlk) {
        self.tapAppleyBlk();
    }
}
-(void)plp_generateSubview
{
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _bgImageView.layer.masksToBounds = _bgImageView.layer.cornerRadius = 14;
    _bgImageView.image = kImageName(@"loan_head_bg");
    [self addSubview:self.bgImageView];
    
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 27 - 15, 15, 27, 27)];
    _logoImageView.layer.masksToBounds = _logoImageView.layer.cornerRadius = 6;
    _logoImageView.layer.borderColor = kWhiteColor.CGColor;
    _logoImageView.layer.borderWidth = 1;
    [self.bgImageView addSubview:self.logoImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 57, 4 + _logoImageView.bottom, 57, 11)];
    [_nameLabel pp_setPropertys:@[kFontSize(8),kWhiteColor,@(NSTextAlignmentCenter)]];
    [self addSubview:self.nameLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 24, _logoImageView.left - 10 - 24, 20)];
    [_titleLabel pp_setPropertys:@[[UIColor colorWithWhite:1 alpha:0.6],kFontSize(14)]];
    [self.bgImageView addSubview:self.titleLabel];
    
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 4 + _titleLabel.bottom, _logoImageView.left - 10 - 24, 47)];
    [_valueLabel pp_setPropertys:@[kWhiteColor,kBoldFontSize(34),]];
    [self.bgImageView addSubview:self.valueLabel];
    
    self.applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _applyButton.frame = CGRectMake(0, 57, 89, 34);
    _applyButton.layer.cornerRadius = _applyButton.height / 2.0;
    [_applyButton setTitle:@"Apply" forState:UIControlStateNormal];
    _applyButton.titleLabel.font = kFontSize(14);
    _applyButton.backgroundColor = kHexColor(0xFFEF5B);
    [_applyButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.applyButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:_applyButton];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 7 + _valueLabel.bottom, _bgImageView.width - 2 * 24, 20)];
    [_rateLabel pp_setPropertys:@[kWhiteColor, kFontSize(14)]];
    [self.bgImageView addSubview:self.rateLabel];
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, _bgImageView.height - 36, _bgImageView.width, 36)];
    coverView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.16];
    [self.bgImageView addSubview:coverView];
    
    self.termLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 8, _bgImageView.width - 2 * 24, 23)];
    [self.termLabel pp_setPropertys:@[kFontSize(12), kWhiteColor]];
    [coverView addSubview:self.termLabel];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
