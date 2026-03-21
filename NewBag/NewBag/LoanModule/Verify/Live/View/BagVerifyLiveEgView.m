//
//  BagVerifyLiveEgView.m
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagVerifyLiveEgView.h"

@interface BagVerifyLiveEgView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *liveTipImageView;
@end
@implementation BagVerifyLiveEgView

+ (instancetype)createView{
    BagVerifyLiveEgView *view = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
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
    [self.bgView sd_setImageWithURL:[Util loadImageUrl:@"live_bg"]];
    
    [[SDWebImageManager sharedManager] loadImageWithURL:[Util loadImageUrl:@"live_bg2"]
                                                options:0
                                               progress:nil
                                              completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (image) {
            self.liveTipImageView.image = [Util imageResize:image ResizeTo:CGSizeMake(kScreenWidth - 120.f, 80.f)];
        }
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startLive)];
    _bgView.userInteractionEnabled = YES;
    [_bgView addGestureRecognizer:tap];
}
- (void)updateUIWithFail
{
    //self.bgView.image = [UIImage imageNamed:@"live_error"];
    [self.bgView sd_setImageWithURL:[Util loadImageUrl:@"live_error"]];
}
@end
