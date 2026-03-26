//
//  XTUserManger.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTUserManger.h"

#define XT_UserPath [NSString stringWithFormat:@"%@/XT_USER",XT_DocumentPath]

@implementation XTUserManger


+ (instancetype)xt_share {
    static XTUserManger* shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

+ (BOOL)xt_isLogin{
    if(
       [[XTUserManger xt_share].xt_user.xt_userId isKindOfClass:[NSString class]] &&
       [[XTUserManger xt_share].xt_user.xt_userSessionid isKindOfClass:[NSString class]] &&
       [XTUserManger xt_share].xt_user.xt_userId.length > 0 &&
        [XTUserManger xt_share].xt_user.xt_userSessionid.length > 0
       ){
           return YES;
       }
    return NO;
}


/**
 *  Custom 保存登录后的数据
 *
 *  @param dic         登录信息
 *
 */
- (void)xt_saveUserDic:(NSDictionary *)dic {
    if(!dic && dic.allKeys > 0){
        return;
    }
    NSFileManager *file = [NSFileManager defaultManager];
    ///是否存在
    if ([file fileExistsAtPath:XT_UserPath]){
        NSError *error;
        [file removeItemAtPath:XT_UserPath error:&error];
        if(error){
            XTLog(@"删除文件失败:%@",error);
        }
    }
    [dic writeToFile:XT_UserPath atomically:YES];
}

- (XTUserModel *)xt_user{
    if(!_xt_user){
        NSFileManager *file = [NSFileManager defaultManager];
        if ([file fileExistsAtPath:XT_UserPath]){
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:XT_UserPath];
            _xt_user = [XTUserModel yy_modelWithDictionary:dic];
        }
    }
    return _xt_user;
}

//退出登录
-(void)xt_loginOut {
    [[XTUtility xt_share] xt_removeFileWithPath:XT_UserPath];
    self.xt_user = nil;
    [XT_AppDelegate xt_loginView];
}

@end
