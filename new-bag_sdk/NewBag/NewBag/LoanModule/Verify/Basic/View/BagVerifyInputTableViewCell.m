//
//  BagVerifyInputTableViewCell.m
//  NewBag
//
//  Created by Jacky on 2024/4/7.
//

#import "BagVerifyInputTableViewCell.h"
#import "BagVerifyBasicModel.h"
#import "BagEmailAlertView.h"
@interface BagVerifyInputTableViewCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,strong) BagEmailAlertView * emailAlert;
@property(nonatomic, strong) NSIndexPath *index;
@property(nonatomic, assign) CGFloat topY;
@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray * emailDataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldLeftConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldCenterYConst;
@property (nonatomic, strong) BagBasicRowModel *model;
@property (nonatomic, assign) bool isSet;
@end
@implementation BagVerifyInputTableViewCell
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    self.emailDataArray = @[@"gmail.com",
                            @"icloud.com",
                            @"yahoo.com",
                            @"outlook.com",];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTap)];
    [self.contentView addGestureRecognizer:tap];
}
- (void)bgTap{
    if (!self.isSet) {
        [self setCellStyle];
    }
    self.isSet = YES;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
        self.tableView = nil;
    }
    return self;
}
- (void)updateUIWithModel:(BagBasicRowModel *)model
{
    _model = model;
    _titleLabel.text = model.mudslingerF;
  
    if(![model.lorrieF br_isBlankString]){
        if (!self.isSet) {
            [self setCellStyle];
        }
        self.isSet = YES;
        self.textField.text = NotNull(model.lorrieF);
    }else{
        CGFloat width = [model.mudslingerF br_getTextWidth:[UIFont systemFontOfSize:14] height:48];
        if (!self.isSet) {
            self.textFieldLeftConst.constant = 14+width + 5;
        }
        self.textField.text = @"";
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:NotNull(model.taxidermyF) attributes: @{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:12]} ];
    self.textField.attributedPlaceholder = attrString;
    self.textField.keyboardType = model.sothisF.integerValue == 1 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
    if (![model.taxidermyF isEqualToString:@"email"]) {
        self.tableView = nil;
    }
}
- (void)updateUIWithModel:(BagBasicRowModel *)model index:(NSIndexPath *)index tableView:(UITableView *)tableView topY:(CGFloat)topY
{
    _model = model;
    _titleLabel.text = model.mudslingerF;
    if(![model.lorrieF br_isBlankString]){
        if (!self.isSet) {
            [self setCellStyle];
        }
        self.isSet = YES;
        self.textField.text = NotNull(model.lorrieF);
    }else{
        CGFloat width = [model.mudslingerF br_getTextWidth:[UIFont systemFontOfSize:14] height:48];
        if (!self.isSet) {
            self.textFieldLeftConst.constant = 14+width + 5;
        }
        self.textField.text = @"";
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:NotNull(@"Example :*****@***.com") attributes: @{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:12]} ];
    self.textField.attributedPlaceholder = attrString;
    self.textField.keyboardType = model.sothisF.integerValue == 1 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
    self.tableView = tableView;
    self.index = index;
    self.topY = topY;
}
- (void)textChange:(UITextField *)tf
{
    if(!self.tableView)return;
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
- (void)setCellStyle{
    self.titleTopConst.priority = 960;
    self.textFieldLeftConst.constant = 14;
    self.textFieldCenterYConst.constant = 20;
    [UIView animateWithDuration:0.25 animations:^{
            // 要用约束组件的父组件调用
            [self.contentView layoutIfNeeded];
        }];
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.textColor = [UIColor qmui_colorWithHexString:@"#999999"];
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
    if (!self.isSet) {
        [self setCellStyle];
    }
    self.isSet = YES;
}
#pragma mark - getter
- (BagEmailAlertView *)emailAlert
{
    if (!_emailAlert)
    {
        _emailAlert = [[BagEmailAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) weakSelf = self;
        _emailAlert.selectBlock = ^(NSString * _Nonnull title) {
                weakSelf.textField.text = [NSString stringWithFormat:@"%@",title];
                [weakSelf.textField resignFirstResponder];
        };
        
        _emailAlert.cancelBlock = ^{
            if ([weakSelf.textField.text hasSuffix:@"@"]){
                weakSelf.textField.text = [weakSelf.textField.text substringToIndex:weakSelf.textField.text.length - 1];
            }
            [weakSelf.textField resignFirstResponder];
            [weakSelf.emailAlert dismiss];
        };
    }
    return _emailAlert;
}
@end
