//
//  PTContactVerifyPresenter.h
//  PTApp
//
//  Created by Jacky on 2024/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PTContactVerifyProtocol <PTBaseProtocol>

- (void)saveContactSucceed;

@end
@interface PTContactVerifyPresenter : NSObject
@property (nonatomic, weak)id<PTContactVerifyProtocol>delegate;

- (void)sendGetContactRequest:(NSString *)product_id;
- (void)sendSaveContactRequest:(NSDictionary *)dic product_id:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
