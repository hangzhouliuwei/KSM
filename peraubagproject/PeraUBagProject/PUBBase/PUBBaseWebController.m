//
//  PUBBaseWebController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/20.
//

#import "PUBBaseWebController.h"
#import "PUBJSManager.h"

@interface PUBBaseWebController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
@property(nonatomic,assign)BOOL loadSuccess;
@end

@implementation PUBBaseWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.height = KSCREEN_HEIGHT - self.navBar.bottom;
    [self.navBar showtitle:NotNull(self.h5Title) isLeft:NO];
    if (self.loadSuccess) {
        return;
    }
    
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        [weakSelf showEmptyViewWithLoading];
        if (!weakSelf.loadSuccess) {
            weakSelf.emptyView.hidden = NO;
        }else {
            weakSelf.emptyView.hidden = YES;
        }
    });
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSArray * listMthod = @[@"quintessenti", @"epiphany", @"openCall", @"goHome", @"goScore", @"goAppstore", @"goRun"];
    for (NSString *item in listMthod) {
        [self.webView.configuration.userContentController addScriptMessageHandler:self name: item];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!VCManager.dragView.isHidden){
        VCManager.dragView.hidden = YES;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(VCManager.dragView.isHidden){
        VCManager.dragView.hidden = NO;
    }
}


- (void)buttonAction
{
    [self loadRequest];
}

///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self backBtnClick:nil];
    return NO;
}

- (void)backBtnClick:(UIButton *)btn {

    if (self.webView.canGoBack) {
        [self.webView goBack];
        return;
    }
    if (self.isPresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController qmui_popViewControllerAnimated:YES completion:nil];
    }
   
}

- (void)loadView {
    [super loadView];
    if (@available(iOS 11.0,*)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (!self.loadSuccess) {
        [self loadRequest];
    }
}

- (void)setCanRefresh:(BOOL)canRefresh {
    WEAKSELF
    _canRefresh = canRefresh;
}

- (void)loadRequest {
    NSString * urlStr = self.url;

    if (![self.url containsString:@"beth_bag"]) {
        NSString* commonParameters = [PUBRequestManager commonParameter];
        if ([self.url hasSuffix:@"?"]) {
            urlStr = [NSString stringWithFormat:@"%@%@", self.url, [PUBTools urlZhEncode:commonParameters]];
        } else if ([self.url containsString:@"?"]) {
            urlStr = [NSString stringWithFormat:@"%@&%@", self.url, [PUBTools urlZhEncode:commonParameters]];
        } else {
            urlStr = [NSString stringWithFormat:@"%@?%@", self.url, [PUBTools urlZhEncode:commonParameters]];
        }
    }

//    urlStr = @"http://192.168.58.64:8086/#/loanConfirmNew?hypokinesis_eg=3544&grouse_eg=1&aaaaa=1705488365&beth_bag=ios&categorize_bag=1.0&trough_bag=iPhone%2014%20Pro%20Max&chopboat_bag=2D50EAD3-3061-47C0-B9FA-C1760B0E1EDA&growler_bag=16.4.1&idolize_bag=ph&endothelioma_bag=com.ci.perabagios&anisodont_bag=1896E77D-A316-43A3-B8B9-D0C42C5BD2AF&aleph_eg=ca494fde5fd499bfc3b373c7d9004152&faithful_eg=226446677755";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30]];
//    [self.contentView.mj_header endRefreshing];
    NSLog(@"---self.url----%@+++++++",urlStr);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成webview_didFinishNavigation");
    [self hideEmptyView];
    self.loadSuccess = YES;
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable resultStr, NSError * _Nullable error) {
      [self.navBar  showtitle:resultStr isLeft:NO];
    }];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"加载失败webview_didFailProvisionalNavigation");
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    [self showEmptyViewWithImage:[UIImage imageNamed:@"pub_Nodata"] text:@"NO records" detailText:@"" buttonTitle:@"Apply now" buttonAction:@selector(buttonAction)];
    self.loadSuccess = NO;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
      WEAKSELF
    NSLog(@"lw=====>message %@",message);
    [JSManager receiveScriptMessage:message CallBlock:^(NSString *str) {
        STRONGSELF
        if([PUBTools isBlankString:str])return;
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

- (BOOL)navigationShouldPopMethod {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return false;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:DragViewNotifiName object:nil userInfo:nil];
    return true;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - self.navBar.bottom)];
        _webView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
        _webView.scrollView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [self.contentView addSubview:_webView];
    }
    return _webView;
}

@end
