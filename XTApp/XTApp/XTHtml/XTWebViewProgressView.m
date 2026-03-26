//
//  XTWebViewProgressView.m
//  XTApp
//
//  Created by xia on 2024/9/13.
//

#import "XTWebViewProgressView.h"
#define kAnimationDurationMultiplier (1.8)

@interface XTWebViewProgressView ()<CAAnimationDelegate>

@property (nonatomic) BOOL isWkWebView;

@end

@implementation XTWebViewProgressView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
}

- (void)dealloc {
    XTLog(@"dealloc:%@",[self class]);
}

- (void)configureViews {
    self.isWkWebView = NO;
    self.userInteractionEnabled = NO;
    self.clipsToBounds = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _progressView = [[UIView alloc] initWithFrame:self.bounds];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    UIColor *tintColor = [UIColor colorWithRed:22/255.f
                                         green:126/255.f
                                          blue:251/255.f
                                         alpha:1.f];
    
    if ([UIApplication.sharedApplication.delegate.window respondsToSelector:@selector(setTintColor:)]
        && UIApplication.sharedApplication.delegate.window.tintColor) {
        tintColor = UIApplication.sharedApplication.delegate.window.tintColor;
    }
    
    _progressView.backgroundColor = tintColor;
    [self addSubview:_progressView];
    
    _barDuration = 0.5f;
    _fadeDuration = 0.27f;
    
    [self setProgress:0.f];
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressView.backgroundColor = progressColor;
}

- (UIColor *)progressBarColor {
    return self.progressView.backgroundColor;
}

- (void)setProgress:(float)progress {
    [self setProgress:progress animated:NO];
}

- (void)useWebView:(WKWebView *)webView {
    if (!webView) {
        return;
    }
    self.isWkWebView = YES;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    BOOL isGrowing = progress > 0.f;
    
    CGFloat originX = -CGRectGetWidth(self.bounds)/2;
    CGPoint positionBegin = CGPointMake(originX+_progress * self.bounds.size.width, CGRectGetHeight(self.progressView.frame)/2);
    CGPoint positionEnd = CGPointMake(originX+progress * self.bounds.size.width, CGRectGetHeight(self.progressView.frame)/2);
    
    if (progress < _progress) {
        animated = NO;
    }
    
    if (!isGrowing) {
        if (animated) {
            [UIView animateWithDuration:animated?self.fadeDuration:0.f
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.progressView.center = positionEnd;
                                 self.progressView.alpha = 1.f;
                             } completion:^(BOOL finished) {}];
        } else {
            self.progressView.alpha = 1.f;
            self.progressView.center = positionEnd;
        }
    } else {
        [UIView animateWithDuration:animated?self.fadeDuration:0.f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.progressView.alpha = 1.f;
                         } completion:^(BOOL finished) {}];
        
        if (animated) {
            CAAnimation *animationBounds = nil;
            
            if (progress < 1) {
                if (_progress > 0.01 && [self.progressView.layer animationForKey:@"positionAnimation"]) {
                    positionBegin = [self.progressView.layer.presentationLayer position];
                    self.progressView.layer.position = positionBegin;
                    [self.progressView.layer removeAnimationForKey:@"positionAnimation"];
                }
                
                CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                keyFrameAnimation.duration = kAnimationDurationMultiplier*(progress-_progress)*10;
                keyFrameAnimation.keyTimes = @[ @0, @.3, @1 ];
                keyFrameAnimation.values = @[ [NSValue valueWithCGPoint:positionBegin],
                                              [NSValue valueWithCGPoint:CGPointMake(positionBegin.x+(positionEnd.x-positionBegin.x)*0.9, positionEnd.y)],
                                              [NSValue valueWithCGPoint:positionEnd] ];
                keyFrameAnimation.timingFunctions = @[ [CAMediaTimingFunction functionWithControlPoints: 0.092 : 0.000 : 0.618 : 1.000],
                                                       [CAMediaTimingFunction functionWithControlPoints: 0.000 : 0.688 : 0.479 : 1.000] ];
                
                animationBounds = keyFrameAnimation;
            } else {
                if (_progress > 0.05 && [self.progressView.layer animationForKey:@"positionAnimation"]) {
                    positionBegin = [self.progressView.layer.presentationLayer position];
                    self.progressView.layer.position = positionBegin;
                    [self.progressView.layer removeAnimationForKey:@"positionAnimation"];
                }
                CABasicAnimation *basicAnimationBounds = [CABasicAnimation animationWithKeyPath:@"position"];
                basicAnimationBounds.fromValue = [NSValue valueWithCGPoint:positionBegin];
                basicAnimationBounds.toValue = [NSValue valueWithCGPoint:positionEnd];
                basicAnimationBounds.duration = self.barDuration;
                basicAnimationBounds.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.486 : 0.056 : 0.778 : 0.480];
                
                basicAnimationBounds.delegate = self;
                
                animationBounds = basicAnimationBounds;
            }
            
            [self.progressView.layer addAnimation:animationBounds forKey:@"positionAnimation"];
            self.progressView.layer.position = positionEnd;

        } else {
            self.progressView.layer.position = positionEnd;
        }
    }

    _progress = progress;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _progress = 0.f;
    CABasicAnimation *animationOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animationOpacity.fromValue = @1;
    animationOpacity.toValue = @0;
    animationOpacity.duration = self.fadeDuration;
    animationOpacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.progressView.layer addAnimation:animationOpacity forKey:@"opacityAnimation"];
    self.progressView.layer.opacity = 0;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self setProgress:[change[@"new"] doubleValue] animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
