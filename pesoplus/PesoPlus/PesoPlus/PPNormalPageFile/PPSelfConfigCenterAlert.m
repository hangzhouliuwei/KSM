//
//  PPSelfConfigCenterAlert.m
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import "PPSelfConfigCenterAlert.h"

@interface PPSelfConfigCenterAlert ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *customView;
@end

@implementation PPSelfConfigCenterAlert

- (id)initWithPPCenterCustomView:(UIView *)customView {
    self = [super init];
    if (self) {
        _customView = customView;
        self.backgroundColor = UIColor.clearColor;
        [self loadUI];
    }
    return self;
}


- (void)loadUI {
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    UIButton *bgGrayView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgGrayView.frame = self.frame;
    bgGrayView.backgroundColor = [UIColor blackColor];
    bgGrayView.alpha = 0.5;
    [bgGrayView addTarget:self action:@selector(hideAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgGrayView];
    
    _customView.center = self.center;
    _alertView = _customView;
    [self addSubview:_alertView];
    return;
}

- (void)show {
    self.alpha = 1;
    [TopWindow addSubview:self];
    [self addAnimation];
}

- (void)addAnimation {
    CAKeyframeAnimation *antscale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    antscale.values = @[@(0.2),@(1.11),@(0.88),@(1.0)];
    antscale.calculationMode = kCAAnimationLinear;
    CAAnimationGroup *animationItemGroup = [CAAnimationGroup animation];
    animationItemGroup.animations = @[antscale];
    animationItemGroup.duration = 0.25;
    [_alertView.layer addAnimation:animationItemGroup forKey:nil];
}

- (void)hideAction {
    [self hide];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

