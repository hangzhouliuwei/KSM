//
//  PTIdentifyVerifySingleSelectCell.m
//  PTApp
//
//  Created by Jacky on 2024/8/24.
//

#import "PTIdentifyVerifySingleSelectCell.h"
#import "PTIdentifyModel.h"
#import "PTBasicVerifyModel.h"
@interface PTIdentifyVerifySingleSelectCell ()
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) UIButton *firsetBtn;
@property (nonatomic, strong) UIButton *secondBtn;
@property (nonatomic, strong) PTBasicRowModel *model;
@end
@implementation PTIdentifyVerifySingleSelectCell

-(void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.firsetBtn];
    [self.contentView addSubview:self.secondBtn];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(16);
    }];
    [self.secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(26);
    }];
    [self.firsetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.secondBtn.mas_left).offset(-10);
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(26);
    }];
  
}
- (void)configUIWithModel:(PTBasicRowModel *)model
{
    _model = model;
    _titleLabel.text = model.fltendgeNc;
    [model.tutenbodrillNc enumerateObjectsUsingBlock:^(PTBasicEnumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [self.firsetBtn setTitle:obj.uptenornNc forState:UIControlStateNormal];
            
        }else{
            [self.secondBtn setTitle:obj.uptenornNc forState:UIControlStateNormal];
        }
        if (obj.ittenlianizeNc == model.datenrymanNc.intValue) {
            if (idx == 0) {
                self.firsetBtn.selected = YES;
                
            }else{
                self.secondBtn.selected = YES;
            }
        }
    }];
}
- (void)firstClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.secondBtn.selected = NO;
    PTBasicEnumModel *enumModel = [self.model.tutenbodrillNc objectAtIndex:0];

    self.model.datenrymanNc = @(enumModel.ittenlianizeNc).stringValue;
    if (self.selectBlock) {
        self.selectBlock(self.model.datenrymanNc);
    }
    
}
- (void)secondClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.firsetBtn.selected = NO;

    PTBasicEnumModel *enumModel = [self.model.tutenbodrillNc objectAtIndex:1];
    self.model.datenrymanNc = @(enumModel.ittenlianizeNc).stringValue;
    if (self.selectBlock) {
        self.selectBlock(self.model.datenrymanNc);
    }
}
- (QMUILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
    }
    return _titleLabel;
}
- (UIButton *)firsetBtn
{
    if (!_firsetBtn) {
        _firsetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_firsetBtn setBackgroundImage:[UIImage imageNamed:@"pt_identify_single_normal"] forState:UIControlStateNormal];
        [_firsetBtn setBackgroundImage:[UIImage imageNamed:@"pt_identify_single_select"] forState:UIControlStateSelected];
        [_firsetBtn setTitleColor:PTUIColorFromHex(0x64F6FE) forState:UIControlStateNormal];
        [_firsetBtn setTitleColor:PTUIColorFromHex(0xffffff) forState:UIControlStateSelected];
        [_firsetBtn addTarget:self action:@selector(firstClick:) forControlEvents:UIControlEventTouchUpInside];


    }
    return _firsetBtn;
}
- (UIButton *)secondBtn
{
    if (!_secondBtn) {
        _secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secondBtn setBackgroundImage:[UIImage imageNamed:@"pt_identify_single_normal"] forState:UIControlStateNormal];
        [_secondBtn setBackgroundImage:[UIImage imageNamed:@"pt_identify_single_select"] forState:UIControlStateSelected];
        [_secondBtn setTitleColor:PTUIColorFromHex(0x64F6FE) forState:UIControlStateNormal];
        [_secondBtn setTitleColor:PTUIColorFromHex(0xffffff) forState:UIControlStateSelected];
        [_secondBtn addTarget:self action:@selector(secondClick:) forControlEvents:UIControlEventTouchUpInside];


    }
    return _secondBtn;
}
@end
