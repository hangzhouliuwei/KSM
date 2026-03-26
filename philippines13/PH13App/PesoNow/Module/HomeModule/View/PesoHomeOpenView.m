//
//  PesoHomeOpenView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/19.
//

#import "PesoHomeOpenView.h"
@interface PesoHomeOpenView()
@property (nonatomic, strong) UIImageView *image;
@end
@implementation PesoHomeOpenView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
    }
    return self;
}
- (void)createUI{
    UIImageView *image  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.frame = CGRectMake(0, 0, 317, 394);
    image.center = self.center;
    image.userInteractionEnabled = YES;
    [self addSubview:image];
    _image = image;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick)];
    [image addGestureRecognizer:tap];
    
    QMUIButton *closeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, image.bottom+16, 32, 32);
    closeBtn.centerX = self.centerX;
    [closeBtn setImage:[UIImage imageNamed:@"home_popClose"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
}
- (void)updatePopWithIconURL:(NSString *)url
{
    [_image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage br_imageWithColor:[UIColor orangeColor]]];
}
- (void)onClick{
    if (self.clickBlock) {
        self.clickBlock();
    }
    [self closeAction];
}
- (void)show
{
    [UIApplication.sharedApplication.windows.firstObject addSubview:self];
}
- (void)closeAction{
    [self removeFromSuperview];
}
@end
