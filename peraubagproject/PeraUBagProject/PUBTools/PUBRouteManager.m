//
//  PUBRouteManager.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/29.
//

#import "PUBRouteManager.h"
#import "PUBBasicViewController.h"
#import "PUBContactController.h"
#import "PUBPhotosController.h"

#import "PUBLiveViewController.h"
#import "PUBBankViewController.h"

@implementation PUBRouteManager


+ (void)routeWithUrl:(NSString*)url; {
    if ([url containsString:@"http://"] || [url containsString:@"https://"]) {
        PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
        webVC.url = NotNull(url);
        [[VCManager topViewController].navigationController qmui_pushViewController:webVC animated:YES completion:nil];
       
    }else if ([url containsString:@"openapp://"]) {
        NSArray *arr = @[@"dnowof",@"cimvrfi",@"leset",@"wtyiourct",@"legesmw"];
        for (NSString *str in arr) {
            if([url containsString:str]){
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                if([url containsString:@"?"]){
                    NSArray * arr1 = [url componentsSeparatedByString:@"?"];
                    if(arr1.count > 0){
                        NSString *str1 = arr1[1];
                        NSArray * arr2 = [str1 componentsSeparatedByString:@"="];
                        if(arr2.count>0){
                            NSString *idStr = STR_FORMAT(@"%@", arr2[1]);
                            [dict setValue:@([idStr integerValue]) forKey:arr2[0]];
                        }
                    }
                    SEL selector = NSSelectorFromString(STR_FORMAT(@"%@:", str));
                    if ([self respondsToSelector:selector]) {
                        [self performSelector:selector withObject:dict afterDelay:0];
                    }
                }else{
                    SEL selector = NSSelectorFromString(STR_FORMAT(@"%@:", str));
                    if ([self respondsToSelector:selector]) {
                        [self performSelector:selector withObject:nil afterDelay:0];
                    }
                }

            }
        }
    }
}

#pragma mark - 设置页
+(void)dnowof:(NSDictionary *)options
{
    
}

#pragma mark - 首页
+ (void)cimvrfi:(NSDictionary *)options
{
    [VCManager switchTabAtIndex:0];
}

#pragma mark - 登录页
+ (void)leset:(NSDictionary *)options 
{
    [PUBTools checkLogin:^(NSInteger uid) {
        
    }];
}

#pragma mark - 订单列表页
+ (void)wtyiourct:(NSDictionary *)options
{
    
    [VCManager switchTabAtIndex:1];
//    if (options.count > 0) {
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:options];
//        [VCManager showViewControllerWithName:PBOrderListPage param:dic];
//    }
}

#pragma mark - 订单列表页
+ (void)legesmw:(NSDictionary *)options 
{
    
}


+ (void)routeWitheNextPage:(NSString*)nextPage productId:(NSString*)productId
{
    
    if ([nextPage containsString:@"http://"] || [nextPage containsString:@"https://"]) {
        PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
        webVC.url = NotNull(nextPage);
        [VCManager.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
        return;
    }
    if([nextPage isEqualToString:@"AAAA"]){//基础认证
        
        PUBBasicViewController *basicVC = [[PUBBasicViewController alloc] init];
        basicVC.productId =  NotNull(productId);
        [VCManager.navigationController qmui_pushViewController:basicVC animated:YES completion:nil];
        
    }else if ([nextPage isEqualToString:@"IIII"]){//紧急联系人
        
        PUBContactController *contactVC = [[PUBContactController alloc] init];
        contactVC.productId = NotNull(productId);
        [VCManager.navigationController qmui_pushViewController:contactVC animated:YES completion:nil];
        
    }else if ([nextPage isEqualToString:@"JJJJ"]){//身份
        
        PUBPhotosController *photosVC = [[PUBPhotosController alloc] init];
        photosVC.productId = NotNull(productId);
        [VCManager.navigationController qmui_pushViewController:photosVC animated:YES completion:nil];
        
    }else if ([nextPage isEqualToString:@"BBBB"]){//人脸
        
        PUBLiveViewController *liveVC = [[PUBLiveViewController alloc] init];
        liveVC.productId = NotNull(productId);
        [VCManager.navigationController qmui_pushViewController:liveVC animated:YES completion:nil];
        
    }else if ([nextPage isEqualToString:@"KKKK"]){//银行卡
        
        PUBBankViewController *bankVC = [[PUBBankViewController alloc] init];
        bankVC.productId = NotNull(productId);
        [VCManager.navigationController qmui_pushViewController:bankVC animated:YES completion:nil];
        
    }
    
}


@end
