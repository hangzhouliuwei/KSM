//
//  DataManager.h
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define Track   [DataManager sharedDataManager]

@interface DataManager : UIView

SingletonH(DataManager)

- (void)trackScene:(NSDictionary *)dic;

- (void)getUserPhoneLocationAndUpload:(CallBackBool)success;
- (void)ppConfigReqUserLoction:(CallBackBool)success;
- (void)uploadDevice:(CallBackBool)success;

@end

NS_ASSUME_NONNULL_END
