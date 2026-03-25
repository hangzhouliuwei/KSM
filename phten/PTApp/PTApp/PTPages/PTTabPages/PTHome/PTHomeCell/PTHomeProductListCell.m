//
//  PTHomeProductListCell.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import "PTHomeProductListCell.h"
#import "PTHomeProductModel.h"

@interface PTHomeProductListCell()
@property(nonatomic, strong) UIImageView *logoImage;
@property(nonatomic, strong) QMUILabel *motenosyllabismNcLabel;
@property(nonatomic, strong) QMUILabel *eatenholeNcLabel;
@property(nonatomic, strong) QMUILabel *cotentenderNcLabel;
@property(nonatomic, strong) QMUIButton *applyBtn;
@property(nonatomic, strong) PTHomeProductListModel *model;
@end

@implementation PTHomeProductListCell

-(void)configModel:(PTHomeProductListModel*)model
{
    self.model = model;
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:PTNotNull(model.sitenhouetteNc)]];
    self.motenosyllabismNcLabel.text = PTNotNull(model.motenosyllabismNc);
    self.eatenholeNcLabel.text = PTNotNull(model.eatenholeNc);
    self.cotentenderNcLabel.text = PTNotNull(model.cotentenderNc);
    [self.applyBtn setTitle:model.matenanNc.length > 0 ?  model.matenanNc : @"Apply" forState:UIControlStateNormal];
    self.applyBtn.backgroundColor = model.sptenfflicateNc.length > 0 ? [UIColor qmui_colorWithHexString:model.sptenfflicateNc] : PTUIColorFromHex(0x41E8FF);
    CGFloat btnWidth = [PTTools getTextVieWideForString:model.matenanNc.length > 0 ?  model.matenanNc : @"Apply" andHigh:30.f andFont:PT_Font_B(15.f) andnumberOfLines:1];
    [self.applyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16.f);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30.f);
        make.width.mas_equalTo(btnWidth + 36.f);
    }];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self createSubUI];
    }
    return self;
}

-(void)applyBtnClick
{
    if(self.applyClickBloack){
        self.applyClickBloack(self.model.retengnNc);
    }
}

-(void)createSubUI
{
    
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_productListback"]];
    [self.contentView addSubview:backImage];
    backImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *backImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyBtnClick)];
    [backImage addGestureRecognizer:backImageTap];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(-16.f);
        make.height.mas_equalTo(136.f);
    }];
    
    [backImage addSubview:self.logoImage];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16.f);
        make.top.mas_equalTo(16.f);
        make.width.height.mas_equalTo(30.f);
    }];
    
    [backImage addSubview:self.motenosyllabismNcLabel];
    [self.motenosyllabismNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImage.mas_right).offset(16.f);
        make.centerY.mas_equalTo(self.logoImage.mas_centerY);
        make.height.mas_equalTo(18.f);
    }];
    
    [backImage addSubview:self.eatenholeNcLabel];
    [self.eatenholeNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.logoImage.mas_leading);
        make.top.mas_equalTo(self.logoImage.mas_bottom).offset(14.f);
        make.height.mas_equalTo(24.f);
    }];
    
    [backImage addSubview:self.cotentenderNcLabel];
    [self.cotentenderNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.eatenholeNcLabel.mas_leading);
        make.top.mas_equalTo(self.eatenholeNcLabel.mas_bottom).offset(6.f);
        make.height.mas_equalTo(12.f);
    }];
    
    UIImageView *tipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_productLisTip"]];
    [backImage addSubview:tipImage];
    [tipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(-16.f);
        make.bottom.mas_equalTo(-8.f);
        make.height.mas_equalTo(20.f);
    }];
    
    QMUILabel *tipLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(10.f) textColor:PTUIColorFromHex(0x000000)];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.text = @"The more the amount used /The higher the interest rate";
    [tipImage addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(4.f);
        make.centerY.mas_equalTo(0);
    }];
    
    [backImage addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16.f);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - lazy
-(UIImageView *)logoImage{
    if(!_logoImage){
        _logoImage = [[UIImageView alloc] init];
        _logoImage.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _logoImage;
}

- (QMUILabel *)motenosyllabismNcLabel{
    if(!_motenosyllabismNcLabel){
        _motenosyllabismNcLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(16.f) textColor:PTUIColorFromHex(0x000000)];
        _motenosyllabismNcLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _motenosyllabismNcLabel;
}

- (QMUILabel *)eatenholeNcLabel{
    if(!_eatenholeNcLabel){
        _eatenholeNcLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_SD(22.f) textColor:PTUIColorFromHex(0x000000)];
        _eatenholeNcLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _eatenholeNcLabel;
}

- (QMUILabel *)cotentenderNcLabel{
    if(!_cotentenderNcLabel){
        _cotentenderNcLabel =  [[QMUILabel alloc] qmui_initWithFont:PT_Font(10.f) textColor:PTUIColorFromHex(0x637182)];
        _cotentenderNcLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _cotentenderNcLabel;
}

-(QMUIButton *)applyBtn{
    if(!_applyBtn){
        _applyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _applyBtn.titleLabel.font = PT_Font_B(15.f);
        [_applyBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_applyBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_applyBtn showRadius:4.f];
    }
    return _applyBtn;
}

@end
