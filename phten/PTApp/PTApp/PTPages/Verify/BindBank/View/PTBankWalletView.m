//
//  PTBankWalletView.m
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import "PTBankWalletView.h"
#import "PTBankWalletCell.h"
#import "PTBankModel.h"
@interface PTBankWalletView()<UITableViewDelegate,UITableViewDataSource,QMUITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QMUILabel *textfieldTitleLabel;
@property (nonatomic, strong) QMUITextField *textfield;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *bottomTitle;
@property (nonatomic, strong) PTBankWalletModel *model;

@end
@implementation PTBankWalletView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return  self;
}
- (void)setupUI{
    [self addSubview:self.tableView];
    [self addSubview:self.textfieldTitleLabel];
    [self addSubview:self.textfield];
    [self addSubview:self.line];
    [self addSubview:self.bottomTitle];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(210);
    }];
    [self.textfieldTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(16);
        make.left.mas_equalTo(16);
    }];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textfieldTitleLabel.mas_bottom);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(40);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textfield.mas_bottom);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
    }];
    [self.bottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(13);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    
}
- (void)updateUIWithModel:(PTBankWalletModel *)model
{
    _model = model;
    if ([PTUserManager.sharedUser.username hasPrefix:@"0"]) {
        self.textfield.text = PTUserManager.sharedUser.username;
    }else {
        self.textfield.text = [NSString stringWithFormat:@"0%@", PTUserManager.sharedUser.username];
    }
    self.walletText =  self.textfield.text;
    if (![model.kotenNc.ovtenrcutNc br_isBlankString] && model.kotenNc.bltenthelyNc != 0) {
        self.textfield.text = model.kotenNc.ovtenrcutNc;
        WEAKSELF
        [model.untenrderlyNc enumerateObjectsUsingBlock:^(PTBankItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(obj.retengnNc == model.kotenNc.bltenthelyNc){
                strongSelf.selectModel = obj;
                *stop = YES;
            }
        }];
    }else{
        if (!self.selectModel) {
            if (model.untenrderlyNc.count> 0) {
                self.selectModel = model.untenrderlyNc[0];
            }
        }
    }
    [self.tableView reloadData];
}
#pragma mark - table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTBankWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTBankWalletCell.class)];
    PTBankItemModel *model = self.model.untenrderlyNc[indexPath.row];
    [cell updateUIWithModel:model isSelect:model == self.selectModel ? YES : NO];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.model.untenrderlyNc.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTBankItemModel *model = self.model.untenrderlyNc[indexPath.row];
    _selectModel = model;
//    [BagTrackHandleManager trackAppEventName:@"af_cc_result_wallet" withElementParam:@{@"type":@(model.franticF)}];

    [self.tableView reloadData];
}
#pragma mark - textfield
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //文本彻底结束编辑时调用
    self.walletText = textField.text;
//    [BagTrackHandleManager trackAppEventName:@"af_cc_result_card_item" withElementParam:@{@"tag":@"wallet", @"content": NotNull(textField.text)}];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [BagTrackHandleManager trackAppEventName:@"af_cc_click_card_item" withElementParam:@{@"tag":@"wallet"}];
}
#pragma mark
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [_tableView registerClass:[PTBankWalletCell class] forCellReuseIdentifier:NSStringFromClass(PTBankWalletCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (QMUILabel *)textfieldTitleLabel
{
    if (!_textfieldTitleLabel) {
        _textfieldTitleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
        _textfieldTitleLabel.text = @"E-wallet Account";
    }
    return _textfieldTitleLabel;
}
- (QMUITextField *)textfield
{
    if (!_textfield) {
        _textfield = [[QMUITextField alloc] init];
        _textfield.placeholder = @"Input";
        _textfield.placeholderColor = RGBA(100, 122, 64, 0.32);
        _textfield.keyboardType = UIKeyboardTypeNumberPad;
//        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.f, 40.f)];
//        _textfield.leftView = leftview;
        _textfield.leftViewMode = UITextFieldViewModeAlways;
        _textfield.font = [UIFont systemFontOfSize:12];
        _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textfield.textColor = [UIColor qmui_colorWithHexString:@"#000000"];
        _textfield.delegate = self;
    }
    return _textfield;
}
-(UILabel *)bottomTitle
{
    if (!_bottomTitle) {
        _bottomTitle = [[UILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:12] textColor:[UIColor qmui_colorWithHexString:@"#9CA7B4"]];
        _bottomTitle.numberOfLines = 0;
        _bottomTitle.text = @"Please confirm the account belongs to yourself and is correct,it will be used as a receipt account to receive the funds";
    }
    return _bottomTitle;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = PTUIColorFromHex(0xE6F0FD);
    }
    return _line;
}
@end
