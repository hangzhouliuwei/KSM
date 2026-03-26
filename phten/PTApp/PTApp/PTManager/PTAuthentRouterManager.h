//
//  PTAuthentRouterManager.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




@interface PTAuthentRouterManager : NSObject
SINGLETON_H(PTAuthentRouterManager);


- (void)routeWithUrl:(NSString*)url;
/// 根据产品id跳转对应认证
/// - Parameter retengnNc: 产品id
-(void)applyNextRequestRetengnNc:(NSString*)retengnNc;
///上报设备信息
-(void)updataDaeaDevice;
@end

NS_ASSUME_NONNULL_END
