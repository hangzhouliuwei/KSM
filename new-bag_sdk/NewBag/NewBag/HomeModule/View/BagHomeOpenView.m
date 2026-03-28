//
//  BagHomeOpenView.m
//  NewBag
//
//  Created by Jacky on 2024/4/28.
//

#import "BagHomeOpenView.h"

@interface BagHomeOpenView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end
#define kWScale                   (kScreenWidth/375)
@implementation BagHomeOpenView
+ (instancetype)createView
{
    BagHomeOpenView *view = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    return view;
}
- (void)updateUIWithIconUrl:(NSString *)url
{
    [self.closeBtn sd_setImageWithURL:[Util loadImageUrl:@"home_popClose"] forState:UIControlStateNormal];
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(320.f*kWScale, 306.f));
    }];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
}
- (void)drawRect:(CGRect)rect
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap)];
    [self addGestureRecognizer:tap];
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:imageTap];
}
- (void)imageTap{
    if (self.tapBlock) {
        self.tapBlock();
    }
    [self backTap];
}
- (void)show{
    [UIApplication.sharedApplication.windows.lastObject addSubview:self];
}
- (void)backTap{
    [self removeFromSuperview];
}
- (IBAction)closeAction:(id)sender {
    [self backTap];
}

@end
