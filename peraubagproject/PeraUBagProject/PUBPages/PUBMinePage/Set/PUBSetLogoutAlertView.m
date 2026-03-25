//
//  PUBSetLogoutAlertView.m
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/16.
//

#import "PUBSetLogoutAlertView.h"
@interface PUBSetLogoutAlertView()
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation PUBSetLogoutAlertView
+ (instancetype) createAlertView{
    PUBSetLogoutAlertView *alert = [[[NSBundle mainBundle] loadNibNamed:@"PUBSetLogoutAlertView" owner:nil options:nil] lastObject];
    return alert;
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.confirmBtn.layer.borderWidth = 1;
    self.confirmBtn.layer.borderColor = [UIColor qmui_colorWithHexString:@"#ffffff"].CGColor;
}
- (void)showTiltle:(NSString*)tiltle{
    self.titleLabel.text = NotNull(tiltle);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (IBAction)cancelAction:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)confirmAction:(id)sender {
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self removeFromSuperview];
}


@end
