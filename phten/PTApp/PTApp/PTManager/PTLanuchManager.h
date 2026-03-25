//
//  PTLanuchManager.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define PTLanuch [PTLanuchManager sharedPTLanuchManager]
@interface PTLanuchManager : NSObject
SINGLETON_H(PTLanuchManager)
- (void)startUpAppSDK;
- (void)startNetWork;
- (void)checkLogin;
@end

NS_ASSUME_NONNULL_END
