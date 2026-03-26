//
//  XTHtmlVC.m
//  XTApp
//
//  Created by xia on 2024/9/4.
//

#import "XTHtmlVC.h"
#import "XTWebViewProgressView.h"
#import <StoreKit/StoreKit.h>
#import "XTLocationManger.h"
#import "XTFirstViewModel.h"
#import "XTRequestCenter.h"
#import "XTBaseApi.h"

@interface XTHtmlVC ()<WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>

@property(nonatomic,copy) NSString *url;
@property(nonatomic,strong) XTFirstViewModel *viewModel;
@property(nonatomic,strong) NSArray <NSString *>*jslist;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) XTWebViewProgressView *progress;


@end

@implementation XTHtmlVC

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self.progress forKeyPath:@"estimatedProgress"];
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
    self.webView = nil;
    self.progress = nil;
}


- (instancetype)initUrl:(NSString *)url {
    self = [super init];
    if(self) {
        self.url = url;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for(NSString *str in self.jslist) {
        [self.webView.configuration.userContentController addScriptMessageHandler:self name:str];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    for(NSString *str in self.jslist) {
        [self.webView.configuration.userContentController removeScriptMessageHandlerForName:str];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([NSString xt_isEmpty:[XTLocationManger xt_share].xt_longitude] || [NSString xt_isEmpty:[XTLocationManger xt_share].xt_latitude]) {
        [[XTLocationManger xt_share] xt_startLocation];
    }
    [self.view addSubview:self.webView];
    [self.xt_navView addSubview:self.progress];
}

- (void)xt_back {
    if([self.webView canGoBack]) {
        [self.webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.webView && [keyPath isEqualToString:@"title"]) {
        self.xt_title = self.webView.title;
    }
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

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSString *parame = message.body;
    if([message.name isEqualToString:@"six001"]) {//埋点信息
        __block NSString *idfaStr = @"";
        [XTDevice xt_getIdfaShowAlt:NO block:^(NSString * _Nonnull idfa) {
            idfaStr = idfa;
        }];

        NSDictionary *dic = @{
            @"boomsixofoNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_latitude),
            @"cacosixtomyNc":XT_Object_To_Stirng([XTDevice xt_share].xt_idfv),
            @"unevsixoutNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_longitude),
            @"spdisixlleNc":XT_Object_To_Stirng(idfaStr),
        };
        NSString *dicStr = [XTUtility xt_objectToJSONString:dic];
        NSString *str = [NSString stringWithFormat:@"six002(%@)",dicStr];
        [self.webView evaluateJavaScript:str completionHandler:^(id response, NSError * error) {
            if(error) {
                XTLog(@"失败:%@",error);
            }
         }];
    }
    else if([message.name isEqualToString:@"six003"]) {//拨打电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",parame]] options:@{} completionHandler:nil];
    }
    else if([message.name isEqualToString:@"six004"]) {//回到 App 首页
        UIViewController *vc = self.navigationController.viewControllers.firstObject;
        if([vc isKindOfClass:[UITabBarController class]]){
            ((UITabBarController *)vc).selectedIndex = 0;
        }
        [self.navigationController popToViewController:vc animated:YES];
    }
    else if([message.name isEqualToString:@"six005"]) {//App 应用评分
        if(@available(iOS 14.0, *)) {
            UIWindowScene *vc = self.view.window.windowScene;
            [SKStoreReviewController requestReviewInScene:vc];
        }
        else if(@available(iOS 10.3, *)) {
            [SKStoreReviewController requestReview];
        }
    }
    else if([message.name isEqualToString:@"six006"]) {//openAppstore(String appPkg) 跳转 Appstore
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:parame] options:@{} completionHandler:nil];
    }
    else if([message.name isEqualToString:@"six007"]) {//jump(String url) 原生页面跳转
        if([NSString xt_isValidateUrl:parame]) {
            [[XTRoute xt_share] goHtml:parame success:nil];
        }
        else if([parame rangeOfString:@"zzsixzy"].location != NSNotFound) {///设置
            [self.navigationController pushViewController:XT_Controller_Init(@"XTSetVC") animated:YES];
        }
        else if([parame rangeOfString:@"zzsixzz"].location != NSNotFound) {///首页
            UIViewController *vc = self.navigationController.viewControllers.firstObject;
            if([vc isKindOfClass:[UITabBarController class]]){
                ((UITabBarController *)vc).selectedIndex = 0;
            }
            [self.navigationController popToViewController:vc animated:YES];
        }
        else if([parame rangeOfString:@"zzsixzx"].location != NSNotFound) {///重新登录
            [XTUtility xt_login:^{
                
            }];
        }
        else if([parame rangeOfString:@"zzsixzw"].location != NSNotFound) {///订单列表页
            [self.navigationController popToViewController:XT_Controller_Init(@"XTOrderVC") animated:YES];
        }
        else if([parame rangeOfString:@"zzsixzv"].location != NSNotFound) {///产品详情
            NSArray *arr = [parame componentsSeparatedByString:@"lietsixusNc="];
            if(arr.count == 2) {
                NSString *xt_productId = arr.lastObject;
                [self checkApply:xt_productId];
            }
            
        }
        
    }
}

#pragma mark 检测
- (void)checkApply:(NSString *)productId{
    if([NSString xt_isEmpty:productId]){
        return;
    }
    @weakify(self)
    if(![XTUserManger xt_isLogin]){
        [XTUtility xt_login:^{
            @strongify(self)
            [self checkApply:productId];
        }];
        return;
    }
    
    if([XTUserManger xt_share].xt_user.xt_is_aduit){
        [self goApply:productId];
        return;
    }
    
    if(![[XTLocationManger xt_share] xt_canLocation]) {
        UIAlertController *altVC = [UIAlertController alertControllerWithTitle:@"Tips" message:@"To be able to use our app, please turn on your device location services." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [altVC addAction:cancelAction];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }];
        [altVC addAction:sureAction];
        [self xt_presentViewController:altVC animated:YES completion:nil modalPresentationStyle:UIModalPresentationFullScreen];
        return;
    }
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    [[XTRequestCenter xt_share] xt_location:^(BOOL success) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        if(success) {
            [self goApply:productId];
        }
    }];
}

- (void)goApply:(NSString *)productId {
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_apply:productId success:^(NSInteger uploadType, NSString * _Nonnull url, BOOL isList) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        if(uploadType == 2) {
            [[XTRequestCenter xt_share] xt_device];
        }
        if([NSString xt_isValidateUrl:url]){
            [[XTRoute xt_share] goHtml:url success:nil];
            return;
        }
//        if(isList) {
//            [[XTRoute xt_share] goVerifyList:productId];
//            return;
//        }
        [self goDetail:productId];
        
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

- (void)goDetail:(NSString *)productId {
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_detail:productId success:^(NSString * _Nonnull code, NSString * _Nonnull orderId) {
        @strongify(self)
        if(![NSString xt_isEmpty:code]) {
            [XTUtility xt_atHideProgress:self.view];
            [[XTRoute xt_share] goVerifyItem:code productId:productId orderId:orderId success:nil];
        }
        else {
            [self.viewModel xt_push:orderId success:^(NSString *str) {
                @strongify(self)
                [XTUtility xt_atHideProgress:self.view];
                [[XTRoute xt_share] goHtml:str success:nil];
            } failure:^{
                @strongify(self)
                [XTUtility xt_atHideProgress:self.view];
            }];
        }
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

-(XTWebViewProgressView *)progress{
    if(!_progress){
        XTWebViewProgressView *progress = [[XTWebViewProgressView alloc] initWithFrame:CGRectMake(0, self.xt_navView.height - 2, self.xt_navView.width, 2)];
        [progress useWebView:self.webView];
        progress.progressColor = XT_RGB(0xF3FF9B, 1.0f);
        _progress = progress;
    }
    return _progress;
}

-(WKWebView *)webView{
    if(!_webView){
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.xt_navView.y + self.xt_navView.height, self.view.width, self.view.height - (self.xt_navView.y + self.xt_navView.height) - XT_Bottom_Height)];
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];

        NSString *url =  [[[XTBaseApi alloc] init] webUrlAppendQueryParameterToUrl:self.url];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        if (@available(iOS 11.0, *)) {
            webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _webView = webView;
    }
    
    return _webView;
}


- (NSArray<NSString *> *)jslist {
    if(!_jslist) {
        _jslist = @[
            @"six001",
            @"six002",
            @"six003",
            @"six004",
            @"six005",
            @"six006",
            @"six007",
        ];
    }
    return _jslist;
}

- (XTFirstViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [[XTFirstViewModel alloc] init];
    }
    return _viewModel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
