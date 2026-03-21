//
//  Util.m
//  NewBag
//
//  Created by Jacky on 2024/3/24.
//

#import "Util.h"
#import <AFNetworking/AFNetworking.h>
@implementation Util

+ (UINib *)getNibFromeBundle:(NSString *)name
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"BagToolCategory" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];

    // 加载 nib 文件
    UINib *nib = [UINib nibWithNibName:name bundle:resourceBundle];
    return nib;
}
+ (id)getSourceFromeBundle:(NSString *)name
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"BagToolCategory" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];

    // 加载 nib 文件
    UINib *nib = [UINib nibWithNibName:name bundle:resourceBundle];
    NSArray *viewObjs = [nib instantiateWithOwner:nil options:nil];
    
    return viewObjs.lastObject;
}

+ (NSBundle *)getBundle{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"BagToolCategory" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    return resourceBundle;
}

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
                                      @"chysfourteenalidesNc":NotNull([NSObject getAvailableDiskSize]),
                                      @"ebdifourteencNc": NotNull([NSObject getTotalDiskSize]),
                                      @"sclifourteenmazelNc": NotNull([NSObject getTotalMemorySize]),
                                      @"hiacfourteenkNc": NotNull([NSObject getAvailableMemorySize]),
                                      };
    NSDictionary *battery_statusDic = @{
                                      @"delafourteensseNc":@([NSObject getBatteryQuantity]),
                                      @"battery_status":@([NSObject getBatteryStatus] ? 1 : 0),
                                      @"akavfourteenitNc": @([NSObject getAlcidine] ? 1 : 0),
                                      };
    
        NSDictionary *hardwareDic = @{
                                      @"xeotfourteenimeNc":NotNull([NSObject getIOSVersion]),
                                      @"prtufourteenbercularNc":@"iPhone",
                                      @"bauvfourteenrihiNc": NotNull([NSObject getMobileStyle]),
                                      @"pemefourteenanceNc":@([NSObject getScreenHeight]),
                                      @"sttufourteensNc":@([NSObject getScreenWidth]),
                                      @"soenfourteenoidNc":NotNull([NSObject physicalDimensions]),
                                      @"terafourteenNc":@([NSObject getAbsoluteTime])
                                      };
    
          NSDictionary *suk_egDic = @{
                                      @"brezfourteeninessNc":@"0",
                                      @"deisfourteenableNc":@([NSObject isSimulator] ? 1 : 0),
                                      @"sinmfourteenanNc": @([NSObject isJailbroken] ? 1 : 0),
                                      };
      NSDictionary *magnesium_egDic = @{
                                        @"ovrefourteenxertNc":NotNull([NSObject timeZone]),
                                        @"pltifourteenniferousNc":@([NSObject isUsingProxy] ? 1 : 0),
                                        @"sumefourteenrgibleNc": @([NSObject getIsVPNOn] ? 1 : 0),
                                        @"consfourteenellorNc":NotNull([NSObject getPhoneOperator]),
                                        @"manifourteencideNc": NotNull([NSObject getIDFV]),
                                        @"tuedfourteenoNc":NotNull([NSObject lanuage]),
                                        @"leelfourteenlingNc":NotNull([NSObject getNetworkType]),
                                        @"bahlfourteenykNc":@(1),
                                        @"deodfourteenulateNc":NotNull([NSObject br_getIPAddress]),
                                       };
    NSMutableDictionary *magnesium_egMutalbeDic = [NSMutableDictionary dictionaryWithDictionary:magnesium_egDic];
    [NSObject getIdfa:^(NSString *idfa) {
        magnesium_egMutalbeDic[@"patufourteenrageNc"] = NotNull(idfa);
    }];
    
    NSDictionary *narcocatharsis_egDic = @{
                                            @"mitifourteenmeNc":NotNull([NSObject getBSSID]),
                                            @"frscfourteenatiNc":NotNull([NSObject getWifiName]),
                                            @"koobfourteenehNc":NotNull([NSObject getBSSID]),
                                            @"uporfourteennNc":NotNull([NSObject getWifiName]),
                                           };

    
    
    NSDictionary *chalky_egDic = @{@"parifourteencentricNc":@[narcocatharsis_egDic]};
    
    NSDictionary *dic = @{
                          @"zoaifourteensmNc": byte_dic,
                          @"battery_status":battery_statusDic,
                          @"hardware":hardwareDic,
                          @"watyfourteenNc":suk_egDic,
                          @"rencfourteenounterNc":magnesium_egMutalbeDic,
                          @"eatefourteenrnizeNc":chalky_egDic,
                         };
    return dic;

}

+(NSURL*)loadImageUrl:(NSString*)imageUrl
{
    
    return  [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",IMAGEBASEURL,imageUrl]];
}

//修改图片尺寸
+ (UIImage *)imageResize:(UIImage*)img ResizeTo:(CGSize)newSize {
    CGFloat scale = [[UIScreen mainScreen]scale];
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(void)startNetWorkMonitor
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"lw======1WIFI");
                [[NSNotificationCenter defaultCenter] postNotificationName:NetWorkMonitor object:nil];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"lw======1蜂窝数据");
                [[NSNotificationCenter defaultCenter] postNotificationName:NetWorkMonitor object:nil];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //weakSelf.nettype = @"Bad Network";
                NSLog(@"lw======1Bad Network");
                break;
            case AFNetworkReachabilityStatusUnknown:
                //weakSelf.nettype = @"Unknow Network";
                NSLog(@"lw======1Unknow Network");
                break;
            default:
                //NSLog(@"其他");
                NSLog(@"lw======1其他");
                break;
        }
    }];
    //开始监控
    [mgr startMonitoring];
    
}


@end
