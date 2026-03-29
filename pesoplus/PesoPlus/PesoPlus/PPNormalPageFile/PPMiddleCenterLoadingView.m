//
//  PPMiddleCenterLoadingView.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPMiddleCenterLoadingView.h"

@interface PPMiddleCenterLoadingView ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation PPMiddleCenterLoadingView

+ (instancetype)sharedInstance {
    static PPMiddleCenterLoadingView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
        sharedInstance.backgroundColor = UIColor.clearColor;
        [sharedInstance setupActivityIndicator];
    });
    return sharedInstance;
}

- (void)setupActivityIndicator {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicator.center = self.center;
    self.activityIndicator.color = [UIColor blackColor];
    [self addSubview:self.activityIndicator];
}

+ (void)showLoading {
    PPMiddleCenterLoadingView *hud = [PPMiddleCenterLoadingView sharedInstance];
    [TopWindow addSubview:hud];
    [hud.activityIndicator startAnimating];
}

+ (void)hideLoading {
    PPMiddleCenterLoadingView *hud = [PPMiddleCenterLoadingView sharedInstance];
    [hud.activityIndicator stopAnimating];
    [hud removeFromSuperview];
}

@end
