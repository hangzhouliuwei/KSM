//
//  PTHomePopView.m
//  PTApp
//
//  Created by Jacky on 2024/8/29.
//

#import "PTHomePopView.h"

@interface PTHomePopView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) QMUIButton *closeBtn;

@end
@implementation PTHomePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
    }
    return self;
}
- (void)setupUI{
    [self addSubview:self.imageView];
    [self addSubview:self.closeBtn];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(317, 394));
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
}
- (void)updatePopWithIconURL:(NSString *)url
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
}
- (void)onClick{
    if (self.clickBlock) {
        self.clickBlock();
    }
}
- (void)show{
    [UIApplication.sharedApplication.windows.lastObject addSubview:self];
}
- (void)closeAction{
    [self removeFromSuperview];
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}
- (QMUIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"home_popClose"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
@end
