//
//  BagMeSetAlertView.m
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import "BagMeSetAlertView.h"

@interface BagMeSetAlertView ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomVIew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConst;

@end
@implementation BagMeSetAlertView
+ (instancetype)createAlert{
    BagMeSetAlertView *alert = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    return alert;
}
- (void)updateUIWithTitle:(NSString *)title{
    self.titleLabel.text = title;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.cancelBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#205EAB"] toColor:[UIColor qmui_colorWithHexString:@"#13407C"] direction:BRDirectionTypeTopToBottom bounds:CGRectMake(0, 0, (kScreenWidth -28 -11)/2, 40)];
    [self.cancelBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, (kScreenWidth -28 -11)/2, 40)];
}
- (void)showwithTitle:(NSString *)title{
    self.titleLabel.text = title;

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:5 animations:^{
        self.bottomConst.constant = 0;
    }];
    
}
- (void)drawRect:(CGRect)rect
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}
- (IBAction)cancelAction:(id)sender {
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


@end
