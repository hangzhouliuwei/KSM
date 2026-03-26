//
//  PesoBankWalletView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import "PesoBankWalletView.h"
#import "PesoBankModel.h"
#import "PesoBankWalletCell.h"
@interface PesoBankWalletView()<UITableViewDelegate,UITableViewDataSource,QMUITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QMUILabel *textfieldTitleLabel;
@property (nonatomic, strong) QMUITextField *textfield;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *bottomTitle;
@property (nonatomic, strong) PesoBankWalletModel *model;
@end
@implementation PesoBankWalletView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, 210);
    [self addSubview:self.tableView];
    
    QMUILabel *accountL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x0B2C04)];
    accountL.frame = CGRectMake(14, self.tableView.bottom+20, 200, 17);
    accountL.text = @"E-wallet Account";
    accountL.numberOfLines = 0;
    [self addSubview:accountL];
    
    self.textfield.frame = CGRectMake(14, accountL.bottom+10, kScreenWidth-28, 44);
    [self addSubview:self.textfield];
    
    QMUILabel *descL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(12) textColor:ColorFromHex(0x616C5F)];
    descL.frame = CGRectMake(14, self.textfield.bottom+10, kScreenWidth-28, 51);
    descL.text = @"Please confirm the account belongs to yourself and is correct, it will be used as a receipt account to receive the funds";
    descL.numberOfLines = 0;
    [self addSubview:descL];
    
}
- (void)updateUIWithModel:(PesoBankWalletModel *)model
{
    _model = model;
    if ([PesoUserCenter.sharedPesoUserCenter.username hasPrefix:@"0"]) {
        self.textfield.text = PesoUserCenter.sharedPesoUserCenter.username;
    }else {
        self.textfield.text = [NSString stringWithFormat:@"0%@",PesoUserCenter.sharedPesoUserCenter.username];
    }
    self.walletText =  self.textfield.text;
    if (br_isNotEmptyObject(model.koNcthirteen.ovrcthirteenutNc) && model.koNcthirteen.blththirteenelyNc != 0) {
        self.textfield.text = model.koNcthirteen.ovrcthirteenutNc;
        WEAKSELF
        [model.unrdthirteenerlyNc enumerateObjectsUsingBlock:^(PesoBankItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(obj.regnthirteenNc == model.koNcthirteen.blththirteenelyNc){
                strongSelf.selectModel = obj;
                *stop = YES;
            }
        }];
    }else{
        if (!self.selectModel) {
            if (model.unrdthirteenerlyNc.count> 0) {
                self.selectModel = model.unrdthirteenerlyNc[0];
            }
        }
    }
    [self.tableView reloadData];
}
#pragma mark -table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PesoBankWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoBankWalletCell.class)];
    PesoBankItemModel *model = self.model.unrdthirteenerlyNc[indexPath.row];
    [cell updateUIWithModel:model isSelect:model == self.selectModel ? YES : NO];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.model.unrdthirteenerlyNc.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PesoBankItemModel *model = self.model.unrdthirteenerlyNc[indexPath.row];
    _selectModel = model;
    [self.tableView reloadData];
    
}
#pragma mark - textfield
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //文本彻底结束编辑时调用
    self.walletText = textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
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
        [_tableView registerClass:[PesoBankWalletCell class] forCellReuseIdentifier:NSStringFromClass(PesoBankWalletCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (QMUITextField *)textfield
{
    if (!_textfield) {
        _textfield = [[QMUITextField alloc] init];
        _textfield.placeholder = @"Input";
        _textfield.placeholderColor =ColorFromHex(0xA6B5A3);
        _textfield.keyboardType = UIKeyboardTypeNumberPad;
        _textfield.leftViewMode = UITextFieldViewModeAlways;
        _textfield.font = [UIFont systemFontOfSize:14];
        _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textfield.textColor = [UIColor qmui_colorWithHexString:@"#000000"];
        _textfield.delegate = self;
        _textfield.backgroundColor = ColorFromHex(0xFBFBFB);
    }
    return _textfield;
}
@end
