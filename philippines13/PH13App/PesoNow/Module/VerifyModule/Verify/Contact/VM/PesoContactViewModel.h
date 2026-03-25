//
//  PesoContactViewModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoContactViewModel : NSObject
- (void)loadGetContactRequest:(NSString *)product_id callback:(void(^)(id model))callback;
- (void)loadSaveContactRequest:(NSString *)product_id dic:(NSDictionary *)dic  callback:(void (^)(id _Nonnull))callback;
@end

NS_ASSUME_NONNULL_END
