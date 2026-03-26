//
//  PUBWalletView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import "PUBWalletView.h"
#import "PUBBankWalletCell.h"
#import "PUBBankModel.h"

@interface PUBWalletView()<QMUITableViewDelegate,QMUITableViewDataSource,QMUITextFieldDelegate>
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) QMUITableView *walletTableView;
@property(nonatomic, strong) UILabel *tipLabel;
@property(nonatomic, strong) UILabel *bommtLabel;
@property(nonatomic, strong) QMUITextField *textField;
@property(nonatomic, strong) PUBBankValuedEgModel *model;
@end

@implementation PUBWalletView

- (void)updataModel:(PUBBankValuedEgModel*)model
{
    self.model = model;
    if ([User.username hasPrefix:@"0"]) {
        self.textField.text = User.username;
    }else {
        self.textField.text = [NSString stringWithFormat:@"0%@", User.username];
    }
    self.walletText =  self.textField.text;
    
    if(![PUBTools isBlankString:model.megrim_eg.rbds_eg] && model.megrim_eg.jeanne_eg != 0){
        self.textField.text = model.megrim_eg.rbds_eg;
        self.walletText =  self.textField.text;
        WEAKSELF
        [model.lysine_eg enumerateObjectsUsingBlock:^(PUBBankLysinEgModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(obj.quilting_eg == model.megrim_eg.jeanne_eg){
                strongSelf.selecModel = obj;
                *stop = YES;
            }
        }];
    }
    [self.walletTableView reloadData];
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
    [self addSubview:self.walletTableView];
    [self addSubview:self.textField];
    [self addSubview:self.tipLabel];
    [self addSubview:self.bommtLabel];
}

- (void)initSubFrames
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(18.f);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.walletTableView.mas_bottom).offset(32.f);
        make.left.mas_equalTo(26.f);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(27.f);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(4.f);
        make.height.mas_equalTo(40.f);
        make.right.mas_equalTo(-13.f);
    }];
    [self.bommtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.textField.mas_leading);
        make.top.mas_equalTo(self.textField.mas_bottom).offset(20.f);
        make.trailing.mas_equalTo(self.textField.mas_trailing);
    }];
}

#pragma mark QMUITableViewDelegate,QMUITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.lysine_eg.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"walletCellId";
    
    QMUITableViewCell *baseCell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    if(indexPath.row > self.model.lysine_eg.count){
        return baseCell;
    }
   static NSString *cellID = @"PUBBankWalletCellID";
   PUBBankWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[PUBBankWalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell configModel:[self.model.lysine_eg objectAtIndex:indexPath.row] selectModel:self.selecModel];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 68.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PUBBankLysinEgModel *mode = [self.model.lysine_eg objectAtIndex:indexPath.row];
    self.selecModel = mode;
    [PUBTrackHandleManager trackAppEventName:@"af_pub_result_wallet" withElementParam:@{@"type":@(mode.quilting_eg)}];
    [tableView reloadData];
}

#pragma mark QMUITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //文本彻底结束编辑时调用
    self.walletText = textField.text;
    [PUBTrackHandleManager trackAppEventName:@"af_pub_result_card_account" withElementParam:@{@"tag":@"wallet", @"content": NotNull(textField.text)}];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [PUBTrackHandleManager trackAppEventName:@"af_pub_click_card_account" withElementParam:@{@"type":@"wallet"}];
}

#pragma mark - lazy
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(17.f) textColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"Select E-Wallet";
    }
    return _titleLabel;
}

-(QMUITableView *)walletTableView{
    if(!_walletTableView){
        _walletTableView = [[QMUITableView alloc] initWithFrame:CGRectMake(20.f, 58.f, KSCREEN_WIDTH - 40.f, 208.f) style:UITableViewStylePlain];
        _walletTableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#444959"];
        _walletTableView.layer.cornerRadius = 20.f;
        _walletTableView.clipsToBounds = YES;
        _walletTableView.delegate = self;
        _walletTableView.dataSource = self;
        _walletTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _walletTableView;
}

-(UILabel *)tipLabel{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(14.f) textColor:[UIColor whiteColor]];
        _tipLabel.textAlignment = NSTextAlignmentLeft;
        _tipLabel.text = @"E-wallet Account";
    }
    return _tipLabel;
}

-(QMUITextField *)textField{
    if(!_textField){
        _textField = [[QMUITextField alloc] init];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"E-wallet Account" attributes: @{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#6D7278"], NSFontAttributeName:FONT(12)}];
        _textField.attributedPlaceholder = attrString;
        _textField.layer.cornerRadius = 12.f;
        _textField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.12f];
        _textField.textColor = [UIColor whiteColor];
        _textField.font = FONT_Semibold(16.f);
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.f, 40.f)];
        _textField.leftView = leftview;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
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

@end
