//
//  PTHomeSmallCardCell.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import "PTHomeSmallCardCell.h"
#import "PTHomeSmallCardModel.h"

@interface PTHomeSmallCardCell()
@property(nonatomic, strong) UIImageView *backImageView;
@property(nonatomic, strong) QMUILabel *eatenholeNcLabel;
@property(nonatomic, strong) QMUILabel *cotentenderNcLabel;
@property(nonatomic, strong) QMUIButton *applyBtn;
@property(nonatomic, strong) PTHomeSmallCardItemModel *model;
@end

@implementation PTHomeSmallCardCell

-(void)configModel:(PTHomeSmallCardItemModel*)model;
{
    self.model = model;
    self.eatenholeNcLabel.text = PTNotNull(model.eatenholeNc);
    self.cotentenderNcLabel.text = PTNotNull(model.cotentenderNc);
    
    
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

-(void)applyBtnClick
{
    if(self.applyClickBloack){
        self.applyClickBloack(self.model.retengnNc);
    }
}

- (void)createSubUI
{
    
    self.backImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *backImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyBtnClick)];
    [self.backImageView addGestureRecognizer:backImageTap];
    [self.contentView addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(-16.f);
        make.height.mas_equalTo(198.f);
    }];
    
    [self.backImageView addSubview:self.eatenholeNcLabel];
    [self.eatenholeNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(50.f);
        make.height.mas_equalTo(34.f);
    }];
    
    [self.backImageView addSubview:self.cotentenderNcLabel];
    [self.cotentenderNcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.eatenholeNcLabel.mas_leading);
        make.top.mas_equalTo(self.eatenholeNcLabel.mas_bottom).offset(6.f);
        make.height.mas_equalTo(14.f);
    }];

    
    [self.backImageView addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-16.f);
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(-16.f);
        make.height.mas_equalTo(42.f);
    }];
}


#pragma mark - lazy

-(UIImageView *)backImageView{
    if(!_backImageView){
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_samllCardBack"]];
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
