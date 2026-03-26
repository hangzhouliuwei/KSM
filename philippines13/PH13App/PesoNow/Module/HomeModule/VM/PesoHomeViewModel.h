//
//  PesoHomeViewModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import <Foundation/Foundation.h>
#import "PesoHomeBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PesoHomeViewModel : NSObject
- (void)loadHomeData:(void(^)(id model))callback;
- (void)loadApplyRequest:(NSString *)product_id callback:(void(^)(id model))callback;
- (void)loadProductDetailRequest:(NSString *)product_id callback:(void(^)(id model))callback;;
- (void)loadPushRequestWithOrderId:(NSString *)order_id product_id:(NSString *)product_id callback:(void (^)(id _Nonnull))callback;
- (void)loadHomePopData:(void(^)(id model))callback;
@end

NS_ASSUME_NONNULL_END
