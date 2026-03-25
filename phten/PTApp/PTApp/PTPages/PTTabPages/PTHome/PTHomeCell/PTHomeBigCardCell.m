//
//  PTHomeBigCardCell.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/1.
//

#import "PTHomeBigCardCell.h"
#import "PTHomeLargeEcardModel.h"

@interface PTHomeBigCardCell ()
@property(nonatomic, strong) UIImageView *backImageView;
@property(nonatomic, strong) QMUILabel *eatenholeNcLabel;
@property(nonatomic, strong) QMUILabel *cotentenderNcLabel;
@property(nonatomic, strong) UIImageView *urtenterNcBackImage;
@property(nonatomic, strong) QMUILabel *enadosNcLabel;
@property(nonatomic, strong) QMUILabel *urtenterNcLabel;
@property(nonatomic, strong) UIImageView *fitenancialNcImage;
@property(nonatomic, strong) QMUILabel *fatentishNcLabel;
@property(nonatomic, strong) QMUILabel *fitenancialNcLabel;
@property(nonatomic, strong) QMUIButton *applyBtn;
@property(nonatomic, strong) PTHomeLargeEcardItemModel *model;
@end

@implementation PTHomeBigCardCell

-(void)configModel:(PTHomeLargeEcardItemModel*)model
{
    self.model = model;
    self.eatenholeNcLabel.text = PTNotNull(model.eatenholeNc);
    self.cotentenderNcLabel.text = PTNotNull(model.cotentenderNc);
    
    self.enadosNcLabel.text = PTNotNull(model.patenadosNc);
    self.urtenterNcLabel.text = PTNotNull(model.urtenterNc);
    
    self.fatentishNcLabel.text = PTNotNull(model.fatentishNc);
    self.fitenancialNcLabel.text = PTNotNull(model.fitenancialNc);
    
    [self.applyBtn setTitle:PTNotNull(model.matenanNc) forState:UIControlStateNormal];
    self.applyBtn.backgroundColor = [PTTools isBlankString:model.sptenfflicateNc] ? PTUIColorFromHex(0xFE5879) : [UIColor qmui_colorWithHexString:model.sptenfflicateNc];
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

- (void)createSubUI
{
    self.backImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *backImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyBtnClick)];
    [self.backImageView addGestureRecognizer:backImageTap];
    [self.contentView addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(-16.f);
        make.height.mas_equalTo((kScreenWidth-32)/343*278);
    }];
    
    [self.backImageView addSubview:self.eatenholeNcLabel];
    [self.eatenholeNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(60.f);
        make.height.mas_equalTo(34.f);
    }];
    
    [self.backImageView addSubview:self.cotentenderNcLabel];
    [self.cotentenderNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.eatenholeNcLabel.mas_leading);
        make.top.mas_equalTo(self.eatenholeNcLabel.mas_bottom).offset(6.f);
//        make.height.mas_equalTo(14.f);
    }];
    
    [self.backImageView addSubview:self.urtenterNcBackImage];
    [self.urtenterNcBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16.f);
        make.top.mas_equalTo(self.cotentenderNcLabel.mas_bottom).offset(18.f);
        make.height.mas_equalTo(54.f);
        make.width.mas_equalTo((kScreenWidth - PTAUTOSIZE(80.f))/2.f);
    }];
    
    [self.urtenterNcBackImage addSubview:self.enadosNcLabel];
    [self.enadosNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.f);
        make.top.mas_equalTo(4.f);
//        make.height.mas_equalTo(14.f);
    }];
    
    [self.urtenterNcBackImage addSubview:self.urtenterNcLabel];
    [self.urtenterNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.enadosNcLabel.mas_leading);
        make.bottom.mas_equalTo(-6.f);
//        make.height.mas_equalTo(14.f);
    }];
    
    [self.backImageView addSubview:self.fitenancialNcImage];
    [self.fitenancialNcImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.cotentenderNcLabel.mas_leading);
        make.centerY.mas_equalTo(self.urtenterNcBackImage.mas_centerY);
        make.height.mas_equalTo(54.f);
        make.width.mas_equalTo((kScreenWidth - PTAUTOSIZE(80.f))/2.f);
    }];
    
    
    [self.fitenancialNcImage addSubview:self.fatentishNcLabel];
    [self.fatentishNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.f);
        make.top.mas_equalTo(4.f);
        make.height.mas_equalTo(14.f);
    }];
    
    [self.fitenancialNcImage addSubview:self.fitenancialNcLabel];
    [self.fitenancialNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.fatentishNcLabel.mas_leading);
        make.bottom.mas_equalTo(-6.f);
//        make.height.mas_equalTo(14.f);
    }];
    
    [self.backImageView addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-16.f);
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(-16.f);
        make.height.mas_equalTo(42.f);
    }];
}

- (void)applyBtnClick
{
    if(self.applyClickBloack){
        self.applyClickBloack(self.model.retengnNc);
    }
}

#pragma mark - lazy

-(UIImageView *)backImageView{
    if(!_backImageView){
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_bigCardBack"]];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _backImageView;
}

-(QMUILabel *)eatenholeNcLabel{
    if(!_eatenholeNcLabel){
        _eatenholeNcLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_SD(32.f) textColor:PTUIColorFromHex(0x000000)];
        _eatenholeNcLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _eatenholeNcLabel;
}

- (QMUILabel *)cotentenderNcLabel{
    if(!_cotentenderNcLabel){
        _cotentenderNcLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12.f) textColor:PTUIColorFromHex(0x000000)];
        _cotentenderNcLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _cotentenderNcLabel;
}

- (UIImageView *)urtenterNcBackImage{
    if(!_urtenterNcBackImage){
        _urtenterNcBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_urtenterNcBack"]];
        _urtenterNcBackImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _urtenterNcBackImage;
}

- (QMUILabel *)enadosNcLabel{
    if(!_enadosNcLabel){
        
        _enadosNcLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12.f) textColor:PTUIColorFromHex(0x999999)];
        _enadosNcLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _enadosNcLabel;
}

- (QMUILabel *)urtenterNcLabel{
    if(!_urtenterNcLabel){
        _urtenterNcLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(16.f) textColor:PTUIColorFromHex(0x333333)];
        _urtenterNcLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _urtenterNcLabel;
}


- (UIImageView *)fitenancialNcImage{
    if(!_fitenancialNcImage){
        _fitenancialNcImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_urtenterNcBack"]];
        _fitenancialNcImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _fitenancialNcImage;
}

-(QMUILabel *)fatentishNcLabel{
    if(!_fatentishNcLabel){
        _fatentishNcLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12.f) textColor:PTUIColorFromHex(0x999999)];
        _fatentishNcLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _fatentishNcLabel;
}

-(QMUILabel*)fitenancialNcLabel{
    if(!_fitenancialNcLabel){
        _fitenancialNcLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(16.f) textColor:PTUIColorFromHex(0x333333)];
        _fitenancialNcLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _fitenancialNcLabel;
}

-(QMUIButton *)applyBtn{
    if(!_applyBtn){
        _applyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _applyBtn.titleLabel.font = PT_Font_M(16.f);
        [_applyBtn  addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_applyBtn setTitleColor:PTUIColorFromHex(0x000000) forState:UIControlStateNormal];
        [_applyBtn showRadius:21.f];
    }
    
    return _applyBtn;
}

@end
