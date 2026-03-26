//
//  PesoDetailViewModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoDetailViewModel : NSObject
-(void)loadDetailData:(NSString*)retengnNc
               finish:(void (^)(id model))callback;
                              
- (void)loadOrderPushRequestWithOrderId:(NSString *)order_id product_id:(NSString *)product_id  finish:(void (^)(id model))callback;;
@end

NS_ASSUME_NONNULL_END
