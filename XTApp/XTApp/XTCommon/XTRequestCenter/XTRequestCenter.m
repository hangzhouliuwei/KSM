//
//  XTRequestCenter.m
//  XTApp
//
//  Created by xia on 2024/9/4.
//

#import "XTRequestCenter.h"
#import "XTMarketApi.h"
#import "XTLocationManger.h"
#import "XTLocationApi.h"
#import "XTDeviceApi.h"
#import "XTUpAdidApi.h"

@implementation XTRequestCenter

+(instancetype)xt_share {
    static XTRequestCenter* shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

-(void)xt_market:(NSString *)idfa {
    XTMarketApi *api = [[XTMarketApi alloc] initIdfa:idfa];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]]) {
            NSString *enarsixgingNc = XT_Object_To_Stirng(dic[@"knxisixuixbNc"]);
            if([enarsixgingNc isEqualToString:@"1"]) {
                
            }
        }
    } failure:^(NSDictionary *dic, NSString *str) {
        
    } error:^(NSError * _Nonnull error) {
        
    }];
}



-(void)xt_location:(XTBoolBlock)block {
    if(![[XTLocationManger xt_share] xt_startLocation]) {
        if(block) {
            block(NO);
        }
        return;
    }
    [XTLocationManger xt_share].LBSInfoBlock = ^(NSDictionary * _Nonnull infoDic, BOOL isSuccess) {
        if(isSuccess) {
            XTLocationApi *api = [[XTLocationApi alloc] initDic:@{
                @"meonsixymNc":XT_Object_To_Stirng(infoDic[XTProvince]),
                @"prgesixnitureNc":XT_Object_To_Stirng(infoDic[XTCountryCode]),
                @"emlusixmentNc":XT_Object_To_Stirng(infoDic[XTCountry]),
                @"meadsixaltonNc":XT_Object_To_Stirng(infoDic[XTStreet]),
                @"boomsixofoNc":XT_Object_To_Stirng(infoDic[XTLatitude]),
                @"unevsixoutNc":XT_Object_To_Stirng(infoDic[XTLongitude]),
                @"googsixenesisNc":XT_Object_To_Stirng(infoDic[XTCity]),
                @"amitsixiouslyNc":XT_Object_To_Stirng(infoDic[XTRegion]),
            }];
            [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
                if(block) {
                    block(YES);
                }
            } failure:^(NSDictionary *dic, NSString *str) {
                if(block) {
                    block(NO);
                }
            } error:^(NSError * _Nonnull error) {
                if(block) {
                    block(NO);
                }
            }];
        }
        else {
            if(block) {
                block(NO);
            }
        }
    };
}

-(void)xt_device {
    XTDeviceApi *api = [[XTDeviceApi alloc] init];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        
    } failure:^(NSDictionary *dic, NSString *str) {
        
    } error:^(NSError * _Nonnull error) {
        
    }];
}

@end
