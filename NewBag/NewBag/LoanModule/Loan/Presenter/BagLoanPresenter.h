//
//  BagLoanPresenter.h
//  NewBag
//
//  Created by Jacky on 2024/4/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class BagLoanDeatilModel;
@protocol BagLoanProtocol <BagBaseProtocol>
- (void)updateUIWithModel:(BagLoanDeatilModel *)model;
- (void)router:(NSString *)url;
@end
@interface BagLoanPresenter : NSObject
/**获取产品详情请求**/
- (void)sendGetProductDetailRequestWithProductId:(NSString *)product_id;
- (void)sendOrderPushRequestWithOrderId:(NSString *)order_id product_id:(NSString *)product_id;
@property (nonatomic, weak) id<BagLoanProtocol>delegate;
@end

NS_ASSUME_NONNULL_END
