//
//  PesoAppLoad.h
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface PesoAppLoad : NSObject
singleton_interface(PesoAppLoad)
//初始化 sdk
- (void)initSDK;
//监听网络
- (void)startNetworkMonitoring;


@end

NS_ASSUME_NONNULL_END
