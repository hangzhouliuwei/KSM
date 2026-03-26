//
//  PTAuthentRouterManager.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import "PTAuthentRouterManager.h"
#import "PTHomeGceApplyService.h"
#import "PTDeviceService.h"
#import "PTWebViewController.h"

#import "PTAuthenticationController.h"
#import "PTBasicVerifyVC.h"
#import "PTHomeApplyModel.h"
#import "PTBasicVerifyVC.h"
#import "PTContactVerifyVC.h"
#import "PTIdentifyVerifyVC.h"
#import "PTLiveVerifyVC.h"
#import "PTBankVerifyVC.h"
@implementation PTAuthentRouterManager
SINGLETON_M(PTAuthentRouterManager);
/*
 tenJump://open/zzztten 基础认证
 tenJump://open/zzzsten 联系人
 tenJump://open/zzzrten 身份认证
 tenJump://open/zzzqten 活体
 zzzpten //银行卡
 */
- (void)routeWithUrl:(NSString*)url
{
    if ([url containsString:@"http://"] || [url containsString:@"https://"]) {
        PTWebViewController *web = [PTWebViewController new];
        web.url = url;
        [[PTTools findVisibleViewController].navigationController qmui_pushViewController:web animated:YES completion:nil];
    }else if ([url containsString:@"tenJump://"]) {
        NSArray *arr = @[@"zzzyten",@"zzzzten",@"zzzxten",@"zzzwten",@"zzzvten",@"zzztten",@"zzzsten",@"zzzrten",@"zzzqten",@"zzzpten"];
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
#pragma mark - 设置
- (void)zzzyten:(NSDictionary *)options{
//    BagMeSettingVC *set = [[BagMeSettingVC alloc] init];
//    [self pushToViewController:set];
}
#pragma mark - 详情
- (void)zzzvten:(NSDictionary *)options{

    PTAuthenticationController *vc = [PTAuthenticationController new];
    vc.retengnNc = [options[@"litenetusNc"] stringValue];
    [self pushToViewController:vc];
}
#pragma mark - 首页
- (void)zzzzten:(NSDictionary *)options
{
//    [self setSelectedIndex:0 viewController:nil];
    [[PTVCRouterManager sharedPTVCRouterManager] switchTabAtIndex:0];
}

#pragma mark - 登录页
- (void)zzzxten:(NSDictionary *)options
{
    [[PTVCRouterManager sharedPTVCRouterManager] jumpLoginWithSuccessBlock:^{
            
    }];
}

#pragma mark - 订单列表页
- (void)zzzwten:(NSDictionary *)options
{
//    BagOrderVC *order = [[BagOrderVC alloc] init];
//    NSInteger index = (NotNull([options[@"netentlesomeNc"] stringValue])).integerValue;
//    order.selectIndex = index;
//    [self setSelectedIndex:1 viewController:order];
}

#pragma mark - 认证
- (void)zzztten:(NSDictionary *)options{
    PTBasicVerifyVC *basicVC = [[PTBasicVerifyVC alloc] init];
    basicVC.productId =  PTNotNull([options[@"litenetusNc"] stringValue]);
    [self pushToViewController:basicVC];
}
- (void)zzzsten:(NSDictionary *)options{
    PTContactVerifyVC *contactVC = [[PTContactVerifyVC alloc] init];
    contactVC.productId =  PTNotNull([options[@"litenetusNc"] stringValue]);
    [self pushToViewController:contactVC];
}
- (void)zzzrten:(NSDictionary *)options{
    PTIdentifyVerifyVC *vc = [PTIdentifyVerifyVC new];
    vc.productId =  PTNotNull([options[@"litenetusNc"] stringValue]);
    [self pushToViewController:vc];
}
- (void)zzzqten:(NSDictionary *)options{
    PTLiveVerifyVC *liveVC = [[PTLiveVerifyVC alloc] init];
    liveVC.productId =  PTNotNull([options[@"litenetusNc"] stringValue]);
    [self pushToViewController:liveVC];
}
- (void)zzzpten:(NSDictionary *)options{
    PTBankVerifyVC *vc = [[PTBankVerifyVC alloc] init];
    vc.productId =  PTNotNull([options[@"litenetusNc"] stringValue]);
    [self pushToViewController:vc];
}

- (void)jumpLoanWithProId:(NSString *)product_id{
//    BagLoanVC *vc = [BagLoanVC new];
//    vc.productId = product_id;
//    [self pushToViewController:vc];
}


- (void)pushToViewController:(PTBaseVC *)vc{
    [[PTTools findVisibleViewController].navigationController qmui_pushViewController:vc animated:YES completion:nil];
}




-(void)applyNextRequestRetengnNc:(NSString*)retengnNc
{
    PTHomeGceApplyService *applyService = [[PTHomeGceApplyService alloc] initWithlitenetusNc:retengnNc];
    WEAKSELF
    [applyService startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        STRONGSELF
        if(request.response_code != 00){
            [PTTools showToast:PTNotNull(request.response_message)];
            return;
        }
        [strongSelf dataRetengnNcDic:request.response_dic retengnNc:retengnNc];
    } failure:^(__kindof PTBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark - 准入数据处理
-(void)dataRetengnNcDic:(NSDictionary*)dic retengnNc:(NSString*)retengnNc
{
    PTHomeApplyModel *model = [PTHomeApplyModel yy_modelWithDictionary:dic];
    if(model.fltencNc == 2){
        [self updataDaeaDevice];
    }
    if([model.retenloomNc containsString:@"http"]){
        PTWebViewController *webVC = [[PTWebViewController alloc] init];
        webVC.url = model.retenloomNc;
        [[PTTools findVisibleViewController].navigationController qmui_pushViewController:webVC animated:YES completion:nil];
        return;
    }
    
    PTBasicVerifyVC *vc = [[PTBasicVerifyVC alloc]init];
    vc.productId =  retengnNc;
    [[PTTools findVisibleViewController].navigationController qmui_pushViewController:vc animated:YES completion:nil];
    
    
//    PTAuthenticationController *authenticaVC = [[PTAuthenticationController alloc] init];
//    authenticaVC.retengnNc = retengnNc;
//    [[PTTools findVisibleViewController].navigationController qmui_pushViewController:authenticaVC animated:YES completion:nil];
    
//    if(model.detentrogyrateNc){
//        
//    }
    
}

///上报设备信息
-(void)updataDaeaDevice
{
    PTDeviceService *deviceService = [[PTDeviceService alloc] initWithData:[PTDeviceInfo getDevices]];
    [deviceService startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
    
    } failure:^(__kindof PTBaseRequest * _Nonnull request) {
        
    }];
}

@end
