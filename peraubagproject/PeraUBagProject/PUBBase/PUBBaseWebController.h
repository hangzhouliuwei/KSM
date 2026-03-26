//
//  PUBBaseWebController.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/20.
//

#import "PUBBaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PUBBaseWebController : PUBBaseViewController
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *h5Title;
@property (nonatomic, assign) BOOL canRefresh;
@property (nonatomic, assign) BOOL isPresent;
- (void)loadRequest;
@end

NS_ASSUME_NONNULL_END
