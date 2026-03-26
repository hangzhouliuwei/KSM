//
//  PesoBasicInputCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBasicInputCell.h"
#import "PesoBasicModel.h"
#import "PesoVerifyEmailView.h"
@interface PesoBasicInputCell()<UITextFieldDelegate>
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) QMUILabel *valueL;
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) PesoBasicRowModel *model;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat celly;
@property (nonatomic,strong) NSArray * emailDataArray;
@property (nonatomic,strong) PesoVerifyEmailView * emailAlert;

@end
@implementation PesoBasicInputCell

- (void)createUI
{
    [super createUI];
//    self.contentView.backgroundColor = [UIColor redColor];
    self.emailDataArray = @[@"gmail.com",
                            @"icloud.com",
                            @"yahoo.com",
                            @"outlook.com",];
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(14, 13, kScreenWidth - 28, 17);
    titleL.numberOfLines = 1;
    [self.contentView addSubview:titleL];
    _titleL = titleL;
    
    UIView *valueBg = [[UIView alloc] initWithFrame:CGRectMake(14, titleL.bottom+10, kScreenWidth-28, 44)];
    valueBg.backgroundColor = ColorFromHex(0xFBFBFB);
    valueBg.layer.cornerRadius = 4;
    valueBg.layer.masksToBounds = YES;
    [self.contentView addSubview:valueBg];
    
    _textfield = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, valueBg.width-5, 44)];
    _textfield.font = PH_Font(14);
    _textfield.textColor = ColorFromHex(0x000000);
    _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    _textfield.delegate = self;
    [valueBg addSubview:_textfield];
}
- (void)textChange:(UITextField *)tf {
    if (![self.model.imeathirteensurabilityNc isEqual:@"email"]) {
        return;
    }
    NSArray * arr = [tf.text componentsSeparatedByString:@"@"];
    NSString *conStr = arr[0];
    NSString * typeStr = arr.count > 1 ? arr[1] : @"";
    
    NSMutableArray * currentArr = [NSMutableArray array];
    
    if (!br_isEmptyObject(tf.text)){
        NSMutableArray * cArr = [NSMutableArray array];
        for (NSString * item in self.emailDataArray) {
            [cArr addObject:[NSString stringWithFormat:@"%@@%@",conStr,item]];
        }
        //弹窗位置
        CGRect rectInScreen = [self.tableView convertRect:self.frame toView:self.tableView];
        self.emailAlert.topMargin = rectInScreen.origin.y + 84 + 8;
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
    
    if (br_isEmptyObject(tf.text)){
        [self.emailAlert dismiss];
    }
}
- (void)configUI:(PesoBasicRowModel *)model index:(NSIndexPath *)index tableView:(UITableView *)tableView Y:(CGFloat)y
{
    _model = model;
    _tableView = tableView;
    _celly = y;
    self.titleL.text = model.fldgthirteeneNc;
    if(!br_isEmptyObject(model.darythirteenmanNc)){
        self.textfield.text = model.darythirteenmanNc;
    }else{
        self.textfield.text = @"";
    }
    NSString *placeholder = [model.imeathirteensurabilityNc isEqual:@"email"] ? @"Example :*****@***.com" : NotNil(model.imeathirteensurabilityNc);
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:placeholder attributes: @{NSForegroundColorAttributeName:ColorFromHex(0xA6B5A3), NSFontAttributeName:[UIFont systemFontOfSize:14]} ];
    self.textfield.attributedPlaceholder = attrString;
    self.textfield.keyboardType = model.techthirteenedNc.integerValue == 1 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
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
- (PesoVerifyEmailView *)emailAlert
{
    if (!_emailAlert)
    {
        _emailAlert = [[PesoVerifyEmailView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, kScreenHeight*2)];
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
