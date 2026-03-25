//
//  PTWebViewController.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/22.
//

#import "PTWebViewController.h"
#import <WebKit/WebKit.h>
#import <AFNetworking/AFNetworking.h>
#import "PTRequestUrlArgumentsFilter.h"
#import <StoreKit/StoreKit.h>
@interface PTWebViewController ()<WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>
@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) UIProgressView *progressView;
@end

@implementation PTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creaSubViews];
    [self addEstimated];
    [self webViewloadURL];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDargView" object:@{@"hidden":@(1)}];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDargView" object:@{@"hidden":@(0)}];
    if (@available(iOS 14.0, *)) {
        [self.webView.configuration.userContentController removeAllScriptMessageHandlers];
    } else {
        NSArray * listMthod = @[@"ten001", @"ten002", @"ten003", @"ten004", @"ten005",@"ten006",];
        for (NSString *item in listMthod) {
            [self.webView.configuration.userContentController removeScriptMessageHandlerForName:item];
;
        }
        // Fallback on earlier versions
    }
}
- (void)leftBtnClick
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creaSubViews
{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    NSArray * listMthod = @[@"ten001", @"ten002", @"ten003", @"ten004", @"ten005",@"ten006",];
    for (NSString *item in listMthod) {
        [self.webView.configuration.userContentController addScriptMessageHandler:self name: item];
    }
}

- (void)addEstimated
{
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [UIView animateWithDuration:0.5 animations:^{
        [self.progressView setProgress:0.3 animated:YES];
    }];
    
}

- (void)webViewloadURL
{
    NSString *paraUrlString = AFQueryStringFromParameters([PTRequestUrlArgumentsFilter getURLParam]).stringByRemovingPercentEncoding;
    NSString *urlStr = @"";
    if ([self.url hasSuffix:@"?"]) {
        urlStr = [NSString stringWithFormat:@"%@%@", self.url, [PTTools urlZhEncode:paraUrlString]];
    } else if ([self.url containsString:@"?"]) {
        urlStr = [NSString stringWithFormat:@"%@&%@", self.url, [PTTools urlZhEncode:paraUrlString]];
    } else {
        urlStr = [NSString stringWithFormat:@"%@?%@", self.url, [PTTools urlZhEncode:paraUrlString]];
    }
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy: NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f];
    [self.webView loadRequest:request];
}


///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self backBtnClick];
    return NO;
}
-(void)backBtnClick
{
   if (self.webView.canGoBack) {
       [self.webView goBack];
       return;
   }

    
//    NSMutableArray *vcArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//    [vcArr enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if([obj isKindOfClass:[GCAuthDetailController class]]){
//            [vcArr removeObject:obj];
//            *stop = YES;
//        }
//    }];
//    self.navigationController.viewControllers =vcArr;
    [self.navigationController qmui_popViewControllerAnimated:YES completion:nil];
}


#pragma mark  - WKNavigationDelegate
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    if ([navigationAction.request.URL.scheme containsString:@"whatsapp"] || [navigationAction.request.URL.scheme containsString:@"mailto"] ){
        if ([[UIApplication sharedApplication] canOpenURL: navigationAction.request.URL]) {
            [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:^(BOOL success) {
            }];
        }
        actionPolicy = WKNavigationActionPolicyCancel;
    }
    decisionHandler(actionPolicy);
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成webview_didFinishNavigation");
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable resultStr, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showtitle:resultStr isLeft:NO disPlayType:PTDisplayTypeBlack];
        });
    }];
}
///加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
   
}


#pragma mark - WKScriptMessageHandler协议
//WKScriptMessageHandler协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSString *parame = message.body;
    if([message.name isEqualToString:@"ten001"]) {//getPoint 获取埋点信息
        NSDictionary *dic = @{
                             @"botenomofoNc": PTNotNull(PTLocation.latitude),
                             @"untenevoutNc":PTNotNull(PTLocation.longitude),
                             @"catencotomyNc":PTNotNull(PTDeviceInfo.idfv),
                             @"sptendilleNc":PTNotNull(PTDeviceInfo.idfa),
                             };

        NSString *str = [NSString stringWithFormat:@"ten002('%@')",[dic yy_modelToJSONString]];
        [self.webView evaluateJavaScript:str completionHandler:^(id response, NSError * error) {
            if(error) {
                NSLog(@"失败:%@",error);
            }
         }];
        
    }
    else if([message.name isEqualToString:@"ten003"]) {//callPhoneMethod(String phoneNumber) H5 页面里的拨打电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",parame]] options:@{} completionHandler:nil];
    }
    else if([message.name isEqualToString:@"ten004"]) {//jumpToHome 回到 App 首页
        UIViewController *vc = self.navigationController.viewControllers.firstObject;
        if([vc isKindOfClass:[UITabBarController class]]){
            ((UITabBarController *)vc).selectedIndex = 0;
        }
        [self.navigationController popToViewController:vc animated:YES];
    }
    else if([message.name isEqualToString:@"ten005"]) {//toGrade 调用 App 应用评分
        if(@available(iOS 14.0, *)) {
            UIWindowScene *scene = self.view.window.windowScene;
            [SKStoreReviewController requestReviewInScene:scene];
        }
        else if(@available(iOS 10.3, *)) {
            [SKStoreReviewController requestReview];
        }
    }
    else if([message.name isEqualToString:@"ten006"]) {//openAppstore(String appPkg) 跳转 Appstore
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:parame] options:@{} completionHandler:nil];
    }
//    else if([message.name isEqualToString:@"eig007"]) {//jump(String url) 原生页面跳转
//        if([NSString isValidateHTTPUrl:parame]) {
//            [self goHtml:parame];
//        }
//        else if([parame rangeOfString:@"zzzy"].location != NSNotFound) {///设置
//            [self.navigationController pushViewController:DC_View_Controller_Init(@"DCMySetVC") animated:YES];
//        }
//        else if([parame rangeOfString:@"zzzz"].location != NSNotFound) {///首页
//            UIViewController *vc = self.navigationController.viewControllers.firstObject;
//            if([vc isKindOfClass:[UITabBarController class]]){
//                ((UITabBarController *)vc).selectedIndex = 0;
//            }
//            [self.navigationController popToViewController:vc animated:YES];
//        }
//        else if([parame rangeOfString:@"zzzx"].location != NSNotFound) {///重新登录
//            [[DCNetwork shareInstance] reloadLogin];
//        }
//        else if([parame rangeOfString:@"zzzw"].location != NSNotFound) {///订单列表页
//            UIViewController *vc = self.navigationController.viewControllers.firstObject;
//            if([vc isKindOfClass:[UITabBarController class]]){
//                ((UITabBarController *)vc).selectedIndex = 1;
//            }
//            [self.navigationController popToViewController:vc animated:YES];
//        }
//        else if([parame rangeOfString:@"zzzv"].location != NSNotFound) {///产品详情
//            NSArray *arr = [parame componentsSeparatedByString:@"unannealedMc="];
//            if(arr.count == 2) {
//                NSString *productId = arr.lastObject;
//                [self checkProductId:productId];
//            }
//            
//        }
//        
//    }
}

#pragma mark - 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.progressView.alpha = 1.0f;
        [self.progressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            WEAKSELF;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 0.6f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;

            }];
        }
        
    }else if(object == self.webView && [keyPath isEqualToString:@"title"]){
        //[self.navBar showtitle:NotNull(self.webView.title) isLeft:YES disPlayType:GCDisplayTypeBlack];
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - lazy
-(WKWebView *)webView{
    if(!_webView){
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.navView.y + self.navView.height, kScreenWidth, kScreenHeight - self.navView.y - self.navView.height - KBottomHeight)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

-(UIProgressView *)progressView{
    if(!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, self.navView.y + self.navView.height, kScreenWidth, 0.5)];
        _progressView.tintColor = PTUIColorFromHex(0x29CB2D);
        _progressView.trackTintColor = [UIColor whiteColor];
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 0.7f);
    }
    return _progressView;
}
- (void)dealloc
{
    
}
@end
