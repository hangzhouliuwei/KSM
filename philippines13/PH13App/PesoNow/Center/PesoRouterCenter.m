//
//  PesoRouterCenter.m
//  PesoApp
//
//  Created by Jacky on 2024/9/12.
//

#import "PesoRouterCenter.h"
#import "PesoWebVC.h"
#import "PesoBasicVerifyVC.h"
#import "PesoDetailVC.h"
#import "PesoContactVC.h"
#import "PesoIdentifyVC.h"
#import "PesoLiveVC.h"
#import "PesoBankVC.h"
@implementation PesoRouterCenter
singleton_implementation(PesoRouterCenter)
//zzthirteenzt -> basic
//zzthirteenzs -> contact
//zzthirteenzr -> identify
//zzthirteenzp ->bank
//zzthirteenzv 产品详情 （scheme + /zzthirteenzv?lietthirteenusNc=1）
//zzthirteenzy 设置
//zzthirteenzx 登录
//zzthirteenzz 首页
//zzthirteenzw 订单列表页 （scheme + /zzthirteenzw?netlthirteenesomeNc=1）
- (void)routeWithUrl:(NSString *)url
{
    if ([url containsString:@"http://"] || [url containsString:@"https://"]) {
        PesoWebVC *web = [PesoWebVC new];
        web.url = url;
//        [[PesoRootVCCenter sharedPesoRootVCCenter] pushToVC:web];
        [[PesoUtil findVisibleViewController].navigationController qmui_pushViewController:web animated:YES completion:nil];
    }else if ([url containsString:@"thirteenJump://"]) {
        NSArray *arr = @[@"zzthirteenzy",@"zzzzten",@"zzzxten",@"zzzwten",@"zzthirteenzv",@"zzthirteenzt",@"zzthirteenzs",@"zzthirteenzr",@"zzthirteenzq",@"zzthirteenzp"];
        for (NSString *str in arr) {
            if([url containsString:str]){
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                if([url containsString:@"?"]){
                    NSArray * arr1 = [url componentsSeparatedByString:@"?"];
                    if(arr1.count > 0){
                        NSString *str1 = arr1[1];
                        NSArray * arr2 = [str1 componentsSeparatedByString:@"="];
                        if(arr2.count>0){
                            NSString *idStr = [NSString stringWithFormat:@"%@", arr2[1]];
                            [dict setValue:@([idStr integerValue]) forKey:arr2[0]];
                        }
                    }
                    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:", str]);
                    if ([self respondsToSelector:selector]) {
                        [self performSelector:selector withObject:dict afterDelay:0];
                    }
                }else{
                    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:", str]);
                    if ([self respondsToSelector:selector]) {
                        [self performSelector:selector withObject:nil afterDelay:0];
                    }
                }
            }
        }
    }
}
//详情
- (void)zzthirteenzv:(NSDictionary *)options{
    PesoDetailVC *detail = [[PesoDetailVC alloc] init];
    detail.productId =  NotNil([options[@"lietthirteenusNc"] stringValue]);
    [self pushToViewController:detail];
}
  
#pragma mark - 认证
//basic
- (void)zzthirteenzt:(NSDictionary *)options{
//    PesoDetailVC *detail = [[PesoDetailVC alloc] init];
//    detail.productId =  NotNil([options[@"lietthirteenusNc"] stringValue]);
//    [self pushToViewController:detail];
//    return;
    PesoBasicVerifyVC *basicVC = [[PesoBasicVerifyVC alloc] init];
    basicVC.productId =  NotNil([options[@"lietthirteenusNc"] stringValue]);
    [self pushToViewController:basicVC];
}
- (void)zzthirteenzs:(NSDictionary *)options{
    PesoContactVC *detail = [[PesoContactVC alloc] init];
    detail.productId =  NotNil([options[@"lietthirteenusNc"] stringValue]);
    [self pushToViewController:detail];
    return;
}
- (void)zzthirteenzr:(NSDictionary *)options{
    PesoIdentifyVC *detail = [[PesoIdentifyVC alloc] init];
    detail.productId =  NotNil([options[@"lietthirteenusNc"] stringValue]);
    [self pushToViewController:detail];
    return;
}
- (void)zzthirteenzq:(NSDictionary *)options{
    PesoLiveVC *detail = [[PesoLiveVC alloc] init];
    detail.productId =  NotNil([options[@"lietthirteenusNc"] stringValue]);
    [self pushToViewController:detail];
    return;
}
- (void)zzthirteenzp:(NSDictionary *)options{
    
    PesoBankVC *detail = [[PesoBankVC alloc] init];
    detail.productId =  NotNil([options[@"lietthirteenusNc"] stringValue]);
    [self pushToViewController:detail];
    return;
}
- (void)pushToViewController:(PesoBaseVC *)vc{
    [[PesoUtil findVisibleViewController].navigationController qmui_pushViewController:vc animated:YES completion:nil];
}
@end
