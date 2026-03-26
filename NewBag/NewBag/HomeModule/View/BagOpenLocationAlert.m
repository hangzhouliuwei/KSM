//
//  BagOpenLocationAlert.m
//  NewBag
//
//  Created by Jacky on 2024/4/15.
//

#import "BagOpenLocationAlert.h"

@interface BagOpenLocationAlert ()
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@end
@implementation BagOpenLocationAlert
- (void)awakeFromNib
{
    [super awakeFromNib];
    [_agreeBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#205EAC"] toColor:[UIColor qmui_colorWithHexString:@"#154685"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth - 40, 40)];
    [_agreeBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, kScreenWidth - 40, 40)];
}
+ (instancetype)createView{
    BagOpenLocationAlert *alert = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    return alert;
}
- (IBAction)agreeAction:(id)sender {
    if (self.clickBlock) {
        self.clickBlock();
    }
    [self removeFromSuperview];
}
- (void)show
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self layoutIfNeeded];
    [[UIApplication sharedApplication].windows.firstObject addSubview:self];
}

@end
