//
//  PTVerifyEnumCell.m
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTVerifyEnumCell.h"
#import "PTBasicVerifyModel.h"
static BOOL isClicking = NO;
@interface PTVerifyEnumCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UIView *line;
@end

@implementation PTVerifyEnumCell


- (void)setupUI{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
    [self addGestureRecognizer:tap];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.valueLabel];
    [self.contentView addSubview:self.arrow];
    [self.contentView addSubview:self.line];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(16);
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(self.titleLabel.mas_left);
    }];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.centerY.mas_equalTo(self.valueLabel);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}
- (void)clickAction{
    if (isClicking) {
        return;
    }
    if(self.clickBlock){
        isClicking = YES;
        self.clickBlock();
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isClicking = NO;
        });
    }
}
- (void)configUIWithModel:(id)model
{
    PTBasicRowModel *row = model;
    self.titleLabel.text = row.fltendgeNc;
    if ([row.datenrymanNc intValue] != 0) {
        self.valueLabel.font = PT_Font(14);
        self.valueLabel.textColor = PTUIColorFromHex(0x000000);
        if ([row.cellType isEqual:@"day"]) {
            self.valueLabel.text = row.datenrymanNc;
        }else{
            [row.tutenbodrillNc enumerateObjectsUsingBlock:^(PTBasicEnumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.ittenlianizeNc == row.datenrymanNc.integerValue) {
                    self.valueLabel.text = obj.uptenornNc;
                    *stop = YES;
                }
            }];
        }
    }else {
        self.valueLabel.text = row.orteninarilyNc;
        self.valueLabel.font = PT_Font(12);
        self.valueLabel.textColor = RGBA(100, 122, 64, 0.32);
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
//        _titleLabel.
    }
    return _titleLabel;
}
- (UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
//        _titleLabel.
    }
    return _valueLabel;
}
- (UIImageView *)arrow
{
    if (!_arrow) {
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_basic_arrow_down"]];
    }
    return _arrow;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = PTUIColorFromHex(0xE6F0FD);
    }
    return _line;
}
@end
