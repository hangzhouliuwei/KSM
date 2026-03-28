//
//  BagOpenLocationAlert.m
//  NewBag
//
//  Created by Jacky on 2024/4/15.
//

#import "BagOpenLocationAlert.h"

@interface BagOpenLocationAlert ()
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end
@implementation BagOpenLocationAlert
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.backImageView sd_setImageWithURL:[Util loadImageUrl:@"location_alet"]];
    [_agreeBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#205EAC"] toColor:[UIColor qmui_colorWithHexString:@"#154685"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth - 40, 40)];
    [_agreeBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, kScreenWidth - 40, 40)];
}
+ (instancetype)createView{
    BagOpenLocationAlert *alert =  [Util getSourceFromeBundle:NSStringFromClass(self.class)];
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
