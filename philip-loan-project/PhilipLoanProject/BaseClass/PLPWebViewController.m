//
//  WebViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/26.
//

#import "PLPWebViewController.h"
#import <WebKit/WebKit.h>
#import <SafariServices/SafariServices.h>
#import <StoreKit/StoreKit.h>
#import <YYModel/YYModel.h>
@interface PLPWebViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler, SFSafariViewControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation PLPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideServeImageView = true;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 283);
    gradientLayer.colors = @[
        (__bridge id)kBlueColor_0053FF.CGColor,  // #2964F6
        (__bridge id)kHexColor(0xF5F5F5).CGColor   // #F9F9F9
    ];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
}
-(void)BASE_GenerateSubview
{
    // WKWebView的配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.processPool = [[WKProcessPool alloc] init];
    configuration.selectionGranularity = WKSelectionGranularityDynamic;
    configuration.allowsInlineMediaPlayback = YES;
    configuration.mediaTypesRequiringUserActionForPlayback = false;

    WKPreferences* preferences = [[WKPreferences alloc] init];
    preferences.javaScriptEnabled = YES;
    preferences.javaScriptCanOpenWindowsAutomatically = NO;
    configuration.preferences = preferences;
    
  
    if (@available(iOS 13.0, *)) {
       configuration.defaultWebpagePreferences.preferredContentMode = WKContentModeMobile;
    }
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//    NSArray *array = @[@{@"name":@"twelve001"}]
    [userContentController addScriptMessageHandler:self name:@"twelve001"];
    [userContentController addScriptMessageHandler:self name:@"twelve002"];
    [userContentController addScriptMessageHandler:self name:@"twelve003"];
    [userContentController addScriptMessageHandler:self name:@"twelve004"];
    [userContentController addScriptMessageHandler:self name:@"twelve005"];
    [userContentController addScriptMessageHandler:self name:@"twelve006"];
    [userContentController addScriptMessageHandler:self name:@"twelve007"];
//    [userContentController addScriptMessageHandler:self name:ACTION_TOUCH];
    configuration.userContentController = userContentController;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) configuration:configuration];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.opaque = NO;
    
    self.webView.backgroundColor = UIColor.clearColor;
    if (self.url.length > 0) {
        NSString *result = [self generateURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:result]];
        [self.webView loadRequest:request];
    }
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return false;
    }
    return true;
}
-(void)getLocalPoint
{
    
}

-(void)uploadH5Point
{
    
}

-(void)callPhone:(NSString *)phone
{
    NSString *result = [[phone stringByReplacingOccurrencesOfString:@" " withString:@""] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel://%@",result]];
    if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
        }];
    }
}

-(void)jumpToAPPHome
{
    UITabBarController *tab = self.navigationController.tabBarController;
    tab.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)jumpToScore
{
    [SKStoreReviewController requestReview];
}
-(void)jumpToAppStore:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
-(void)jumpToLocalController:(NSString *)pageName
{
    NSString *str = pageName;
    if([pageName containsString:@"https://"] || [pageName containsString:@"http://"]) {
        PLPWebViewController *web = [PLPWebViewController new];
        web.url = pageName;
        [self.navigationController pushViewController:web animated:YES];
    }else
    {
        NSString *name = [PLPDataManager manager].controllerMap[str];
        if (name) {
            Class cls = NSClassFromString(name);
            [self.navigationController pushViewController:[cls new] animated:YES];
        }
    }
}
#pragma mark - WKNavigationDelegate
// 开始加载网页
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    self.progressView.hidden = NO;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view bringSubviewToFront:self.progressView];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSString *titleJs = @"document.title";
    [self.webView evaluateJavaScript:titleJs completionHandler:^(id result, NSError *error) {
        if (error == nil) {
            if (result != nil) {
                NSString *resultString = [NSString stringWithFormat:@"%@", result];
                if ([self.webTitle isReal]) {
                    self.navigationItem.title = resultString;
                }else
                {
                    self.navigationItem.title = resultString;
                }
            }
        }else
        {
            self.navigationItem.title = self.webTitle?:@"";
        }
    }];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSString *name = message.name;
    NSString *body = message.body;
    if ([name isReal]) {
        if ([name isEqualToString:@"twelve001"]) {
            result[@"boomtwelveofoNc"] = [[PLPLocationManager sharedManager] getCurrentLatitude];
            result[@"unevtwelveoutNc"] = [[PLPLocationManager sharedManager] getCurrentLongitude];
            result[@"cacotwelvetomyNc"] = [PLPCommondTools getDeviceIDFV];
            [PLPCommondTools fetchIDFASuccess:^(NSString * _Nonnull idfa) {
                result[@"spditwelvelleNc"]  = idfa;
            }];
            [self evaluateJSWithAction:[NSString stringWithFormat:@"twelve002"] dataDic:result];
        }else if ([name isEqualToString:@"twelve003"]) {
            [self callPhone:body];
        }else if ([name isEqualToString:@"twelve004"]) {
            [self jumpToAPPHome];
        }else if ([name isEqualToString:@"twelve005"]) {
            [self jumpToScore];
        }else if ([name isEqualToString:@"twelve006"]) {
            [self jumpToAppStore:body];
        }else if ([name isEqualToString:@"twelve007"]) {
            [self jumpToLocalController:body];
        }
    }
}
//
- (void)evaluateJSWithAction:(NSString*)actionName dataDic:(NSDictionary*)dataDic
{
    NSString *jsStr = [NSString stringWithFormat:@"%@('%@')",actionName,[dataDic yy_modelToJSONString]];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@", result);
    }];
}



-(void)BASE_BackAction
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *)generateURL
{
    NSString *result = @"";
    if ([self.url hasSuffix:@"?"]) {
        result = [NSString stringWithFormat:@"%@%@",self.url, [PLPCommondTools urlZhEncode:[[PLPNetRequestManager plpJsonManager] plp_generateParams]]];
    }else if ([self.url containsString:@"?"]) {
        result = [NSString stringWithFormat:@"%@&%@",self.url, [PLPCommondTools urlZhEncode:[[PLPNetRequestManager plpJsonManager] plp_generateParams]]];
    }else
    {
        result = [NSString stringWithFormat:@"%@?%@",self.url, [PLPCommondTools urlZhEncode:[[PLPNetRequestManager plpJsonManager] plp_generateParams]]];
    }
 
    return result;
}


- (UIProgressView *)progressView{
    if(!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(-1, kTopHeight, kScreenW+2, 2.f)];
        _progressView.backgroundColor = [UIColor blueColor];
        _progressView.tintColor = [UIColor colorWithRed:118.f/255.f green:214.f/255.f blue:255.f/255.f alpha:1];
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        // 更新进度条的值
        CGFloat newProgress = [change[NSKeyValueChangeNewKey] floatValue];
        [self.progressView setProgress:newProgress animated:YES];
        // 如果加载完成，隐藏进度条
        if (newProgress == 1.0) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0 animated:NO];
                self.progressView.hidden = YES;
            }];
        } else {
            self.progressView.hidden = NO;
            self.progressView.alpha = 1.0;
        }
    }
    
//    //js title返回有延迟，通过监听web标题变化设置标题
//    if ([keyPath isEqualToString:@"title"] && [self isSetDefaultTitle]) {
//        if (object == self.webView) {
//            self.title = self.webView.title;
//        } else {
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        }
//    }
}
-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.webView.navigationDelegate = nil;
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
