//
//  PUBJSManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/17.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN
#define JSManager    [PUBJSManager sharedPUBJSManager]
@interface PUBJSManager : NSObject
SINGLETON_H(PUBJSManager)
@property (nonatomic, strong) WKWebView *respondsWebView;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *callbackId;
- (void)receiveScriptMessage:(WKScriptMessage *)message
                   CallBlock:(ReturnStrBlock)callBlock;
- (void)acpaeetee:(id)dic;
@end

NS_ASSUME_NONNULL_END
