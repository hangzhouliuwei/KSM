//
//  PUBPhotoOptionCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/9.
//

#import "PUBPhotoOptionCell.h"
#import "PUBBasicModel.h"
@interface PUBPhotoOptionCell()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) QMUIButton *maleBtn;
@property(nonatomic, strong) QMUIButton *femaleBtn;
@property(nonatomic, strong) PUBBasicSomesuchEgModel *model;
@end

@implementation PUBPhotoOptionCell


-(void)configModel:(PUBBasicSomesuchEgModel*)model
{
    self.titleLabel.text = NotNull(model.neanderthaloid_eg);
    self.model = model;
    if(model.oerlikon_eg.integerValue !=0){
        WEAKSELF
        [model.horrific_eg enumerateObjectsUsingBlock:^(PUBBasicHorrificEgModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(model.oerlikon_eg.integerValue == obj.vibronic_eg){
                model.oerlikon_eg = [NSString stringWithFormat:@"%ld",obj.vibronic_eg];
                if([obj.rhodo_eg isEqual:@"Male"]){
                    strongSelf.maleBtn.selected = YES;
                    strongSelf.maleBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
                    strongSelf.femaleBtn.selected = NO;
                    strongSelf.femaleBtn.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.2f];
                }else if ([obj.rhodo_eg isEqual:@"Female"]){
                    strongSelf.maleBtn.selected = NO;
                    strongSelf.maleBtn.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.2f];
                    
                    strongSelf.femaleBtn.selected = YES;
                    strongSelf.femaleBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
                }
                *stop = YES;
            }
        }];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        [self initSubViews];
        [self initSubFames];
    }
    
    return self;
}

- (void)initSubViews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.maleBtn];
    [self.contentView addSubview:self.femaleBtn];
    
}

- (void)initSubFames
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(14.f);
    }];
    
    [self.maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24.f);
        make.left.mas_equalTo(20.f);
        make.size.mas_equalTo(CGSizeMake(120.f, 40.f));
    }];
    
    [self.femaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24.f);
        make.left.mas_equalTo(self.maleBtn.mas_right).offset(35.f);
        make.size.mas_equalTo(CGSizeMake(120.f, 40.f));
    }];
}

- (void)maleBtnClick:(QMUIButton*)btn
{
    btn.selected = !btn.selected;
    btn.backgroundColor = btn.selected ? [UIColor qmui_colorWithHexString:@"#00FFD7"] : [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.2f];
    if(btn.selected){
        self.femaleBtn.selected = NO;
        self.femaleBtn.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.2f];
        PUBBasicHorrificEgModel *egMOdel = [self.model.horrific_eg objectAtIndex:0];
        self.model.oerlikon_eg = [NSString stringWithFormat:@"%ld",egMOdel.vibronic_eg];
        if(self.photoOptionBlock){
            self.photoOptionBlock(self.model.oerlikon_eg);
        }
    }
}
- (void)femaleBtnClick:(QMUIButton*)btn
{
    btn.selected = !btn.selected;
    btn.backgroundColor = btn.selected ? [UIColor qmui_colorWithHexString:@"#00FFD7"] : [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.2f];
    if(btn.selected){
        self.maleBtn.selected = NO;
        self.maleBtn.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.2f];
        PUBBasicHorrificEgModel *egMOdel = [self.model.horrific_eg objectAtIndex:1];
        self.model.oerlikon_eg = [NSString stringWithFormat:@"%ld",egMOdel.vibronic_eg];
        if(self.photoOptionBlock){
            self.photoOptionBlock(self.model.oerlikon_eg);
        }
    }
}

#pragma mark - lazy

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] qmui_initWithFont:FONT(12.f) textColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (QMUIButton *)maleBtn{
    if(!_maleBtn){
        _maleBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _maleBtn.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.2f];
        _maleBtn.cornerRadius = 12.f;
        [_maleBtn setImage:[UIImage imageNamed:@"pub_photo_optionNormal"] forState:UIControlStateNormal];
        [_maleBtn setImage:[UIImage imageNamed:@"pub_photo_optionSelect"] forState:UIControlStateSelected];
        [_maleBtn setTitle:@"Male" forState:UIControlStateNormal];
        [_maleBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_maleBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#000000"] forState:UIControlStateSelected];
        _maleBtn.imagePosition = QMUIButtonImagePositionLeft;
        _maleBtn.spacingBetweenImageAndTitle = 4.f;
        _maleBtn.imageView.layer.cornerRadius = 6;
        _maleBtn.imageView.clipsToBounds = YES;
        _maleBtn.titleLabel.font = FONT(14.f);
        [_maleBtn addTarget:self action:@selector(maleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maleBtn;
}

- (QMUIButton *)femaleBtn{
    if(!_femaleBtn){
        _femaleBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _femaleBtn.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.2f];
        _femaleBtn.cornerRadius = 12.f;
        [_femaleBtn setImage:[UIImage imageNamed:@"pub_photo_optionNormal"] forState:UIControlStateNormal];
        [_femaleBtn setImage:[UIImage imageNamed:@"pub_photo_optionSelect"] forState:UIControlStateSelected];
        [_femaleBtn setTitle:@"Female" forState:UIControlStateNormal];
        [_femaleBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_femaleBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#000000"] forState:UIControlStateSelected];
        _femaleBtn.imagePosition = QMUIButtonImagePositionLeft;
        _femaleBtn.imageView.layer.cornerRadius = 6;
        _femaleBtn.imageView.clipsToBounds = YES;
        _femaleBtn.spacingBetweenImageAndTitle = 4.f;
        _femaleBtn.titleLabel.font = FONT(14.f);
        [_femaleBtn addTarget:self action:@selector(femaleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _femaleBtn;
}



@end
