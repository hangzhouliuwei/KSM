//
//  PUBUserManager.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/23.
//

#import "PUBUserManager.h"
#import <Bugly/Bugly.h>

@implementation PUBUserModel
@end

@interface PUBUserManager ()
@property (nonatomic, retain) PUBUserModel *userModel;
@end

static PUBUserManager *_sharedUser;
@implementation PUBUserManager

+ (PUBUserManager *)sharedUser
{
    @synchronized([self class])
    {
        if (!_sharedUser)
        {
            _sharedUser = [[[self class] alloc] init];
            [_sharedUser initUser];
        }
        return _sharedUser;
    }
    return nil;
}

- (void)initUser
{
    if([PUBCache getcacheYYObjectWithKey:LoginUser]){
        _userModel = [PUBCache getcacheYYObjectWithKey:LoginUser];
        self.isOld = _userModel.uniface_eg;
        self.smsMaxId  = _userModel.altruism_eg;
        self.uid = _userModel.sofa_eg;
        self.username = _userModel.electrologist_eg;
        self.realname = _userModel.clx_eg;
        self.token = _userModel.hairsbreadth_eg;
        self.sessionid = _userModel.quizzicality_eg;
        self.is_aduit = _userModel.chloe_eg;
    }
}

- (BOOL)isLogin
{
    
    return self.uid != 0 && ![self.sessionid isEqualToString:@""]&& self.sessionid;
}


- (void)logoutCallServer
{
    if ([PUBCache getcacheYYObjectWithKey:LoginUser]) {
        PUBUserModel *model =[PUBCache getcacheYYObjectWithKey:LoginUser];
        model.sofa_eg = 0;
        model.electrologist_eg = @"";
        model.clx_eg = @"";
        model.hairsbreadth_eg = @"";
        model.quizzicality_eg = @"";
        [PUBCache cacheYYObject:model withKey:LoginUser];
        [self initUser];
        [PUBTrackHandleManager trackUpDataAppUserId:[NSString stringWithFormat:@"%ld",User.uid]];
        [Bugly setUserIdentifier:User.username];
    }
}


@end
