//
//  BagTrackHandleManager.h
//  NewBag
//
//  Created by Jacky on 2024/4/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagTrackHandleManager : NSObject
/// 事件埋点埋点
/// @param eventName 事件名称
/// @param elementParam 埋点数据
+ (void)trackAppEventName:(NSString *)eventName
         withElementParam:(NSDictionary *)elementParam;

/// 更新用户登录信息
/// @param userId 用户Uid
+(void)trackUpDataAppUserId:(NSString*)userId;
@end

NS_ASSUME_NONNULL_END
