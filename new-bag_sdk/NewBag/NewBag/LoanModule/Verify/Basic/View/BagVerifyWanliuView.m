//
//  BagVerifyWanliuView.m
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagVerifyWanliuView.h"
@interface BagVerifyWanliuView()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
@implementation BagVerifyWanliuView
+ (instancetype)createAlert{
    BagVerifyWanliuView *view = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    return view;
}
- (void)drawRect:(CGRect)rect
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}
- (void)showWithType:(WanLiuType)type
{
    switch (type) {
        case VerifyBasicType:
            //[self.image setImage:[UIImage imageNamed:@"bag_basic_icon"]];
            [self.image sd_setImageWithURL:[Util loadImageUrl:@"bag_basic_icon"]];
            self.desc.text = @"Complete the form to apply for a loan, and we'll tailor a loan amount just for you.";
            break;
        case VerifyContactType:
            //[self.image setImage:[UIImage imageNamed:@"bag_contract_icon"]];
            [self.image sd_setImageWithURL:[Util loadImageUrl:@"bag_contract_icon"]];
            self.desc.text = @"Enhance your loan approval chances by providing your emergency contact information now.";
            break;
        case VerifyIdentifictionType:
            //[self.image setImage:[UIImage imageNamed:@"bag_photos_icon"]];
            [self.image sd_setImageWithURL:[Util loadImageUrl:@"bag_photos_icon"]];
            self.desc.text = @"Complete your identification now for a chance to increase your loan limit.";
            break;
        case VerifyFacialType:
            //[self.image setImage:[UIImage imageNamed:@"bag_live_icon"]];
            [self.image sd_setImageWithURL:[Util loadImageUrl:@"bag_live_icon"]];
            self.desc.text = @"Boost your credit score by completing facial recognition now.";
            break;
        case VerifyWithdrawType:
            //[self.image setImage:[UIImage imageNamed:@"bag_bank_icon"]];
            [self.image sd_setImageWithURL:[Util loadImageUrl:@"bag_bank_icon"]];
            self.desc.text = @"Take the final step to apply for your loan—submitting now will enhance your approval rate.";
            break;

        default:
            break;
    }
    [[UIApplication.sharedApplication.windows firstObject] addSubview:self];

}
- (IBAction)confirmAction:(id)sender {
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self removeFromSuperview];
}
- (IBAction)cancelAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeFromSuperview];
}


@end
