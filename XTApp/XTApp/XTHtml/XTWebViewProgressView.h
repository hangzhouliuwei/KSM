//
//  XTWebViewProgressView.h
//  XTApp
//
//  Created by xia on 2024/9/13.
//

#import <UIKit/UIKit.h>
@import WebKit;
NS_ASSUME_NONNULL_BEGIN

@interface XTWebViewProgressView : UIView

@property (nonatomic) float progress;
@property (readonly, nonatomic) UIView *progressView;
/// default 0.5
@property (nonatomic) NSTimeInterval barDuration;
/// default 0.27
@property (nonatomic) NSTimeInterval fadeDuration;
/**
 *  进度条的颜色
 */
@property (copy, nonatomic) UIColor *progressColor;

/**
 *  使用WKWebKit
 *
 *  @param webView WKWebView对象
 */
- (void)useWebView:(WKWebView *)webView;

@end

NS_ASSUME_NONNULL_END
