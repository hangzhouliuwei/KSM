//
//  PesoOrderVM.h
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoOrderVM : NSObject
- (void)loadGetOrderRequestFirstPage:(BOOL)first tag:(NSInteger)tag success:(void (^)(id _Nonnull))success fail:(void (^)(void))fail;
@end

NS_ASSUME_NONNULL_END
