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
    BagNavBar *bar = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
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
    
    // 使用SDWebImage加载图片
        [[SDWebImageManager sharedManager] loadImageWithURL:[Util loadImageUrl:@"icon_nav_return_white"]
                                                    options:0
                                                   progress:nil
                                                  completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image && finished) {
                // 加载成功后设置图像
                dispatch_async(dispatch_get_main_queue(), ^{
                    //back.image = [Util imageResize:image ResizeTo:CGSizeMake(20.f, 20.f)];
                    [self.backBtn setImage:[Util imageResize:image ResizeTo:CGSizeMake(20.f, 20.f)] forState:UIControlStateNormal];
                });
            }
        }];
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
