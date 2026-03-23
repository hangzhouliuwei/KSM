//
//  Util.m
//  NewBag
//
//  Created by Jacky on 2024/3/24.
//

#import "Util.h"

@implementation Util
+ (BOOL)isValidString:(NSString *)str
{
    if (str == nil ||
        [str isEqual:[NSNull null]] ||
        [str isEqual:@"(null)"] ||
        [str isEqual:@"null"]) {
        return NO;
    }
    // 2. 判断是否是 非空白字符串
    if ([[str br_stringByTrim] length] == 0) {
        return NO;
    }
    return YES;
}
///获取设备相关信息
+(NSDictionary*)getNowDeviceInfo
{
    NSDictionary *byte_dic = @{
                                      @"thyF":NotNull([NSObject getAvailableDiskSize]),
                                      @"hammerlockF": NotNull([NSObject getTotalDiskSize]),
                                      @"bluestockingF": NotNull([NSObject getTotalMemorySize]),
                                      @"mercifullyF": NotNull([NSObject getAvailableMemorySize]),
                                      };
    NSDictionary *battery_statusDic = @{
                                      @"consonantalizeF":@([NSObject getBatteryQuantity]),
                                      @"battery_status":@([NSObject getBatteryStatus] ? 1 : 0),
                                      @"adjustiveF": @([NSObject getAlcidine] ? 1 : 0),
                                      };
    
        NSDictionary *hardwareDic = @{
                                      @"moscowF":NotNull([NSObject getIOSVersion]),
                                      @"orchidotomyF":@"iPhone",
                                      @"holohedralF": NotNull([NSObject getMobileStyle]),
                                      @"endowF":@([NSObject getScreenHeight]),
                                      @"frequentF":@([NSObject getScreenWidth]),
                                      @"nremF":NotNull([NSObject physicalDimensions]),
                                      @"genearchF":@([NSObject getAbsoluteTime])
                                      };
    
          NSDictionary *suk_egDic = @{
                                      @"smearF":@"0",
                                      @"splittismF":@([NSObject isSimulator] ? 1 : 0),
                                      @"hebraismF": @([NSObject isJailbroken] ? 1 : 0),
                                      };
      NSDictionary *magnesium_egDic = @{
                                        @"tangiersF":NotNull([NSObject timeZone]),
                                        @"technologistF":@([NSObject isUsingProxy] ? 1 : 0),
                                        @"snootF": @([NSObject getIsVPNOn] ? 1 : 0),
                                        @"talmiF":NotNull([NSObject getPhoneOperator]),
                                        @"errF": NotNull([NSObject getIDFV]),
                                        @"chaucerismF":NotNull([NSObject lanuage]),
                                        @"euterpeF":NotNull([NSObject getNetworkType]),
                                        @"macaqueF":@(1),
                                        @"wieldyF":NotNull([NSObject br_getIPAddress]),
                                       };
    NSMutableDictionary *magnesium_egMutalbeDic = [NSMutableDictionary dictionaryWithDictionary:magnesium_egDic];
    [NSObject getIdfa:^(NSString *idfa) {
        magnesium_egMutalbeDic[@"lintwhiteF"] = NotNull(idfa);
    }];
    
    NSDictionary *narcocatharsis_egDic = @{
                                            @"turbitF":NotNull([NSObject getBSSID]),
                                            @"kasoliteF":NotNull([NSObject getWifiName]),
                                            @"layelderF":NotNull([NSObject getBSSID]),
                                            @"antineoplastonF":NotNull([NSObject getWifiName]),
                                           };

    
    
    NSDictionary *chalky_egDic = @{@"miasmaF":@[narcocatharsis_egDic]};
    
    NSDictionary *dic = @{
                          @"lamebrainF": byte_dic,
                          @"battery_status":battery_statusDic,
                          @"hardware":hardwareDic,
                          @"cervicitisF":suk_egDic,
                          @"viroidF":magnesium_egMutalbeDic,
                          @"tookF":chalky_egDic,
                         };
    return dic;

}

@end
