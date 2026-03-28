//
//  BagVerifyContactPresenter.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BagVerifyContactProtocol <BagBaseProtocol>
@optional
- (void)updateUIWithModel:(id)model;
- (void)removeViewController;
- (void)jumpNextPageWithProductId:(NSString *)product_id nextUrl:(NSString *)url;
- (void)saveContactSucceed;
@end

@interface BagVerifyContactPresenter : NSObject

@property (nonatomic, weak) id<BagVerifyContactProtocol>delegate;

- (void)sendGetContactRequestWithProductId:(NSString *)product_id;
- (void)sendSaveContactRequestWithDic:(NSDictionary *)dic product_id:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
