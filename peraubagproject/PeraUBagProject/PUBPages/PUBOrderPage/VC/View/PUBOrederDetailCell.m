//
//  PUBOrederDetailCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/15.
//

#import "PUBOrederDetailCell.h"
#import "PUBOrederModel.h"

@interface PUBOrederDetailCell()
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UIImageView *iocnImageView;
@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) QMUILabel *orederSatsLabel;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) QMUILabel *proconsulateTextLabel;
@property(nonatomic, strong) QMUILabel *proconsulateLabel;
@property(nonatomic, strong) QMUILabel *pinxitEgTextLabel;
@property(nonatomic, strong) QMUILabel *pinxitEgLabel;
@property(nonatomic, strong) QMUIButton *flindersBtn;
@property(nonatomic, strong) PUBOrederItemModel *model;
@end

@implementation PUBOrederDetailCell

- (void)flindersBtnClick
{
    if(self.cellBlock){
        self.cellBlock(self.model);
    }
}

- (void)configModel:(PUBOrederItemModel*)model
{
    self.model = model;
    [self.iocnImageView sd_setImageWithURL:[NSURL URLWithString:NotNull(model.treasure_eg)] placeholderImage:[UIImage imageNamed:@"pub_orederDetail_iocn"]];
    
    self.titleLabel.text = NotNull(model.presenile_eg);
    self.orederSatsLabel.text = NotNull(model.parvus_eg);
    self.orederSatsLabel.textColor = [UIColor qmui_colorWithHexString: [PUBTools isBlankString:model.diphenylketone_eg] ? @"#B4B8C7" : model.diphenylketone_eg];
    
    self.proconsulateLabel.text = NotNull(model.proconsulate_eg);
    if(![PUBTools isBlankString:model.pinxit_eg]){
        self.pinxitEgTextLabel.hidden = NO;
        self.pinxitEgLabel.hidden = NO;
        self.pinxitEgLabel.text = NotNull(model.pinxit_eg);
    }else{
        self.pinxitEgTextLabel.hidden = YES;
        self.pinxitEgLabel.hidden = YES;
    }
    
    if(![PUBTools isBlankString:model.flinders_eg]){
        self.flindersBtn.hidden = NO;
        CGFloat btnW = [PUBTools getTextVieWideForString:model.flinders_eg andHigh:48.f andFont:FONT(20.f) andnumberOfLines:1];
        self.flindersBtn.backgroundColor = [UIColor qmui_colorWithHexString:NotNull(model.ninogan_eg)];
        [self.flindersBtn setTitle:NotNull(model.flinders_eg) forState:UIControlStateNormal];
        [self.flindersBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-16.f);
            make.bottom.mas_equalTo(-24.f);
            make.size.mas_equalTo(CGSizeMake(btnW+ 64.f, 48.f));
        }];
    }else{
        self.flindersBtn.hidden = YES;
    }
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        [self iniSubViews];
        [self iniSubFamers];
    }
    
    return self;
}

- (void)iniSubViews
{
    [self.contentView addSubview:self.backView];
    
    [self.backView addSubview:self.iocnImageView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.orederSatsLabel];
    [self.backView addSubview:self.lineView];
    [self.backView addSubview:self.proconsulateTextLabel];
    [self.backView addSubview:self.proconsulateLabel];
    [self.backView addSubview:self.pinxitEgTextLabel];
    [self.backView addSubview:self.pinxitEgLabel];
    [self.backView addSubview:self.flindersBtn];
}

- (void)iniSubFamers
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-20.f);
        make.bottom.mas_equalTo(-14.f);
    }];
    
    
    [self.iocnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(14.f);
        make.top.mas_offset(12.f);
        make.size.mas_equalTo(CGSizeMake(32.f, 32.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iocnImageView.mas_right).offset(10.f);
        make.centerY.mas_equalTo(self.iocnImageView.mas_centerY);
    }];
    
    [self.orederSatsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-14.f);
        make.centerY.mas_equalTo(self.iocnImageView.mas_centerY);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(14.f);
        make.right.mas_equalTo(-14.f);
        make.top.mas_equalTo(self.iocnImageView.mas_bottom).offset(10.f);
        make.height.mas_equalTo(0.8f);
    }];
    
    [self.proconsulateTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.f);
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(28.f);
        make.height.mas_equalTo(16.f);
    }];
    
    [self.proconsulateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-14.f);
        make.centerY.mas_equalTo(self.proconsulateTextLabel.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    
    [self.pinxitEgTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.f);
        make.top.mas_equalTo(self.proconsulateTextLabel.mas_bottom).offset(8.f);
        make.height.mas_equalTo(16.f);
    }];
    
    [self.pinxitEgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-14.f);
        make.centerY.mas_equalTo(self.pinxitEgTextLabel.mas_centerY);
        make.height.mas_equalTo(16.f);
    }];
    
}

#pragma mark - lazy
-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc] init];
        [_backView showRadius:24.f];
        _backView.backgroundColor = [UIColor qmui_colorWithHexString:@"#444959"];
    }
    return _backView;
}

- (UIImageView *)iocnImageView{
    if(!_iocnImageView){
        _iocnImageView = [[UIImageView alloc] init];
        _iocnImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_iocnImageView showRadius:16.f];
    }
    return _iocnImageView;
}

- (QMUILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:FONT(16.f) textColor:[UIColor qmui_colorWithHexString:@"#E1E7FA"]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}


- (QMUILabel *)orederSatsLabel{
    if(!_orederSatsLabel){
        _orederSatsLabel = [[QMUILabel alloc] qmui_initWithFont:FONT(12.f) textColor:[UIColor qmui_colorWithHexString:@"#B4B8C7"]];
        _orederSatsLabel.textAlignment = NSTextAlignmentRight;
    }
    return _orederSatsLabel;
}

- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor qmui_colorWithHexString:@"#C7B5FF"];
        _lineView.alpha = 0.16f;
        
    }
    return _lineView;
}

- (QMUILabel *)proconsulateTextLabel{
    if(!_proconsulateTextLabel){
        _proconsulateTextLabel = [[QMUILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor qmui_colorWithHexString:@"#B4B8C7"]];
        _proconsulateTextLabel.textAlignment = NSTextAlignmentLeft;
        _proconsulateTextLabel.text = @"Loan Amount";
    }
    return _proconsulateTextLabel;
}

- (QMUILabel *)proconsulateLabel{
    if(!_proconsulateLabel){
        _proconsulateLabel = [[QMUILabel alloc] qmui_initWithFont:FONT(28.f) textColor:[UIColor qmui_colorWithHexString:@"#FFFFFF"]];
        _proconsulateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _proconsulateLabel;
}

- (QMUILabel *)pinxitEgTextLabel{
    if(!_pinxitEgTextLabel){
        _pinxitEgTextLabel = [[QMUILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor qmui_colorWithHexString:@"#B4B8C7"]];
        _pinxitEgTextLabel.textAlignment = NSTextAlignmentLeft;
        _pinxitEgTextLabel.text = @"Repayment date";
        _pinxitEgTextLabel.hidden = YES;
    }
    return _pinxitEgTextLabel;
}

- (QMUILabel *)pinxitEgLabel{
    if(!_pinxitEgLabel){
        _pinxitEgLabel = [[QMUILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor qmui_colorWithHexString:@"#B4B8C7"]];
        _pinxitEgLabel.textAlignment = NSTextAlignmentRight;
        _pinxitEgLabel.hidden = YES;
    }
    return _pinxitEgLabel;
}

- (QMUIButton *)flindersBtn{
    if(!_flindersBtn){
        _flindersBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _flindersBtn.titleLabel.font = FONT(20.f);
        [_flindersBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#13062A"] forState:UIControlStateNormal];
        [_flindersBtn showRadius:24.f];
        _flindersBtn.hidden = YES;
        [_flindersBtn addTarget:self action:@selector(flindersBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flindersBtn;
}

@end
