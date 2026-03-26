//
//  PUBBasicTxtCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/3.
//

#import "PUBBasicTxtCell.h"
#import "PUBBasicModel.h"
#import "PUBEmailAlertView.h"

@interface PUBBasicTxtCell()<UITextFieldDelegate>
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) NSIndexPath *index;
@property(nonatomic, assign) CGFloat topY;
@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray * emailDataArray;
@property (nonatomic,strong) PUBEmailAlertView * emailAlert;
@end

@implementation PUBBasicTxtCell

-(void)configModel:(PUBBasicSomesuchEgModel*)model
{
    self.titleLabel.text = NotNull(model.neanderthaloid_eg);
    if(![PUBTools isBlankString:model.oerlikon_eg]){
        self.textField.text = NotNull(model.oerlikon_eg);
    }
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:NotNull(model.paramorphism_eg) attributes: @{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:FONT(12)} ];
    self.textField.attributedPlaceholder = attrString;
    self.textField.keyboardType = model.lumisome_eg.integerValue == 1 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
}

/// 添加邮箱输入提示
- (void)configModel:(PUBBasicSomesuchEgModel *)model index:(NSIndexPath*)index tableView:(UITableView*)tableView topY:(CGFloat)topY;
{
    self.titleLabel.text = NotNull(model.neanderthaloid_eg);
    if(![PUBTools isBlankString:model.oerlikon_eg]){
        self.textField.text = NotNull(model.oerlikon_eg);
    }
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:NotNull(model.paramorphism_eg) attributes: @{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:FONT(12)} ];
    self.textField.attributedPlaceholder = attrString;
    self.textField.keyboardType = model.lumisome_eg.integerValue == 1 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
    self.tableView = tableView;
    self.index = index;
    self.topY = topY;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        self.emailDataArray = @[@"gmail.com",
                                @"icloud.com",
                                @"yahoo.com",
                                @"outlook.com",];
        [self initSubViews];
        [self initSubFrams];
    }
    return self;
}

- (void)initSubViews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    [self.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)initSubFrams
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(14.f);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabel.mas_leading);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(2.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(40.f);
    }];
}

- (void)textChange:(UITextField *)tf
{
    if(!self.tableView)return;
    NSArray * arr = [tf.text componentsSeparatedByString:@"@"];
    NSString *conStr = arr[0];
    NSString * typeStr = arr.count > 1 ? arr[1] : @"";
    
    NSMutableArray * currentArr = [NSMutableArray array];
    
    if (![PUBTools isBlankString:tf.text]){
        NSMutableArray * cArr = [NSMutableArray array];
        for (NSString * item in self.emailDataArray) {
            [cArr addObject:[NSString stringWithFormat:@"%@@%@",conStr,item]];
        }
        //弹窗位置
        CGRect rectInScreen = [self.tableView convertRect:self.frame toView:self.tableView];
        self.emailAlert.topMargin = rectInScreen.origin.y + 56.f;
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
    
    if ([PUBTools isBlankString:tf.text]){
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

#pragma mark - lazy

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] qmui_initWithFont:FONT(12.f) textColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UITextField *)textField{
    if(!_textField){
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"] colorWithAlphaComponent:0.12f];
        _textField.layer.cornerRadius = 12.f;
        _textField.clipsToBounds = YES;
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.f, 40.f)];
        _textField.leftView = leftview;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.textColor = [UIColor whiteColor];
        _textField.font = FONT_Semibold(16.f);
        _textField.delegate = self;
    }
    return _textField;
}

- (PUBEmailAlertView *)emailAlert
{
    if (!_emailAlert)
    {
        _emailAlert = [[PUBEmailAlertView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
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
