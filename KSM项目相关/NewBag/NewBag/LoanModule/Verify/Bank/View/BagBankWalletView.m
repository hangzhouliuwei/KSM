//
//  BagBankWalletView.m
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagBankWalletView.h"
#import "BagBankWalletCell.h"
#import "BagBankModel.h"
@interface BagBankWalletView ()<UITableViewDelegate,UITableViewDataSource,QMUITextFieldDelegate>
@property (nonatomic, strong) UILabel *topTitle;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BagBankWalletModel *model;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) QMUITextField *textfield;
@property (nonatomic, strong) UILabel *textfieldTitleLabel;
@property (nonatomic, strong) UILabel *bottomTitle;
@end
@implementation BagBankWalletView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topTitle];
        [self addSubview:self.tableView];
        [self addSubview:self.line];
        [self addSubview:self.textfieldTitleLabel];
        [self addSubview:self.textfield];
        [self addSubview:self.bottomTitle];
        [self.topTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12);
            make.left.mas_equalTo(14);
        }];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topTitle.mas_bottom).offset(8);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(182.f);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tableView.mas_bottom);
            make.left.mas_equalTo(14);
            make.right.mas_equalTo(-14);
            make.height.mas_equalTo(.5f);
        }];
        [self.textfieldTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.line.mas_bottom).offset(15);
            make.left.mas_equalTo(14);
        }];
        [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.textfieldTitleLabel.mas_bottom).offset(6);
            make.left.mas_equalTo(14);
            make.right.mas_equalTo(-14);
            make.height.mas_equalTo(48.f);
        }];
        [self.bottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.textfield.mas_bottom).offset(8);
            make.left.mas_equalTo(14);
            make.right.mas_equalTo(-14);

        }];
    }
    return self;
}
- (void)updateUIWithModel:(BagBankWalletModel *)model
{
    _model = model;
    if ([BagUserManager.shareInstance.username hasPrefix:@"0"]) {
        self.textfield.text = BagUserManager.shareInstance.username;
    }else {
        self.textfield.text = [NSString stringWithFormat:@"0%@", BagUserManager.shareInstance.username];
    }
    self.walletText =  self.textfield.text;
    if (![model.koNcfourteen.ovrcfourteenutNc br_isBlankString] && model.koNcfourteen.blthfourteenelyNc != 0) {
        self.textfield.text = model.koNcfourteen.ovrcfourteenutNc;
        WEAKSELF
        [model.unrdfourteenerlyNc enumerateObjectsUsingBlock:^(BagBankItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(obj.regnfourteenNc == model.koNcfourteen.blthfourteenelyNc){
                strongSelf.selectModel = obj;
                *stop = YES;
            }
        }];
    }
    [self.tableView reloadData];
}
#pragma mark - table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BagBankWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagBankWalletCell.class)];
    BagBankItemModel *model = self.model.unrdfourteenerlyNc[indexPath.row];
    [cell updateUIWithModel:model isSelect:model == self.selectModel ? YES : NO];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.model.unrdfourteenerlyNc.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BagBankItemModel *model = self.model.unrdfourteenerlyNc[indexPath.row];
    _selectModel = model;
    [BagTrackHandleManager trackAppEventName:@"af_cc_result_wallet" withElementParam:@{@"type":@(model.regnfourteenNc)}];

    [self.tableView reloadData];
}
#pragma mark - textfield
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //文本彻底结束编辑时调用
    self.walletText = textField.text;
    [BagTrackHandleManager trackAppEventName:@"af_cc_result_card_item" withElementParam:@{@"tag":@"wallet", @"content": NotNull(textField.text)}];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [BagTrackHandleManager trackAppEventName:@"af_cc_click_card_item" withElementParam:@{@"tag":@"wallet"}];
}
#pragma mark -
-(UILabel *)topTitle
{
    if (!_topTitle) {
        _topTitle = [[UILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor qmui_colorWithHexString:@"#333333"]];
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"Select your recipient E-wallet";
    }
    return _topTitle;
}
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
//        [_tableView registerClass:[BagBankWalletCell class] forCellReuseIdentifier:NSStringFromClass(BagBankWalletCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagBankWalletCell.class)] forCellReuseIdentifier:NSStringFromClass(BagBankWalletCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor qmui_colorWithHexString:@"#C7D0D9"];
    }
    return _line;
}
-(UILabel *)textfieldTitleLabel
{
    if (!_textfieldTitleLabel) {
        _textfieldTitleLabel = [[UILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor qmui_colorWithHexString:@"#212121"]];
        _textfieldTitleLabel.numberOfLines = 0;
        _textfieldTitleLabel.text = @"E-wallet Account";
    }
    return _textfieldTitleLabel;
}
- (QMUITextField *)textfield
{
    if (!_textfield) {
        _textfield = [[QMUITextField alloc] init];
        _textfield.placeholder = @"Please enter your E-wallet account";
        _textfield.placeholderColor = [UIColor qmui_colorWithHexString:@"#949DA6"];
        _textfield.qmui_borderWidth = 1;
        _textfield.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#949DA6"];
        _textfield.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight | QMUIViewBorderPositionBottom;
        _textfield.layer.cornerRadius = 4;
        _textfield.layer.masksToBounds = YES;
        _textfield.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.f, 40.f)];
        _textfield.leftView = leftview;
        _textfield.leftViewMode = UITextFieldViewModeAlways;
        _textfield.font = [UIFont boldSystemFontOfSize:15];
        _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textfield.textColor = [UIColor qmui_colorWithHexString:@"#333333"];
        _textfield.delegate = self;
    }
    return _textfield;
}
-(UILabel *)bottomTitle
{
    if (!_bottomTitle) {
        _bottomTitle = [[UILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:11] textColor:[UIColor qmui_colorWithHexString:@"#949DA6"]];
        _bottomTitle.numberOfLines = 0;
        _bottomTitle.text = @"Please confirm the account belongs to yourself and be correct, it will be used as a receipt account to receice the funds.";
    }
    return _bottomTitle;
}
@end
