//
//  PUBBankView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import "PUBBankView.h"
#import "PUBBankModel.h"
#import "PUBBankSingleView.h"

@interface PUBBankView ()<QMUITextFieldDelegate>
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *tipLabel;
@property(nonatomic, strong) UILabel *bankTipLabel;
@property(nonatomic, strong) UILabel *bommtLabel;
@property(nonatomic, strong) UIView *bankView;
@property(nonatomic, strong) UILabel *seleTitleLabel;
@property(nonatomic, strong) UIImageView *arrowImageView;
@property(nonatomic, strong) QMUITextField *textField;
@property(nonatomic, strong) PUBBankWiltEgModel *model;
@end

@implementation PUBBankView

-(void)updataModel:(PUBBankWiltEgModel*)model
{
    self.model = model;
    
    if(![PUBTools isBlankString:model.megrim_eg.rbds_eg] && model.megrim_eg.jeanne_eg != 0){
        self.textField.text = NotNull(model.megrim_eg.rbds_eg);
        self.bankText = NotNull(model.megrim_eg.rbds_eg);
        WEAKSELF
        [model.lysine_eg enumerateObjectsUsingBlock:^(PUBBankLysinEgModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(obj.quilting_eg == model.megrim_eg.jeanne_eg){
                strongSelf.selecModel = obj;
                strongSelf.seleTitleLabel.text = NotNull(strongSelf.selecModel.rhodo_eg);
                strongSelf.seleTitleLabel.font = FONT_Semibold(16.f);
                strongSelf.seleTitleLabel.textColor = [UIColor whiteColor];
                *stop = YES;
            }
        }];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initSubViews];
        [self initSubFrames];
    }
    
    return self;
}

-(void)initSubViews
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.bankTipLabel];
    [self addSubview:self.bankView];
    [self.bankView addSubview:self.seleTitleLabel];
    [self.bankView addSubview:self.arrowImageView];
    [self addSubview:self.textField];
    [self addSubview:self.tipLabel];
    [self addSubview:self.bommtLabel];
    
    UITapGestureRecognizer *backViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bankViewTapClick)];
    [self.bankView addGestureRecognizer:backViewTap];
}

- (void)initSubFrames
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(18.f);
    }];
    
    [self.bankTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(58.f);
    }];
    
    
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.top.mas_equalTo(self.bankTipLabel.mas_bottom).offset(4.f);
        make.height.mas_equalTo(40.f);
    }];
    
    [self.seleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(12.f);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-8.f);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankView.mas_bottom).offset(12.f);
        make.left.mas_equalTo(20.f);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(4.f);
        make.height.mas_equalTo(40.f);
        make.right.mas_equalTo(-20.f);
    }];
    [self.bommtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.textField.mas_leading);
        make.top.mas_equalTo(self.textField.mas_bottom).offset(20.f);
        make.trailing.mas_equalTo(self.textField.mas_trailing);
    }];
}

- (void)bankViewTapClick
{
    PUBBankSingleView *singleView = [[PUBBankSingleView alloc] initWithData:self.model.lysine_eg title:@"Bank card selection"];
    [singleView show];
    WEAKSELF
    singleView.confirmBlock = ^(id  _Nonnull object) {
       STRONGSELF
        strongSelf.selecModel = (PUBBankLysinEgModel*)object;
        strongSelf.seleTitleLabel.text = NotNull(strongSelf.selecModel.rhodo_eg);
        strongSelf.seleTitleLabel.font = FONT_Semibold(16.f);
        strongSelf.seleTitleLabel.textColor = [UIColor whiteColor];
        [PUBTrackHandleManager trackAppEventName:@"af_pub_result_bank" withElementParam:@{@"type":@(strongSelf.selecModel.quilting_eg)}];
    };
}

#pragma mark QMUITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //文本彻底结束编辑时调用
    self.bankText = textField.text;
    [PUBTrackHandleManager trackAppEventName:@"af_pub_result_card_account" withElementParam:@{@"tag":@"bank", @"content": NotNull(textField.text)}];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [PUBTrackHandleManager trackAppEventName:@"af_pub_click_card_account" withElementParam:@{@"type":@"bank"}];
}

#pragma mark - lazy
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(17.f) textColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"Select Bank";
    }
    return _titleLabel;
}


-(UILabel *)tipLabel{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(14.f) textColor:[UIColor whiteColor]];
        _tipLabel.textAlignment = NSTextAlignmentLeft;
        _tipLabel.text = @"Bank Account";
    }
    return _tipLabel;
}

-(UILabel *)bankTipLabel{
    if(!_bankTipLabel){
        _bankTipLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(14.f) textColor:[UIColor whiteColor]];
        _bankTipLabel.textAlignment = NSTextAlignmentLeft;
        _bankTipLabel.text = @"Bank";
    }
    return _bankTipLabel;
}


-(QMUITextField *)textField{
    if(!_textField){
        _textField = [[QMUITextField alloc] init];
        _textField.layer.cornerRadius = 12.f;
        _textField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.12f];
        _textField.textColor = [UIColor whiteColor];
        _textField.font = FONT_Semibold(16.f);
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.f, 40.f)];
        _textField.leftView = leftview;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"please enter your bank account number" attributes: @{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#6D7278"], NSFontAttributeName:FONT(12)}];
        _textField.attributedPlaceholder = attrString;
    }
    return _textField;
}

- (UILabel *)bommtLabel{
    if(!_bommtLabel){
        _bommtLabel = [[UILabel alloc] qmui_initWithFont:FONT(12.f) textColor:[UIColor qmui_colorWithHexString:@"#E56A56"]];
        _bommtLabel.textAlignment = NSTextAlignmentLeft;
        _bommtLabel.numberOfLines = 0;
        _bommtLabel.text = @"Please confirm the account belongs to yourself and is correct, it will be used as a receipt account to receive the funds";
    }
    return _bommtLabel;
}

-(UIView *)bankView{
    if(!_bankView){
        _bankView = [[UIView alloc] init];
        _bankView.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"] colorWithAlphaComponent:0.12f];
        _bankView.layer.cornerRadius = 12.f;
        _bankView.clipsToBounds = YES;
    }
    return _bankView;
}

- (UILabel *)seleTitleLabel{
    if(!_seleTitleLabel){
        _seleTitleLabel = [[UILabel alloc] qmui_initWithFont:FONT(12.f) textColor:[UIColor qmui_colorWithHexString:@"#6D7278"]];
        _seleTitleLabel.textAlignment = NSTextAlignmentLeft;
        _seleTitleLabel.text = @"Please select your bank";
    }
    return _seleTitleLabel;
}

- (UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_baisc_down_row"]];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImageView;
}

@end
