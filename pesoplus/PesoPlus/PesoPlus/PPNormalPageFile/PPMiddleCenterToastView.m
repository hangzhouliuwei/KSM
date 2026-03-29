//
//  PPMiddleCenterToastView.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPMiddleCenterToastView.h"

@implementation PPMiddleCenterToastView

+ (void)show:(NSString *)string {
    [PPMiddleCenterToastView show:string time:1.0];
}

+ (void)show:(NSString *)string time:(NSTimeInterval)time {
    if (string.length == 0) {
        return;
    }
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:TopWindow.bounds];
    bgView.userInteractionEnabled = YES;
    
    float viewWith = ScreenWidth / 2;
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 10.f, viewWith - 20, 0)];
    [label setText:string];
    [label setNumberOfLines:0];
    [label setFont:Font(15)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label sizeToFit];

    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, label.w + 20, label.h + 20)];
    grayView.layer.cornerRadius = 15;
    grayView.backgroundColor = UIColor.blackColor;
    grayView.alpha = 0.6;
    [grayView addSubview:label];
    [bgView addSubview:grayView];
    grayView.center = bgView.center;
    
    [TopWindow addSubview:bgView];
    
    [UIView animateWithDuration:0.2 animations:^{
        grayView.alpha = 1;
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:time-0.4f
                                          target:self
                                        selector:@selector(hide:)
                                        userInfo:bgView
                                         repeats:NO];
    }];
}

+ (void)hide:(NSTimer *)timer {
    UIView* flashTipView = (UIView *)[timer userInfo];
    [UIView animateWithDuration:0.2f animations:^{
        flashTipView.alpha = 0;
    } completion:^(BOOL finished){
        [flashTipView removeFromSuperview];
    }];
}

@end
