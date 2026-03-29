//
//  JSBridge.h
//  king
//
//  Created by jacky on 2023/9/4.
// 
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

#define JS    [JSBridge sharedJSBridge]

@interface JSBridge : UILabel

@property (nonatomic, strong) WKWebView *respondsWebView;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *callbackId;
@property(nonatomic, copy) CallBackNone gobackCallBck;

SingletonH(JSBridge)

- (void)receiveScriptMessage:(WKScriptMessage *)message;

@end

NS_ASSUME_NONNULL_END

