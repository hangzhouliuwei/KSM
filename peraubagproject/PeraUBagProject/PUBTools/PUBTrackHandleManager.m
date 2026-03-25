//
//  PUBTrackHandleManager.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/18.
//

#import "PUBTrackHandleManager.h"
#import <AppsFlyerLib/AppsFlyerLib.h>

@implementation PUBTrackHandleManager

/// 事件埋点埋点
/// @param eventName 事件名称
/// @param elementParam 埋点数据
+ (void)trackAppEventName:(NSString *)eventName withElementParam:(NSDictionary *)elementParam
{
    if([PUBTools isBlankString:eventName] || [PUBTools isBlankObject:elementParam] || [PUBTools isBlankString:User.username]){ return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:elementParam];
    dic[@"userId"] = User.username;
    dic[@"time"] = [PUBTools getTime];
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
    
    [HttPPUBRequest postWithPath:testPoint5 params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull model) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
@end
