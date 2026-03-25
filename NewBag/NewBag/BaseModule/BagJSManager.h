//
//  BagJSManager.h
//  NewBag
//
//  Created by Jacky on 2024/4/15.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagJSManager : NSObject
@property (nonatomic, copy) NSString *callbackId;
- (void)receiveScriptMessage:(WKScriptMessage *)message
                   CallBlock:(void(^)(NSString *))callBlock;

+(instancetype) sharedInstance;
@end

NS_ASSUME_NONNULL_END
