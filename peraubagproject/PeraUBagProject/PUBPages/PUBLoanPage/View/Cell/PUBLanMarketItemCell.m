//
//  PUBLanMarketItemCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/25.
//

#import "PUBLanMarketItemCell.h"
#import "PUBLoanMarketModel.h"

@interface PUBLanMarketItemCell()
@property(nonatomic, strong) UIImageView *backImageView;
///产品名称
@property(nonatomic, strong) UILabel *presenileEglabel;
///赞
@property(nonatomic, strong) UIImageView *zanImageView;
@property(nonatomic, strong) UILabel *momentaryEgLabel;
@property(nonatomic, strong) UIImageView *treasureEgImageView;
@property(nonatomic, strong) UILabel *ooliticEgLabel;
@property(nonatomic, strong) UILabel *indefensiblyEgLabel;
@property(nonatomic, strong) QMUIButton *applyBtn;
@property(nonatomic, strong) PUBLoanMarketItemModel *model;
@end

@implementation PUBLanMarketItemCell

- (void)configModel:(PUBLoanMarketItemModel*)model
{
    self.model = model;
    self.presenileEglabel.text = NotNull(model.presenile_eg);
    self.momentaryEgLabel.text = NotNull(model.momentary_eg);
    [self.treasureEgImageView sd_setImageWithURL:[NSURL URLWithString:NotNull(model.treasure_eg)]];
    self.ooliticEgLabel.text = NotNull(model.oolitic_eg);
    self.indefensiblyEgLabel.text = NotNull(model.indefensibly_eg);
    NSString *applyTitle = @"apply >";
    if(![PUBTools isBlankString:model.flinders_eg]){
        applyTitle = [NSString stringWithFormat:@"%@ >",model.flinders_eg];
    }
    
    CGFloat applyW = [PUBTools getTextVieWideForString:applyTitle andHigh:28.f andFont:FONT(12.f) andnumberOfLines:1.f];
    [self.applyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12.f);
        make.top.mas_equalTo(52.f);
        make.size.mas_equalTo(CGSizeMake(applyW+24.f, 28.f));
    }];
    [self.applyBtn setTitle:applyTitle forState:UIControlStateNormal];
    self.applyBtn.backgroundColor =  [UIColor qmui_colorWithHexString:NotNull(model.principled_eg)];
    [self.applyBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
}

- (void)backImageViewtapClick
{
    if(self.applyBtnClickBlock && ![PUBTools isBlankString:self.model.quilting_eg]){
        self.applyBtnClickBlock(self.model.quilting_eg);
    }
}

- (void)applyBtnClick
{
    if(self.applyBtnClickBlock && ![PUBTools isBlankString:self.model.quilting_eg]){
        self.applyBtnClickBlock(self.model.quilting_eg);
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initSubViews];
        [self initSubFrames];
    }
    return self;
}

- (void)initSubViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.backImageView];
    
    [self.backImageView addSubview:self.presenileEglabel];
    [self.backImageView addSubview:self.zanImageView];
    [self.backImageView addSubview:self.momentaryEgLabel];
    [self.backImageView addSubview:self.treasureEgImageView];
    [self.backImageView addSubview:self.ooliticEgLabel];
    [self.backImageView addSubview:self.indefensiblyEgLabel];
    [self.backImageView addSubview:self.applyBtn];
    
    UITapGestureRecognizer *backImageViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backImageViewtapClick)];
    [self.backImageView addGestureRecognizer:backImageViewtap];
}

- (void)initSubFrames
{
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(110.f);
    }];
    
    [self.presenileEglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8.f);
        make.left.mas_equalTo(25.f);
        make.height.mas_equalTo(16.f);
    }];
    
    [self.zanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4.f);
        make.left.mas_equalTo(196.f);
        make.size.mas_equalTo(CGSizeMake(14.f, 13.f));
    }];
    
    [self.momentaryEgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.zanImageView.mas_centerY).offset(2.f);
        make.left.mas_equalTo(self.zanImageView.mas_right).offset(4.f);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(8.f);
    }];
    
    [self.treasureEgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.f);
        make.top.mas_equalTo(self.presenileEglabel.mas_bottom).offset(12.f);
        make.size.mas_equalTo(CGSizeMake(64.f, 64.f));
    }];
    
    [self.ooliticEgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(44.f);
        make.left.mas_equalTo(self.treasureEgImageView.mas_right).offset(12.f);
        make.height.mas_equalTo(24.f);
    }];
    
    [self.indefensiblyEgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.ooliticEgLabel.mas_leading);
        make.top.mas_equalTo(self.ooliticEgLabel.mas_bottom).offset(4.f);
        make.height.mas_equalTo(14.f);
    }];
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12.f);
        make.top.mas_equalTo(52.f);
        make.size.mas_equalTo(CGSizeMake(72.f, 28.f));
    }];
}


#pragma mark - lazy
- (UIImageView *)backImageView{
    if(!_backImageView){
        _backImageView = [[UIImageView alloc] init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.image = [PUBTools imageResize:ImageWithName(@"pub_loan_marktback") withResizeTo:CGSizeMake(KSCREEN_WIDTH -20.f, 110.f)];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

-(UILabel *)presenileEglabel{
    if(!_presenileEglabel){
        _presenileEglabel = [[UILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor qmui_colorWithHexString:@"#E1E7FA"]];
    }
    return _presenileEglabel;
}

-(UIImageView *)zanImageView{
    if(!_zanImageView){
        _zanImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_loan_marktzan"]];
        _zanImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _zanImageView;
}

-(UILabel *)momentaryEgLabel{
    if(!_momentaryEgLabel){
        _momentaryEgLabel = [[UILabel alloc] qmui_initWithFont:FONT(8.f) textColor:[UIColor qmui_colorWithHexString:@"#00FFD7"]];
        _momentaryEgLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _momentaryEgLabel;
}

-(UIImageView *)treasureEgImageView{
    if(!_treasureEgImageView){
        _treasureEgImageView = [[UIImageView alloc] init];
        _treasureEgImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _treasureEgImageView;
}

-(UILabel *)ooliticEgLabel{
    if(!_ooliticEgLabel){
        _ooliticEgLabel = [[UILabel alloc] qmui_initWithFont:FONT(24.f) textColor:[UIColor whiteColor]];
        _ooliticEgLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _ooliticEgLabel;
}

-(UILabel *)indefensiblyEgLabel{
    if(!_indefensiblyEgLabel){
        _indefensiblyEgLabel = [[UILabel alloc] qmui_initWithFont:FONT(10.f) textColor:[UIColor whiteColor]];
        _indefensiblyEgLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _indefensiblyEgLabel;
}

- (QMUIButton *)applyBtn{
    if(!_applyBtn){
        _applyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _applyBtn.titleLabel.font = FONT(12.f);
        _applyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _applyBtn.cornerRadius = 14.f;
        [_applyBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyBtn;
}

@end
