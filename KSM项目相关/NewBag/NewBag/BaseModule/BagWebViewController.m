//
//  BagWebViewController.m
//  NewBag
//
//  Created by Jacky on 2024/3/24.
//

#import "BagWebViewController.h"
#import <WebKit/WebKit.h>
#import "BagJSManager.h"
#import "BagRequestUrlArgumentsFilter.h"
#import <AFNetworking/AFNetworking.h>
@interface BagWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UINavigationControllerDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation BagWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftTitleColor = @"#333333";
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.equalTo(self.view).inset(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, -0.5, CGRectGetWidth(self.view.frame),1)];
    _progressView.trackTintColor = [UIColor whiteColor];
    _progressView.progressTintColor = [UIColor qmui_colorWithHexString:@"#205EAB"];
    _progressView.backgroundColor = [UIColor whiteColor];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 0.25f);
    _progressView.transform = transform;
    [self.view addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.webView.mas_top).offset(0);
        make.height.mas_equalTo(2);
    }];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];

    self.navigationController.delegate = self;
  
    [self webViewloadURL];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dargView" object:@{@"hidden":@(1)}];
    /**注入方法**/
    NSArray * listMthod = @[@"fourteen001", @"fourteen002", @"fourteen003", @"fourteen004", @"fourteen005", @"fourteen006", @"fourteen007"];
    for (NSString *item in listMthod) {
        
        [self.webView.configuration.userContentController addScriptMessageHandler:self name: item];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dargView" object:@{@"hidden":@(0)}];
    
    [self removeScriptMessageHandler];

}
- (void)removeScriptMessageHandler{
    NSArray * listMthod = @[@"fourteen001", @"fourteen002", @"fourteen003", @"fourteen004", @"fourteen005", @"fourteen006", @"fourteen007"];
    for (NSString *item in listMthod) {
        [self.webView.configuration.userContentController removeScriptMessageHandlerForName: item];
    }
}
#pragma mark - 加载 h5
- (void)webViewloadURL{
    
    NSString *paraUrlString = AFQueryStringFromParameters([BagRequestUrlArgumentsFilter getURLParam]).stringByRemovingPercentEncoding;
    NSString *urlStr = @"";
    if ([self.url hasSuffix:@"?"]) {
        urlStr = [NSString stringWithFormat:@"%@%@", self.url, [paraUrlString br_stringByUTF8Encode]];
    } else if ([self.url containsString:@"?"]) {
        urlStr = [NSString stringWithFormat:@"%@&%@", self.url, [paraUrlString br_stringByUTF8Encode]];
    } else {
        urlStr = [NSString stringWithFormat:@"%@?%@", self.url, [paraUrlString br_stringByUTF8Encode]];
    }
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy: NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f];
    [self.webView loadRequest:request];
}
- (void)backClick
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        return;
    }
    [self.navigationController qmui_popViewControllerAnimated:YES completion:nil];
}

///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    
    [self backClick];
    return NO;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isSelf = [viewController isKindOfClass:[self class]];
    if (isSelf) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark - webview

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成webview_didFinishNavigation");
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable resultStr, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
         self.leftTitle = resultStr;
        });
    }];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"加载失败webview_didFailProvisionalNavigation");
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
 
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
      WEAKSELF
    NSLog(@"lw=====>message %@",message);
    [BagJSManager.sharedInstance receiveScriptMessage:message CallBlock:^(NSString *str) {
        STRONGSELF
        if([str br_isBlankString])return;
        [strongSelf webViewCallBackStr:str];
    }];
}

- (void)webViewCallBackStr:(NSString*)callBackStr
{
    [self.webView evaluateJavaScript:callBackStr
               completionHandler:^(id response, NSError * error) {
     }];
}
//H5调用native弹框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s",__FUNCTION__);
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"提示" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"%@", navigationAction.request.URL.absoluteString);
    if ([navigationAction.request.URL.scheme containsString: @"whatsapp"] || [navigationAction.request.URL.scheme containsString: @"mailto"] ){
        if ([[UIApplication sharedApplication] canOpenURL: navigationAction.request.URL]) {
            [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:^(BOOL success) {
                //
            }];
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }

}
#pragma mark - 观察者监测进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual: @"estimatedProgress"] && object == _webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }
}
#pragma mark - getter
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.backgroundColor = [UIColor qmui_colorWithHexString:@"#ffffff"];
        _webView.scrollView.backgroundColor = [UIColor qmui_colorWithHexString:@"#ffffff"];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView.scrollView setShowsVerticalScrollIndicator:false];
    }
    return _webView;
}
@end
