//
//  PTUserManager.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/19.
//

#import "PTUserManager.h"

@implementation PTUserModel
@end

@interface PTUserManager()
@property(nonatomic, strong) PTUserModel *userModel;
@end

@implementation PTUserManager
+ (PTUserManager *)sharedUser
{
    static PTUserManager  *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[PTUserManager alloc]init];
        [sharedManager initUser];
    });
    return sharedManager;
}

- (void)initwithUserModelDic:(NSDictionary*)dic
{
    PTUserModel *userModel = [PTUserModel yy_modelWithDictionary:dic];
    [PTCache cacheYYObject:userModel withKey:KEY_LoginUser];
    [self initUser];
}


///缓存里获取用户信息
- (void)initUser
{
    if([PTCache getcacheYYObjectWithKey:KEY_LoginUser]){
        _userModel = [PTCache getcacheYYObjectWithKey:KEY_LoginUser];
        self.isOld = _userModel.phtensiographicalNc;
        self.smsMaxId  = _userModel.hetenerochromaticNc;
        self.uid = _userModel.batenmyNc;
        self.username = _userModel.sttenwardessNc;
        self.realname = _userModel.edtenNc;
        self.token = _userModel.tetentogenesisNc;
        self.sessionid = _userModel.fitenfootedNc;
        self.isaduit = _userModel.aotenNc;
        
     }
}

/// 判断是否登录
- (BOOL)isLogin
{
    return self.uid != 0 &&  self.sessionid && ![self.sessionid isEqualToString:@""];
}

///退出登录
- (void)logoutServer
{
    if ([PTCache getcacheYYObjectWithKey:KEY_LoginUser]) {
        PTUserModel *userModel =[PTCache getcacheYYObjectWithKey:KEY_LoginUser];
        userModel.phtensiographicalNc = 0;
        userModel.batenmyNc = @"";
        userModel.sttenwardessNc = @"";
        userModel.edtenNc = @"";
        userModel.tetentogenesisNc = @"";
        userModel.fitenfootedNc = @"";
        [PTCache cacheYYObject:userModel withKey:KEY_LoginUser];
        [self initUser];
    }
    
}

@end
