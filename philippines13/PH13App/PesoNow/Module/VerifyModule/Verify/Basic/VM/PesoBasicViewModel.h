//
//  PesoBasicViewModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoBasicViewModel : NSObject
- (void)loadBasicRequestWithProduct_id:(NSString *)product_id callback:(void(^)(id model))callback;
- (void)loadSaveBasicRequest:(NSDictionary *)data product_id:(NSString *)product_id callback:(void(^)(NSString *url))callback;
@end

NS_ASSUME_NONNULL_END
