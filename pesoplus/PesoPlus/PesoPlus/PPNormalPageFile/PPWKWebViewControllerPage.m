//
//  PPWKWebViewControllerPage.m
// FIexiLend
//
//  Created by jacky on 2024/11/7.
//

#import "PPWKWebViewControllerPage.h"
#import "JSBridge.h"

@interface PPWKWebViewControllerPage () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler, UIGestureRecognizerDelegate>
@property (nonatomic, copy) NSArray *windowMethods;
@end

@implementation PPWKWebViewControllerPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFeatch];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)loadView {
    [super loadView];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    NSArray * handleArr = @[@"dfiuvb01", @"dfiuvb02",@"dfiuvb03",@"dfiuvb04",@"dfiuvb05",@"dfiuvb06",@"dfiuvb07"];

    configuration.userContentController = [WKUserContentController new];
        for (int i = 0; i < handleArr.count; i++) {
        NSString *method = handleArr[i];
        [configuration.userContentController addScriptMessageHandler:self name:method];
    }
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    
    _webPageV = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.content.h) configuration:configuration];
    _webPageV.backgroundColor = UIColor.whiteColor;
    _webPageV.UIDelegate = self;
    _webPageV.navigationDelegate = self;
    [self.content addSubview:_webPageV];
    [_webPageV addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];

    _webPageV.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    UIView *touchView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 200, 300)];
    touchView.backgroundColor = UIColor.redColor;
//    touchView.alpha = 0;
    touchView.hidden = YES;
    [self.view addSubview:touchView];
}

- (void)backAction {
    [self goBackBtnClick:nil];
}

- (void)goBackBtnClick:(UIButton *)btn {
    if (_isPresent) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        return;
    }
    if (_webPageV.canGoBack) {
        [_webPageV goBack];
        return;
    }
    [Page pop];
}

- (void)loadDataFeatch {
    NSString * urlStr = self.url;
    if([self.url hasPrefix:@"?"]){
        urlStr = [NSString stringWithFormat:@"%@%@",self.url, [self urlEncode: Http.headerString]];
    }else if ([self.url containsString:@"?"]){
        urlStr = [NSString stringWithFormat:@"%@&%@", self.url, [self urlEncode: Http.headerString]];
    }else{
        urlStr = [NSString stringWithFormat:@"%@?%@", self.url, [self urlEncode: Http.headerString]];
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [_webPageV loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30]];
}

- (NSString *)urlEncode:(NSString *)urlStr {
    if (isBlankStr(urlStr)) {
        return @"";
    }
    NSString *encodedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodedString;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        if (object == _webPageV) {
            self.title = _webPageV.title;
        }else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"message=222=%@", message.name);
    NSArray * handleArr = @[@"dfiuvb01", @"dfiuvb02",@"dfiuvb03",@"dfiuvb04",@"dfiuvb05",@"dfiuvb06",@"dfiuvb07"];

    if ([handleArr containsObject:message.name]) {
        JS.respondsWebView = _webPageV;
        NSLog(@"message==%@", message.name);
        [JS receiveScriptMessage:message];
        kWeakself;
        JS.gobackCallBck = ^{
            [weakSelf goBackBtnClick:nil];
        };
    }
}

@end
