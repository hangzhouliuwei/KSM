//
//  BagIdentifyTxtCell.m
//  NewBag
//
//  Created by Jacky on 2024/4/10.
//

#import "BagIdentifyTxtCell.h"
#import "BagVerifyBasicModel.h"
#import "BagEmailAlertView.h"
@interface BagIdentifyTxtCell()<QMUITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet QMUITextField *inputTextfield;
@property (nonatomic,strong) BagEmailAlertView * emailAlert;
@property(nonatomic, strong) NSIndexPath *index;
@property(nonatomic, assign) CGFloat topY;
@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray * emailDataArray;
@end
@implementation BagIdentifyTxtCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
        self.tableView = nil;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.inputTextfield.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight;
    [self.inputTextfield br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(2, 2) viewRect:CGRectMake(0, 0, kScreenWidth - 28, 48)];
    self.inputTextfield.leftView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.f, 48.f)];
    self.inputTextfield.leftViewMode = UITextFieldViewModeAlways;

    self.inputTextfield.delegate = self;
    [self.inputTextfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    self.emailDataArray = @[@"gmail.com",
                            @"icloud.com",
                            @"yahoo.com",
                            @"outlook.com",];
    // Initialization code
}

- (void)updateUIWithModel:(BagBasicRowModel *)model
{
    _title.text = model.mudslingerF;
    if(![model.lorrieF br_isBlankString]){
        self.inputTextfield.text = NotNull(model.lorrieF);
    }else{
        self.inputTextfield.text = @"";
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:NotNull(model.taxidermyF) attributes: @{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:12]} ];
    self.inputTextfield.attributedPlaceholder = attrString;
    self.inputTextfield.keyboardType = model.sothisF.integerValue == 1 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
    if (![model.taxidermyF isEqualToString:@"email"]) {
        self.tableView = nil;
    }
}
- (void)updateUIWithModel:(BagBasicRowModel *)model index:(NSIndexPath *)index tableView:(UITableView *)tableView topY:(CGFloat)topY
{
    _title.text = model.mudslingerF;
    if(![model.lorrieF br_isBlankString]){
        self.inputTextfield.text = NotNull(model.lorrieF);
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:NotNull(model.taxidermyF) attributes: @{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:12]} ];
    self.inputTextfield.attributedPlaceholder = attrString;
    self.inputTextfield.keyboardType = model.sothisF.integerValue == 1 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
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
- (BagEmailAlertView *)emailAlert
{
    if (!_emailAlert)
    {
        _emailAlert = [[BagEmailAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) weakSelf = self;
        _emailAlert.selectBlock = ^(NSString * _Nonnull title) {
                weakSelf.inputTextfield.text = [NSString stringWithFormat:@"%@",title];
                [weakSelf.inputTextfield resignFirstResponder];
        };
        
        _emailAlert.cancelBlock = ^{
            if ([weakSelf.inputTextfield.text hasSuffix:@"@"]){
                weakSelf.inputTextfield.text = [weakSelf.inputTextfield.text substringToIndex:weakSelf.inputTextfield.text.length - 1];
            }
            [weakSelf.inputTextfield resignFirstResponder];
            [weakSelf.emailAlert dismiss];
        };
    }
    return _emailAlert;
}
@end

