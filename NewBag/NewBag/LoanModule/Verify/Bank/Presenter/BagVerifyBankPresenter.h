//
//  BagVerifyBankPresenter.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BagVerifyBankProtocol <BagBaseProtocol>
@optional
- (void)updateUIWithModel:(id)model;
- (void)removeViewController;
- (void)jumpNextPageWithProductId:(NSString *)product_id nextUrl:(NSString *)url;
- (void)saveBankSucceed;
@end

@interface BagVerifyBankPresenter : NSObject
@property (nonatomic, weak) id<BagVerifyBankProtocol>delegate;
/**银行卡初始化接口*/
- (void)sendGetBankRequestWithProductId:(NSString *)product_id;
/**保存银行卡信息*/
- (void)sendSaveContactRequestWithDic:(NSDictionary *)dic productId:(NSString *)product_id;;
@end

NS_ASSUME_NONNULL_END
