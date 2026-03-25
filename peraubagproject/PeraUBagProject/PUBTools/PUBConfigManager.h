//
//  PUBConfigManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define Config    [PUBConfigManager sharedPUBConfigManager]
@interface PUBConfigManager : NSObject
SINGLETON_H(PUBConfigManager)
///订单ID
@property(nonatomic, copy) NSString *hypokinesis_eg;
@end

NS_ASSUME_NONNULL_END
