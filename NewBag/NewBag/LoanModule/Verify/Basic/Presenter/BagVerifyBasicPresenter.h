//
//  BagVerifyBasicPresenter.h
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import <Foundation/Foundation.h>
@class BagVerifyBasicModel;
NS_ASSUME_NONNULL_BEGIN
@protocol BagVerifyBasicProtocol <BagBaseProtocol>
- (void)updateUIWithModel:(BagVerifyBasicModel *)model;
- (void)jumpNextPageWithProductId:(NSString *)product_id nextUrl:(NSString *)url;
- (void)removeViewController;
- (void)saveBasicSucceed;
@end
@interface BagVerifyBasicPresenter : NSObject
@property (nonatomic, weak)id<BagVerifyBasicProtocol>delegate;
- (void)sendGetBasicRequestWithProduct_id:(NSString *)product_id;;
- (void)sendSaveBasicRequest:(NSDictionary *)data product_id:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
