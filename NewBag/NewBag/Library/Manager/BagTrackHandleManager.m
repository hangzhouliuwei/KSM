//
//  BagTrackHandleManager.m
//  NewBag
//
//  Created by Jacky on 2024/4/12.
//

#import "BagTrackHandleManager.h"
#import <AppsFlyerLib/AppsFlyerLib.h>
#import "BagTestPointService.h"
@implementation BagTrackHandleManager
// 事件埋点埋点
/// @param eventName 事件名称
/// @param elementParam 埋点数据
+ (void)trackAppEventName:(NSString *)eventName withElementParam:(NSDictionary *)elementParam
{
    if([NotNull(eventName) br_isBlankString] || !elementParam || [NotNull(BagUserManager.shareInstance.username) br_isBlankString]){ return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:elementParam];
    dic[@"userId"] = BagUserManager.shareInstance.username;
    dic[@"eventName"] = eventName;
    dic[@"time"] = [NSDate br_timestamp];
    [[AppsFlyerLib shared] logEventWithEventName:eventName eventValues:dic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
        
    }];
    
    #ifdef DEBUG
    dic[@"eventName"]=eventName;
    [self updaTatrackEventDic:dic];
    #else
    #endif
}

/// 更新用户登录信息
/// @param userId 用户Uid
+(void)trackUpDataAppUserId:(NSString*)userId
{
    [AppsFlyerLib shared].customerUserID = userId;
}

//上报埋点数据方便测试查看
+(void)updaTatrackEventDic:(NSDictionary*)dic
{
    
    BagTestPointService *service = [[BagTestPointService alloc] initWithData:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}
@end
