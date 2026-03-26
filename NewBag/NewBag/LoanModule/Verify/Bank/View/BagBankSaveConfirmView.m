//
//  BagBankSaveConfirmView.m
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagBankSaveConfirmView.h"

@interface BagBankSaveConfirmView()
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *accountNum;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end
@implementation BagBankSaveConfirmView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.confirmBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#205EAC"] toColor:[UIColor qmui_colorWithHexString:@"#154685"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, (kScreenWidth - 28)/2, 40)];
    [self.confirmBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4)];
}
- (void)drawRect:(CGRect)rect
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}
+ (instancetype)createView{
    BagBankSaveConfirmView *bank = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    return bank;
}
- (void)show
{
    [[UIApplication sharedApplication].windows.firstObject addSubview:self];
}
- (void)setBank:(NSString *)bank
{
    _bank = bank;
    _bankName.text = bank;
}
- (void)setBankNumber:(NSString *)bankNumber
{
    _bankNumber = bankNumber;
    _accountNum.text = bankNumber;
}
- (IBAction)backAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeFromSuperview];
}
- (IBAction)confirmAction:(id)sender {
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self removeFromSuperview];
}

- (void)dealloc
{
    
}
@end
