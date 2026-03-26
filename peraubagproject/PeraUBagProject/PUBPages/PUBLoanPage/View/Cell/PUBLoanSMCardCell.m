//
//  PUBLoanSMCardCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/25.
//

#import "PUBLoanSMCardCell.h"
#import "PUBLoanBgCardModel.h"

@interface PUBLoanSMCardCell()
@property(nonatomic, strong) UIImageView *cardImageView;
@property(nonatomic, strong) UIImageView *treasureEgImage;
@property(nonatomic, strong) UILabel *presenileEgLabel;
@property(nonatomic, strong) UILabel *ooliticEgLabel;
@property(nonatomic, strong) UILabel *indefensiblyEgLabel;
@property(nonatomic, strong) QMUIButton *flindersEgBtn;
@property(nonatomic, strong) YYLabel *privacyLabel;
@property(nonatomic, strong) PUBLoanBgCardItemModel *model;
@end
@implementation PUBLoanSMCardCell

- (void)configModel:(PUBLoanBgCardItemModel*)model
{
    self.model = model;
    self.ooliticEgLabel.text = NotNull(model.oolitic_eg);
    self.presenileEgLabel.text = NotNull(model.presenile_eg);
    self.indefensiblyEgLabel.text = NotNull(model.indefensibly_eg);
    [self.treasureEgImage sd_setImageWithURL:[NSURL URLWithString:model.treasure_eg]];
    [self.flindersEgBtn setTitle:NotNull(model.flinders_eg) forState:UIControlStateNormal];
    self.flindersEgBtn.backgroundColor = [UIColor qmui_colorWithHexString: [PUBTools isBlankString:model.principled_eg] ? @"#00FFD7" : model.principled_eg];
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
    [self.contentView addSubview:self.cardImageView];
    [self.cardImageView addSubview:self.presenileEgLabel];
    [self.cardImageView addSubview:self.treasureEgImage];
    [self.cardImageView addSubview:self.ooliticEgLabel];
    [self.cardImageView addSubview:self.indefensiblyEgLabel];
    [self.cardImageView addSubview:self.flindersEgBtn];
    
    [self.contentView addSubview:self.privacyLabel];
    
}

- (void)initSubFrames
{
    [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(186.f);
    }];
    
    [self.presenileEgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22.f);
        make.top.mas_equalTo(4.f);
        make.height.mas_equalTo(16.f);
    }];
    
    
    [self.treasureEgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54.f);
        make.left.mas_equalTo(54.f);
        make.size.mas_equalTo(CGSizeMake(58.f, 48.f));
    }];
    
    
    
    [self.ooliticEgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.treasureEgImage.mas_right).offset(18.f);
        make.top.mas_equalTo(35.f);
        make.height.mas_equalTo(60.f);
    }];
    
   
    
    [self.indefensiblyEgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ooliticEgLabel.mas_bottom);
        make.leading.mas_equalTo(self.ooliticEgLabel.mas_leading);
        make.height.mas_equalTo(10.f);
    }];
    
    
    [self.flindersEgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.indefensiblyEgLabel.mas_bottom).offset(12.f);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.privacyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.cardImageView.mas_bottom).offset(12.f);
        make.size.mas_equalTo(CGSizeMake(KSCREEN_WIDTH - 40.f, 18.f));
    }];
}

- (void)applyBtnClick
{
    if(self.applyBtnClickBlock && self.model.glaciated_eg){
        self.applyBtnClickBlock(self.model.quilting_eg);
    }
    
}

#pragma mark - lazay
- (UIImageView *)cardImageView{
    if(!_cardImageView){
        _cardImageView = [[UIImageView alloc] init];
        _cardImageView.contentMode = UIViewContentModeScaleAspectFill;
        _cardImageView.image = [PUBTools imageResize:ImageWithName(@"pub_loan_smcardback") withResizeTo:CGSizeMake(KSCREEN_WIDTH -40.f, 186.f)];
        _cardImageView.userInteractionEnabled = YES;
    }
    
    return _cardImageView;
}

- (UIImageView *)treasureEgImage{
    if(!_treasureEgImage){
        _treasureEgImage = [[UIImageView alloc] qmui_initWithSize:CGSizeMake(58.f, 58.f)];
        _treasureEgImage.contentMode = UIViewContentModeScaleAspectFit;
        _treasureEgImage.layer.cornerRadius = 8.f;
        
    }
    return _treasureEgImage;
}

-(UILabel *)presenileEgLabel{
    
    if(!_presenileEgLabel){
        _presenileEgLabel = [[UILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor whiteColor]];
        _presenileEgLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _presenileEgLabel;
}


-(UILabel *)ooliticEgLabel{
    if(!_ooliticEgLabel){
        _ooliticEgLabel = [[UILabel alloc] qmui_initWithFont:[UIFont boldSystemFontOfSize:40.f] textColor:[UIColor whiteColor]];
        _ooliticEgLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _ooliticEgLabel;
}

-(UILabel *)indefensiblyEgLabel{
    if(!_indefensiblyEgLabel){
        _indefensiblyEgLabel = [[UILabel alloc] qmui_initWithFont:FONT(9.f) textColor:[UIColor whiteColor]];
        _indefensiblyEgLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _indefensiblyEgLabel;
}

- (QMUIButton *)flindersEgBtn{
    if(!_flindersEgBtn){
        _flindersEgBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _flindersEgBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
        [_flindersEgBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [_flindersEgBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _flindersEgBtn.titleLabel.font = FONT(20.f);
        _flindersEgBtn.cornerRadius = 24.f;
    }
    return _flindersEgBtn;
}

- (YYLabel *)privacyLabel{
    if(!_privacyLabel){
        _privacyLabel = [[YYLabel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH - 40.f, 18.f)];
        _privacyLabel.textAlignment = NSTextAlignmentCenter;
        _privacyLabel.font = FONT(17.f);
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 设置文字居中
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSDictionary *attributes = @{NSFontAttributeName:FONT(12), NSForegroundColorAttributeName: [UIColor qmui_colorWithHexString:@"#FFFFFF"],NSParagraphStyleAttributeName : paragraphStyle};
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Click to view the Privacy Agreement" attributes:attributes];
        [text addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:[[text string] rangeOfString:@"Privacy Agreement"]];
        //设置高亮色和点击事件
        WEAKSELF
        [text yy_setTextHighlightRange:[[text string] rangeOfString:@"Privacy Agreement"] color:[UIColor qmui_colorWithHexString:@"#00FFD7"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            STRONGSELF
            if(strongSelf.privacyClickBlock){
                strongSelf.privacyClickBlock();
            }
        }];
      _privacyLabel.attributedText = text;
    }
    return _privacyLabel;
}

@end
