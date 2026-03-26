//
//  PesoBankBankView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import "PesoBankBankView.h"
#import "PesoBankModel.h"
#import "PesoEnumPicker.h"
@interface PesoBankBankView()<QMUITextFieldDelegate>
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) QMUILabel *valueL;
@property (nonatomic, strong) QMUILabel *accountL;
@property (nonatomic, strong) QMUITextField *textfield;
@property (nonatomic, strong) PesoBankBankModel *model;

@end
@implementation PesoBankBankView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(14, 13, kScreenWidth - 28, 17);
    titleL.numberOfLines = 1;
    [self addSubview:titleL];
    titleL.text = @"Bank";
    _titleL = titleL;
    
    UIView *valueBg = [[UIView alloc] initWithFrame:CGRectMake(14, titleL.bottom+10, kScreenWidth-28, 44)];
    valueBg.backgroundColor = ColorFromHex(0xFBFBFB);
    valueBg.layer.cornerRadius = 4;
    valueBg.layer.masksToBounds = YES;
    [self addSubview:valueBg];
    
    
    QMUILabel *valueL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0xA6B5A3)];
    valueL.frame = CGRectMake(12, 0, valueBg.width - 12 - 34, 17);
    valueL.numberOfLines = 1;
    valueL.centerY = 22;
    [valueBg addSubview:valueL];
    valueL.text =  @"Please Select";
    _valueL = valueL;
    
    UIImageView *arrow  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"basic_arrow_down"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    arrow.frame = CGRectMake(valueBg.width - 12 - 22, 0, 22, 22);
    arrow.centerY = 22;
    arrow.userInteractionEnabled = YES;
//    _arrow = arrow;
    [valueBg addSubview:arrow];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [valueBg addGestureRecognizer:tap];
    
    QMUILabel *accountL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x0B2C04)];
    accountL.frame = CGRectMake(14, valueBg.bottom+10, kScreenWidth - 28, 17);
    accountL.numberOfLines = 1;
    [self addSubview:accountL];
    accountL.text = @"Bank Account";
    _accountL = accountL;
    
    UIView *accountBg = [[UIView alloc] initWithFrame:CGRectMake(14, accountL.bottom+10, kScreenWidth-28, 44)];
    accountBg.backgroundColor = ColorFromHex(0xFBFBFB);
    accountBg.layer.cornerRadius = 4;
    accountBg.layer.masksToBounds = YES;
    [self addSubview:accountBg];
    
    _textfield = [[QMUITextField alloc] init];
    _textfield.frame = CGRectMake(12, 0, kScreenWidth-12, 44);
    _textfield.placeholder = @"Input";
    _textfield.placeholderColor = RGBA(100, 122, 64, 0.32);
    _textfield.leftViewMode = UITextFieldViewModeAlways;
    _textfield.font = [UIFont systemFontOfSize:12];
    _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textfield.textColor = [UIColor qmui_colorWithHexString:@"#000000"];
    _textfield.delegate = self;
    [accountBg addSubview:_textfield];
}
- (void)updateUIWithModel:(PesoBankBankModel *)model
{
    _model = model;
    if (br_isNotEmptyObject(model.koNcthirteen.ovrcthirteenutNc) && model.koNcthirteen.blththirteenelyNc != 0) {
        self.textfield.text = model.koNcthirteen.ovrcthirteenutNc;
        self.bankText = model.koNcthirteen.ovrcthirteenutNc;
        WEAKSELF
        [model.unrdthirteenerlyNc enumerateObjectsUsingBlock:^(PesoBankItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(obj.regnthirteenNc == model.koNcthirteen.blththirteenelyNc){
                strongSelf.selectModel = obj;
                strongSelf.valueL.text = NotNil(obj.uporthirteennNc);
                strongSelf.valueL.textColor = ColorFromHex(0x0B2C04);
                *stop = YES;
            }
        }];
    }
}
- (void)click{
    PesoEnumPicker *picker = [[PesoEnumPicker alloc] initWithTitleArray:self.model.unrdthirteenerlyNc headerTitle:@"Bank card selectio"];
    picker.clickBlock = ^(id  _Nonnull model) {
        self.selectModel = model;
        self.valueL.text = self.selectModel.uporthirteennNc;
        self.valueL.textColor = ColorFromHex(0x0B2C04);
    };
    [picker showWithAnimation];
}
#pragma mark - textfield
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //文本彻底结束编辑时调用
    self.bankText = textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
@end
