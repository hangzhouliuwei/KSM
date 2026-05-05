//
//  PTAuthenticationHeaderView.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/14.
//

#import "PTAuthenticationHeaderView.h"

@interface PTAuthenticationHeaderView()
@property (nonatomic, strong) QMUILabel *amountLabel;
@property (nonatomic, strong) QMUILabel *amountDescLabel;

@end

@implementation PTAuthenticationHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self createSubUI];
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)createSubUI
{
    self.backgroundColor = UIColor.clearColor;
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_auth_header_bg"]];
    [self addSubview:leftImage];
    [self addSubview:self.amountLabel];
    [self addSubview:self.amountDescLabel];

    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.mas_equalTo(0);
        make.height.mas_equalTo((kScreenWidth-32)/343*136);
    }];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImage.mas_left).offset(29);
        make.top.mas_equalTo(leftImage.mas_top).offset(20);
    }];
    [self.amountDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImage.mas_left).offset(29);
        make.top.mas_equalTo(_amountLabel.mas_bottom).offset(8);
    }];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"₱:200,000"];
    [attr addAttributes:@{NSFontAttributeName: PT_Font(22)} range:[@"₱:200,000" rangeOfString:@"₱:"]];
    [attr addAttributes:@{NSFontAttributeName: PT_Font_B(30)} range:[@"₱:200,000" rangeOfString:@"200,000"]];

    self.amountLabel.attributedText = attr;
}
- (QMUILabel *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(22) textColor:PTUIColorFromHex(0x101D37)];
        _amountLabel.text = @"₱:200,000";
    }
    return _amountLabel;
}
- (QMUILabel *)amountDescLabel
{
    if (!_amountDescLabel) {
       
        _amountDescLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_Light(12) textColor:PTUIColorFromHex(0x637182)];
        _amountDescLabel.text = @"Maximum Loan Amount";
    }
    return _amountDescLabel;
}
@end
