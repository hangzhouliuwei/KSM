//
//  PTAutheticationViewModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import "PTBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PTAuthenticationModel;

@protocol PTAuthDelegate <PTBaseProtocol>



@end
@interface PTAutheticationViewModel : PTBaseViewModel
@property (nonatomic, weak) id<PTAuthDelegate>delegate;
-(void)getAutheticationdeatalRetengnNc:(NSString*)retengnNc
                                finish:(void (^)(PTAuthenticationModel *model))successBlock
                              failture:(void (^)(void))failtureBlock;
- (void)pt_sendOrderPushRequestWithOrderId:(NSString *)order_id product_id:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
