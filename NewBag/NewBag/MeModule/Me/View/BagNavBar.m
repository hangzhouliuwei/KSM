//
//  BagNavBar.m
//  NewBag
//
//  Created by Jacky on 2024/4/2.
//

#import "BagNavBar.h"

@interface BagNavBar ()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation BagNavBar
+(instancetype)createNavBar{
    BagNavBar *bar = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    return bar;
}
- (void)setBackTitle:(NSString *)backTitle
{
    _backTitle = backTitle;
    [self.backBtn setTitle:backTitle forState:UIControlStateNormal];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.bgView br_setGradientColor:[UIColor qmui_colorWithHexString:@"#205EAB"] toColor:[UIColor qmui_colorWithHexString:@"#13407C"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth, kNavBarAndStatusBarHeight)];
    [self.backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];

}
- (void)drawRect:(CGRect)rect
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kNavBarAndStatusBarHeight);
}
- (IBAction)backAction:(id)sender {
    if (self.gobackBlock) {
        self.gobackBlock();
    }
}

@end
