//
//  BagUserManager.m
//  NewBag
//
//  Created by Jacky on 2024/3/23.
//

#import "BagUserManager.h"
#import <YYCache/YYCache.h>
#import "BagRequestUrlArgumentsFilter.h"
@implementation BagUserModel


@end

@interface BagUserManager ()
@property (nonatomic, strong) YYCache *cache;

@end

@implementation BagUserManager
+ (instancetype)shareInstance{
    static BagUserManager  *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BagUserManager alloc]init];
        [sharedManager initUser];
    });
    return sharedManager;
}

- (void)initUser{
    if ([self.cache objectForKey:@"loginCache"]) {
        _model = (BagUserModel *)[self.cache objectForKey:@"loginCache"];
        _chromatogramF = _model.chromatogramF;
        _smsMaxId = _model.smsMaxId;
        _uid = _model.embarrassinglyF;
        _username = _model.giltheadF;
        _is_aduit = _model.helF;
        _token = _model.proctodaeumF;
        _sessionid = _model.musjidF;
        _is_aduit = _model.helF;
    }else{
        _model = [BagUserModel new];
    }
}
- (void)updateUserModelWithDic:(NSDictionary *)dic{
    BagUserModel *model = [BagUserModel yy_modelWithDictionary:dic];
    [self.cache setObject:model forKey:@"loginCache"];
    [self initUser];
    [self addRequestCommonParam];

}
- (BOOL)isLogin
{
    return self.uid != 0 && ![self.sessionid isEqualToString:@""]&& self.sessionid;
}
- (void)logout
{
    self.model = [BagUserModel new];

    self.chromatogramF = self.smsMaxId = self.uid = 0;
    self.username = self.token = self.sessionid = nil;
    self.isLogin = NO;
    [self.cache removeObjectForKey:@"loginCache"];
    //更新参数
    [self addRequestCommonParam];
}
#pragma mark - 设置默认参数
- (void)addRequestCommonParam{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    BagRequestUrlArgumentsFilter *newFilter = [BagRequestUrlArgumentsFilter filterWithArguments];
    //删除旧的
    [config clearUrlFilter];
    //设置新的
    [config addUrlFilter:newFilter];
}
#pragma mark - getter
- (YYCache *)cache
{
    if (!_cache) {
        _cache = [[YYCache alloc] initWithName:@"BgCache"];
    }
    return _cache;
}

@end
