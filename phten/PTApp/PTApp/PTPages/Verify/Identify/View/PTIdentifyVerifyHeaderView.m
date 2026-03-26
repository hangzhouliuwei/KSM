//
//  PTIdentifyVerifyHeaderView.m
//  PTApp
//
//  Created by Jacky on 2024/8/24.
//

#import "PTIdentifyVerifyHeaderView.h"
#import "PTBasicVerifySectionHeader.h"
#import "PTIdentifyModel.h"
@interface PTIdentifyVerifyHeaderView ()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) PTBasicVerifySectionHeader *headerView;
@property (nonatomic, strong) UIView *selectBgView;
@property (nonatomic, strong) QMUILabel *selectTitleLabel;
@property (nonatomic, strong) QMUILabel *selectValueLabel;
@property (nonatomic, strong) UIImageView *selectArrow;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIView *uploadBg;
@property (nonatomic, strong) UIImageView *idcardImage;
@property (nonatomic, strong) UIImageView *uploadImage;

@property (nonatomic, assign) BOOL canSelect;


@end
@implementation PTIdentifyVerifyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.canSelect = YES;
    }
    return self;
}
//选了证件类型 此时 uoload 按钮还是显示
- (void)updateModel:(PTIdentifyListModel *)model
{
    [self.idcardImage sd_setImageWithURL:[NSURL URLWithString:model.ovtenrpunchNc] placeholderImage:[UIImage imageNamed:@"pt_identify_idcard"]];
    self.selectValueLabel.text = model.rotenanizeNc;
    self.selectValueLabel.textColor = PTUIColorFromHex(0x000000);
    self.selectIdCardNo = model.cetenNc;

}
- (void)updateIDcardImage:(UIImage *)IDcardImage
{
    self.idcardImage.image = IDcardImage;
    self.canSelect = NO;
    self.uploadImage.hidden = YES;
}
- (void)updateIDcardImageUrl:(NSString *)url bankName:(nonnull NSString *)name
{
    if (![PTNotNull(url) br_isBlankString]) {
        _canSelect = NO;
        self.uploadImage.hidden = YES;
    }
    [self.idcardImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pt_identify_idcard"]];
    self.selectValueLabel.text = name;
    self.selectValueLabel.textColor = PTUIColorFromHex(0x000000);
}

- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headerView];
    [self.bgView addSubview:self.selectBgView];
    [self.selectBgView addSubview:self.selectTitleLabel];
    [self.selectBgView addSubview:self.selectValueLabel];
    [self.selectBgView addSubview:self.selectArrow];
    [self.selectBgView addSubview:self.line];
    [self.bgView addSubview:self.uploadBg];
    [self.uploadBg addSubview:self.idcardImage];
    [self.uploadBg addSubview:self.uploadImage];

    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(351);
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(46);
    }];
    [self.selectBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(65);
        make.top.mas_equalTo(46);
    }];
    [self.selectTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(16);
    }];
    [self.selectValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(self.selectTitleLabel.mas_bottom).offset(12);
    }];
    [self.selectArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.selectValueLabel);
        make.right.mas_equalTo(-16);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(-1);
    }];
    
    [self.uploadBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.selectBgView.mas_bottom);
        make.height.mas_equalTo(250);
    }];
    [self.idcardImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(279, 144));
    }];
    [self.uploadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.idcardImage.mas_bottom).offset(24);
        make.centerX.mas_equalTo(0);

        make.size.mas_equalTo(CGSizeMake(128, 40));

    }];
    [self.headerView updateUIWithTitle:@"Upload your ID" Subtitle:@"" more:NO isSelected:NO];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCardAction)];
    [self.selectBgView addGestureRecognizer:tap];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadAction)];
    [self.uploadBg addGestureRecognizer:tap2];
}
- (void)selectCardAction{
    if (!self.canSelect) {
        return;
    }
    if (self.selectTypeBlock) {
        self.selectTypeBlock();
    }
}
- (void)uploadAction{
    if (!self.canSelect) {
        return;
    }
    if (self.uploadClickBlock) {
        self.uploadClickBlock();
    }
}
#pragma mark -
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (PTBasicVerifySectionHeader *)headerView
{
    if (!_headerView) {
        _headerView = [[PTBasicVerifySectionHeader alloc] initWithFrame:CGRectZero];
    }
    return _headerView;
}
- (UIView *)selectBgView
{
    if (!_selectBgView) {
        _selectBgView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _selectBgView;
}
- (UIView *)uploadBg
{
    if (!_uploadBg) {
        _uploadBg = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _uploadBg;
}
- (QMUILabel *)selectTitleLabel
{
    if (!_selectTitleLabel) {
        _selectTitleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
        _selectTitleLabel.text = @"Select ID Type";
    }
    return _selectTitleLabel;
}
- (QMUILabel *)selectValueLabel
{
    if (!_selectValueLabel) {
        _selectValueLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_M(12) textColor:RGBA(100, 122, 64, 0.32)];
        _selectValueLabel.text = @"Please Select";
    }
    return _selectValueLabel;
}
- (UIImageView *)selectArrow
{
    if (!_selectArrow) {
        _selectArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_basic_arrow_down"]];
    }
    return _selectArrow;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = PTUIColorFromHex(0xE6F0FD);
    }
    return _line;
}
- (UIImageView *)idcardImage
{
    if (!_idcardImage) {
        _idcardImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_identify_idcard"]];
    }
    return _idcardImage;
}
- (UIImageView *)uploadImage
{
    if (!_uploadImage) {
        _uploadImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_identify_idcard_upload"]];

    }
    return _uploadImage;
}
@end
