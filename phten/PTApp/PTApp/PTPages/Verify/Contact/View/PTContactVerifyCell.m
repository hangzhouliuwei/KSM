//
//  PTContactVerifyCell.m
//  PTApp
//
//  Created by Jacky on 2024/8/24.
//

#import "PTContactVerifyCell.h"
#import "PTContactVerifyModel.h"
#import "PTBasicVerifySectionHeader.h"
@interface PTContactVerifyCell()
@property (nonatomic, strong) PTBasicVerifySectionHeader *header;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *relationBg;
@property (nonatomic, strong) QMUILabel *relationTitle;
@property (nonatomic, strong) QMUILabel *relationValue;
@property (nonatomic, strong) UIImageView *relationArrow;
@property (nonatomic, strong) UIView *line;


@property (nonatomic, strong) UIView *contactBg;
@property (nonatomic, strong) QMUILabel *contactName;
@property (nonatomic, strong) QMUILabel *contactNameValue;
@property (nonatomic, strong) QMUILabel *contactPhone;
@property (nonatomic, strong) QMUILabel *contactPhoneValue;

@end
@implementation PTContactVerifyCell

- (void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 8;
    self.contentView.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];

    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.header];
    [self.contentView addSubview:self.relationBg];
    [self.relationBg addSubview:self.relationTitle];
    [self.relationBg addSubview:self.relationValue];
    [self.relationBg addSubview:self.relationArrow];
    [self.relationBg addSubview:self.line];
    [self.contentView addSubview:self.contactBg];
    [self.contactBg addSubview:self.contactName];
    [self.contactBg addSubview:self.contactNameValue];
    [self.contactBg addSubview:self.contactPhone];
    [self.contactBg addSubview:self.contactPhoneValue];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.relationBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(65);
    }];
    [self.relationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(16);
    }];
    [self.relationValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(self.relationTitle.mas_bottom).offset(12);
    }];
    [self.relationArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.centerY.mas_equalTo(self.relationValue);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1.f);
        make.bottom.mas_equalTo(self.relationBg.mas_bottom).offset(-1);
    }];
    
    [self.contactBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(72.f);
        make.top.mas_equalTo(self.line.mas_bottom).offset(16);
    }];
    [self.contactName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(16);
    }];
    [self.contactNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(137);
        make.centerY.mas_equalTo(self.contactName);
    }];
    [self.contactPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(self.contactName.mas_bottom).offset(15);
    }];
    [self.contactPhoneValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(137);
        make.centerY.mas_equalTo(self.contactPhone);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRelation)];
    [self.relationBg addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContact)];
    [self.contactBg addGestureRecognizer:tap2];
    
}
- (void)configUIWithModel:(PTContactItmeModel *)model
{
    [self.header updateUIWithTitle:model.fltendgeNc Subtitle:@"" more:NO isSelected:NO];
    if(model.kotenNc.betendieNc != 0){
        [model.betendieNc enumerateObjectsUsingBlock:^(PTContactRelationEnumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(obj.detenmphasizeNc == model.kotenNc.betendieNc){
                self.relationValue.text = obj.uptenornNc;
                *stop = YES;
            }
        }];
        self.relationValue.textColor = PTUIColorFromHex(0x000000);
    }else{
        self.relationValue.text = @"Please Select";
    }
    
    self.contactNameValue.text = [model.kotenNc.uptenornNc br_isBlankString] ? @"Please Select" : model.kotenNc.uptenornNc;
    self.contactNameValue.textColor = [model.kotenNc.uptenornNc br_isBlankString] ? RGBA(100, 122, 64, 0.32) : [UIColor qmui_colorWithHexString:@"#000000"];
    
    self.contactPhoneValue.text = [model.kotenNc.hatenlowNc br_isBlankString] ? @"Please Select" : model.kotenNc.hatenlowNc;
    self.contactPhoneValue.textColor = [model.kotenNc.hatenlowNc br_isBlankString] ? RGBA(100, 122, 64, 0.32) : [UIColor qmui_colorWithHexString:@"#000000"];
}
- (void)clickRelation{
    if (self.relationClick) {
        self.relationClick();
    }
}
- (void)clickContact{
    if (self.contactClick) {
        self.contactClick();
    }
}
#pragma mark - getter
- (PTBasicVerifySectionHeader *)header
{
    if (!_header) {
        _header = [[PTBasicVerifySectionHeader alloc] initWithFrame:CGRectZero];
    }
    return _header;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame: CGRectZero];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.layer.cornerRadius = 8;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
- (UIView *)relationBg
{
    if (!_relationBg) {
        _relationBg = [[UIView alloc]initWithFrame: CGRectZero];
        _relationBg.backgroundColor = [UIColor clearColor];
    }
    return _relationBg;
}
- (UIView *)contactBg
{
    if (!_contactBg) {
        _contactBg = [[UIView alloc]initWithFrame: CGRectZero];
        _contactBg.backgroundColor = PTUIColorFromHex(0xF5F9FF);
    }
    return _contactBg;
}
- (QMUILabel *)relationTitle
{
    if (!_relationTitle) {
        _relationTitle = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
        _relationTitle.text = @"Relationship";
    }
    return _relationTitle;
}
- (QMUILabel *)relationValue
{
    if (!_relationValue) {
        _relationValue = [[QMUILabel alloc] qmui_initWithFont:PT_Font_M(12) textColor:RGBA(100, 122, 64, 0.32)];
        _relationValue.text = @"friend";
    }
    return _relationValue;
}
- (UIImageView *)relationArrow
{
    if (!_relationArrow) {
        _relationArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_basic_arrow_down"]];
    }
    return _relationArrow;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = PTUIColorFromHex(0xE6F0FD);
    }
    return _line;
}
- (QMUILabel *)contactName
{
    if (!_contactName) {
        _contactName = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
        _contactName.text = @"Name";

    }
    return _contactName;
}
- (QMUILabel *)contactNameValue
{
    if (!_contactNameValue) {
        _contactNameValue = [[QMUILabel alloc] qmui_initWithFont:PT_Font_M(12) textColor:PTUIColorFromHex(0x647A40)];
    }
    return _contactNameValue;
}
- (QMUILabel *)contactPhone
{
    if (!_contactPhone) {
        _contactPhone = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
        _contactPhone.text = @"Phone Number";

    }
    return _contactPhone;
}
- (QMUILabel *)contactPhoneValue
{
    if (!_contactPhoneValue) {
        _contactPhoneValue = [[QMUILabel alloc] qmui_initWithFont:PT_Font_M(12) textColor:PTUIColorFromHex(0x647A40)];
    }
    return _contactPhoneValue;
}
@end
