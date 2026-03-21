//
//  BagRootVCManager.h
//  NewBag
//
//  Created by 刘巍 on 2024/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagRootVCManager : NSObject

+ (instancetype)shareInstance;


- (void)setRootVC;

- (void)initNetworkConfig;


@end

NS_ASSUME_NONNULL_END
