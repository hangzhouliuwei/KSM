//
//  PTBankPresenter.h
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PTBankProtocol <PTBaseProtocol>
@optional

- (void)saveBankSucceed;
@end
@interface PTBankPresenter : NSObject
@property (nonatomic, weak) id<PTBankProtocol>delegate;
/**银行卡初始化接口*/
- (void)pt_sendGetBankRequest:(NSString *)product_id;
/**保存银行卡信息*/
- (void)pt_sendSaveBankInfoRequest:(NSDictionary *)dic productId:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
