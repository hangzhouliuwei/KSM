//
//  PesoBankViewModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoBankViewModel : NSObject
/**银行卡初始化接口*/
- (void)loadGetBankRequest:(NSString *)product_id  callback:(void(^)(id model))callback;;
/**保存银行卡信息*/
- (void)loadSaveBankInfoRequest:(NSDictionary *)dic productId:(NSString *)product_id  callback:(void(^)(id model))callback;;
@end

NS_ASSUME_NONNULL_END
