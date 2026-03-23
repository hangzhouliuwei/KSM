//
//  PTVerifyTextInputCell.m
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTVerifyTextInputCell.h"
#import "PTBasicVerifyModel.h"
#import "PTVerifyEmailAlertView.h"
@interface PTVerifyTextInputCell()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) PTBasicRowModel *model;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat celly;
@property (nonatomic,strong) NSArray * emailDataArray;
@property (nonatomic,strong) PTVerifyEmailAlertView * emailAlert;


@end
@implementation PTVerifyTextInputCell

- (void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.tableView = nil;
    self.emailDataArray = @[@"gmail.com",
                            @"icloud.com",
                            @"yahoo.com",
                            @"outlook.com",];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textfield];
    [self.contentView addSubview:self.line];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(16);
    }];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-30);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}
- (void)configUI:(PTBasicRowModel *)model index:(NSIndexPath *)index tableView:(UITableView *)tableView Y:(CGFloat)y{
    _model = model;
    _tableView = tableView;
    _celly = y;
    self.titleLabel.text = model.fltendgeNc;
    if(![PTNotNull(model.datenrymanNc) br_isBlankString]){
        self.textfield.text = model.datenrymanNc;
    }else{
        self.textfield.text = @"";
    }
    NSString *placeholder = [model.imteneasurabilityNc isEqual:@"email"] ? @"Example :*****@***.com" : PTNotNull(model.imteneasurabilityNc);
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:placeholder attributes: @{NSForegroundColorAttributeName:RGBA(100, 122, 64, 0.32), NSFontAttributeName:[UIFont systemFontOfSize:12]} ];
    self.textfield.attributedPlaceholder = attrString;
    self.textfield.keyboardType = model.tetenchedNc.integerValue == 1 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
}
- (void)textChange:(UITextField *)tf{
    if (![self.model.imteneasurabilityNc isEqual:@"email"]) {
        return;
    }
    NSArray * arr = [tf.text componentsSeparatedByString:@"@"];
    NSString *conStr = arr[0];
    NSString * typeStr = arr.count > 1 ? arr[1] : @"";
    
    NSMutableArray * currentArr = [NSMutableArray array];
    
    if (![tf.text br_isBlankString]){
        NSMutableArray * cArr = [NSMutableArray array];
        for (NSString * item in self.emailDataArray) {
            [cArr addObject:[NSString stringWithFormat:@"%@@%@",conStr,item]];
        }
        //弹窗位置
        CGRect rectInScreen = [self.tableView convertRect:self.frame toView:self.tableView];
        self.emailAlert.topMargin = rectInScreen.origin.y + 56.f + 8;
        self.emailAlert.hidden = NO;
        self.emailAlert.dataArray = cArr;
        __block BOOL isShowemailAlert = NO;
        [self.tableView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj == self.emailAlert){
                isShowemailAlert = YES;
                *stop = YES;
            }
        }];
        if(!isShowemailAlert){
            [self.emailAlert showView:self.tableView];
        }
    }
    
    if (typeStr.length > 0){
        for (NSString * item in self.emailDataArray) {
            if ([item hasPrefix:typeStr]){
                [currentArr addObject:[NSString stringWithFormat:@"%@@%@",conStr,item]];
            }
        }
        self.emailAlert.dataArray = currentArr;
    }
    
    if ([tf.text br_isBlankString]){
        [self.emailAlert dismiss];
    }
}
#pragma mark - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //文本彻底结束编辑时调用
    if(self.textBlock){
        self.textBlock(textField.text);
    }
    
    if(_emailAlert){
        [self.emailAlert dismiss];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.textBeginBlock){
        self.textBeginBlock();
    }
}
#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
    }
    return _titleLabel;
}
- (UITextField *)textfield
{
    if (!_textfield) {
        _textfield = [[UITextField alloc] initWithFrame:CGRectZero];
        _textfield.font = PT_Font(14);
        _textfield.textColor = PTUIColorFromHex(0x000000);
        _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        _textfield.delegate = self;
    }
    return _textfield;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = PTUIColorFromHex(0xE6F0FD);
    }
    return _line;
}
- (PTVerifyEmailAlertView *)emailAlert
{
    if (!_emailAlert)
    {
        _emailAlert = [[PTVerifyEmailAlertView alloc]initWithFrame:CGRectMake(16, 0, kScreenWidth-64, kScreenHeight)];
        WEAKSELF
        _emailAlert.selectBlock = ^(NSString * _Nonnull title) {
                weakSelf.textfield.text = [NSString stringWithFormat:@"%@",title];
                [weakSelf.textfield resignFirstResponder];
            [weakSelf.emailAlert dismiss];
//            weakSelf.emailAlert = nil;
        };
        
        _emailAlert.cancelBlock = ^{
            if ([weakSelf.textfield.text hasSuffix:@"@"]){
                weakSelf.textfield.text = [weakSelf.textfield.text substringToIndex:weakSelf.textfield.text.length - 1];
            }
            [weakSelf.textfield resignFirstResponder];
            [weakSelf.emailAlert dismiss];
//            weakSelf.emailAlert = nil;
        };
    }
    return _emailAlert;
}
@end
