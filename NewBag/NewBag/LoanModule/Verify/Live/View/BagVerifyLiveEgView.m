//
//  BagVerifyLiveEgView.m
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagVerifyLiveEgView.h"

@interface BagVerifyLiveEgView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@end
@implementation BagVerifyLiveEgView

+ (instancetype)createView{
    BagVerifyLiveEgView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    return view;
}
- (void)startLive{
    if (self.startBlock) {
        self.startBlock();
    }
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startLive)];
    _bgView.userInteractionEnabled = YES;
    [_bgView addGestureRecognizer:tap];
}
- (void)updateUIWithFail
{
    self.bgView.image = [UIImage imageNamed:@"live_error"];
}
@end
