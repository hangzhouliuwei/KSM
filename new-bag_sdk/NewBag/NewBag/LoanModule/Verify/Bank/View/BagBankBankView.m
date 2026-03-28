//
//  BagBankBankView.m
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagBankBankView.h"
#import "BagBankModel.h"
#import "BagVerifyPickerView.h"
@interface BagBankBankView ()<QMUITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bankBgView;
@property (weak, nonatomic) IBOutlet QMUITextField *bankAccountTextfield;
@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (nonatomic, strong) BagBankBankModel *model;
@property (weak, nonatomic) IBOutlet UILabel *bankTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@end
@implementation BagBankBankView
+ (instancetype)createView{
    BagBankBankView *bank = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    return bank;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.arrowBtn sd_setImageWithURL:[Util loadImageUrl:@"basic_choose_down"] forState:UIControlStateNormal];
    self.bankBgView.qmui_borderWidth = self.inputBgView.qmui_borderWidth = 1;
    self.bankBgView.qmui_borderColor = self.inputBgView.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#949DA6"];
    self.bankBgView.qmui_borderPosition = self.inputBgView.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight;
    self.bankAccountTextfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 48)];
    self.bankAccountTextfield.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"Please enter your bank account number" attributes: @{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#949DA6"], NSFontAttributeName:[UIFont systemFontOfSize:15]} ];
    self.bankAccountTextfield.attributedPlaceholder= attrString;
    self.bankAccountTextfield.delegate= self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bankListClick)];
    [self.bankBgView addGestureRecognizer:tap];

}
- (void)updateUIWithModel:(BagBankBankModel *)model
{
    self.model = model;
    if (![model.incessantF.fetoproteinF br_isBlankString] && model.incessantF.autoinfectionF != 0) {
        self.bankAccountTextfield.text = model.incessantF.fetoproteinF;
        WEAKSELF
        [model.heelF enumerateObjectsUsingBlock:^(BagBankItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(obj.franticF == model.incessantF.autoinfectionF){
                strongSelf.selectModel = obj;
                strongSelf.bankTitleLabel.text = NotNull(strongSelf.selectModel.antineoplastonF);
                strongSelf.bankTitleLabel.font = [UIFont boldSystemFontOfSize:16];
                strongSelf.bankTitleLabel.textColor = [UIColor qmui_colorWithHexString:@"#333333"];
                *stop = YES;
            }
        }];
    }
}
- (void)bankListClick{
    [self endEditing:YES];
    BagVerifyPickerView *picker = [[BagVerifyPickerView alloc] initWithTitleArray:self.model.heelF headerTitle:@"Bank card selection"];
    picker.clickBlock = ^(BagBankItemModel *model) {
        self.selectModel = model;
        self.bankTitleLabel.text = NotNull(self.selectModel.antineoplastonF);
        self.bankTitleLabel.font = [UIFont boldSystemFontOfSize:16];
        self.bankTitleLabel.textColor = [UIColor qmui_colorWithHexString:@"#333333"];
        [BagTrackHandleManager trackAppEventName:@"af_pub_result_bank" withElementParam:@{@"type":@(self.selectModel.franticF)}];

    };
    [picker showWithAnimation];
}
#pragma mark - QMUITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //文本彻底结束编辑时调用
    self.bankText = textField.text;
    [BagTrackHandleManager trackAppEventName:@"af_cc_result_card_item" withElementParam:@{@"tag":@"bank", @"content": NotNull(textField.text)}];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [BagTrackHandleManager trackAppEventName:@"af_cc_click_card_item" withElementParam:@{@"tag":@"bank"}];

}
@end
