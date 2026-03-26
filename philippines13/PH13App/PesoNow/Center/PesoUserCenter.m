//
//  PesoUserCenter.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoUserCenter.h"
@implementation PesoUserModel
@end

static NSString *cacheName = @"Ph13Cache";
static NSString *loginKey = @"login";

@interface PesoUserCenter ()
@property(nonatomic, strong) PesoUserModel *userModel;
@property (nonatomic, strong) YYCache *cache;
@end
@implementation PesoUserCenter
singleton_implementation(PesoUserCenter)

- (instancetype)init
{
    if (self = [super init]) {
        [self initUser];
    }
    return self;
}
- (void)initwithUserModelDic:(NSDictionary*)dic
{
    PesoUserModel *userModel = [PesoUserModel yy_modelWithDictionary:dic];
    [self.cache setObject:userModel forKey:loginKey];
    [self initUser];
}


///缓存里获取用户信息
- (void)initUser
{
    if([self.cache objectForKey:loginKey]){
        _userModel = (PesoUserModel *)[self.cache objectForKey:loginKey];
        self.isOld = _userModel.phsithirteenographicalNc;
        self.smsMaxId  = _userModel.heerthirteenochromaticNc;
        self.uid = _userModel.bamythirteenNc;
        self.username = _userModel.stwathirteenrdessNc;
        self.realname = _userModel.edNcthirteen;
        self.token = _userModel.tetothirteengenesisNc;
        self.sessionid = _userModel.fifothirteenotedNc;
        self.isaduit = _userModel.aoNcthirteen;
     }
}

/// 判断是否登录
- (BOOL)isLogin
{
    return br_isNotEmptyObject(self.uid) &&  br_isNotEmptyObject(self.sessionid);
}

///退出登录
- (void)logout
{
    if ([self.cache objectForKey:loginKey]) {
        PesoUserModel *userModel = (PesoUserModel *)[self.cache objectForKey:loginKey];

        userModel.phsithirteenographicalNc = 0;
        userModel.bamythirteenNc = @"";
        userModel.stwathirteenrdessNc = @"";
        userModel.edNcthirteen = @"";
        userModel.tetothirteengenesisNc = @"";
        userModel.fifothirteenotedNc = @"";
        [self.cache setObject:userModel forKey:loginKey];
        [self initUser];
    }
}
- (YYCache *)cache
{
    if (!_cache) {
        _cache = [[YYCache alloc] initWithName:cacheName];
    }
    return _cache;
}
@end
