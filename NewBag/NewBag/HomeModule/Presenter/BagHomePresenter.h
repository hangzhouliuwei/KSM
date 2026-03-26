//
//  BagHomePresenter.h
//  NewBag
//
//  Created by Jacky on 2024/3/26.
//

#import <Foundation/Foundation.h>
@class BagHomeModel,BagHomeCustomerModel,BagHomeApplyInfoModel,BagLoanDeatilModel,BagHomePopModel;
NS_ASSUME_NONNULL_BEGIN
@protocol BagHomePresenterProtocol <BagBaseProtocol>

@optional
- (void)reloadUIWithDataArray:(NSArray <BagHomeModel *>*)data customerModel:(BagHomeCustomerModel *)model;

- (void)getApplyRequestSucceed:(BagHomeApplyInfoModel *)model;

//回传产品详情 model
- (void)updateUIWithProductDetailModel:(BagLoanDeatilModel *)model;

- (void)updatePop:(BagHomePopModel *)model;
/**跳 web**/
- (void)jumpWeb:(NSString *)url;

/*跳详情*/
- (void)jumpLoanDetailWithProductId:(NSString *)product_id;

- (void)router:(NSString *)url;

@end
@interface BagHomePresenter : NSObject
@property (nonatomic, weak) id<BagHomePresenterProtocol>delegate;
/**首页请求**/
- (void)sendGetHomeRequest;
/**弹窗**/
- (void)sendGetHomePop;
/**点击申请请求**/
- (void)sendApplyRequestWithProductId:(NSString *)product_id;;
/**获取产品详情请求**/
- (void)sendGetProductDetailRequestWithProductId:(NSString *)product_id;
/**根据订单获取跳转地址**/
- (void)sendOrderPushRequestWithOrderId:(NSString *)order_id product_id:(NSString *)product_id;

@end

NS_ASSUME_NONNULL_END
