//
//  XTFirstViewModel.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTFirstViewModel.h"
#import "XTFirstApi.h"
#import "XTIndexModel.h"
#import "XTApplyApi.h"
#import "XTDetailApi.h"
#import "XTPushApi.h"
#import "XTPopUpApi.h"

@implementation XTFirstViewModel

- (void)getFirstSuccess:(XTBlock)success failure:(XTBlock)failure {
    XTFirstApi *firstApi = [[XTFirstApi alloc] init];
    @weakify(self)
    [firstApi xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        self.indexModel = [XTIndexModel yy_modelWithDictionary:dic];
        if(success){
            success();
        }
    } failure:^(NSDictionary *dic, NSString *str) {
        [XTUtility xt_showTips:str view:nil];
        if(failure){
            failure();
        }
    } error:^(NSError * _Nonnull error) {
        if(failure){
            failure();
        }
    }];
}

- (void)xt_popUpSuccess:(void (^)(NSString *imgUrl,NSString *url,NSString *buttonText))success failure:(XTBlock)failure {
    XTPopUpApi *api = [[XTPopUpApi alloc] init];
    @weakify(self)
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        if([dic isKindOfClass:[NSDictionary class]]){
            NSString *imgUrl = XT_Object_To_Stirng(dic[@"meulsixloblastomaNc"]);
            NSString *url = XT_Object_To_Stirng(dic[@"relosixomNc"]);
            NSString *buttonText = XT_Object_To_Stirng(dic[@"maansixNc"]);
            if(success) {
                success(imgUrl,url,buttonText);
            }
        }
        else {
            [XTUtility xt_showTips:str view:nil];
            if(failure){
                failure();
            }
        }
//        if(success){
//            success();
//        }
    } failure:^(NSDictionary *dic, NSString *str) {
        [XTUtility xt_showTips:str view:nil];
        if(failure){
            failure();
        }
    } error:^(NSError * _Nonnull error) {
        if(failure){
            failure();
        }
    }];
}

-(void)xt_apply:(NSString *)productId success:(void (^)(NSInteger uploadType,NSString *url,BOOL isList))success failure:(XTBlock)failure{
    XTApplyApi *api = [[XTApplyApi alloc] initProductId:productId];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]]) {
            ////0 不上报 1上报通讯录数据 2 上报设备数据和通讯录数据
            NSInteger uploadType  = [XT_Object_To_Stirng(dic[@"flcNsixc"]) integerValue];
            NSString *url  = XT_Object_To_Stirng(dic[@"relosixomNc"]);
            BOOL isList  = [XT_Object_To_Stirng(dic[@"detrsixogyrateNc"]) boolValue];
            if(success) {
                success(uploadType,url,isList);
            }
        }
        else {
            [XTUtility xt_showTips:str view:nil];
            if(failure){
                failure();
            }
        }
    } failure:^(NSDictionary *dic, NSString *str) {
        [XTUtility xt_showTips:str view:nil];
        if(failure){
            failure();
        }
    } error:^(NSError * _Nonnull error) {
        if(failure){
            failure();
        }
    }];
}

-(void)xt_detail:(NSString *)productId success:(void (^)(NSString *code,NSString *orderId))success failure:(XTBlock)failure {
    XTDetailApi *api = [[XTDetailApi alloc] initProductId:productId];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]] && [dic[@"leonsixishNc"] isKindOfClass:[NSDictionary class]]) {
            NSString *code;
            if([dic[@"heissixtopNc"] isKindOfClass:[NSDictionary class]]){
                code = XT_Object_To_Stirng(dic[@"heissixtopNc"][@"excuse"]);
            }
            NSString *orderId = XT_Object_To_Stirng(dic[@"leonsixishNc"][@"cokesixtNc"]);
            if(success) {
                success(code,orderId);
            }
        }
        else {
            [XTUtility xt_showTips:str view:nil];
            if(failure){
                failure();
            }
        }
    } failure:^(NSDictionary *dic, NSString *str) {
        [XTUtility xt_showTips:str view:nil];
        if(failure){
            failure();
        }
    } error:^(NSError * _Nonnull error) {
        if(failure){
            failure();
        }
    }];
}

-(void)xt_push:(NSString *)orderId success:(XTStrBlock)success failure:(XTBlock)failure {
    XTPushApi *api = [[XTPushApi alloc] initOrderId:orderId];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]]) {
            NSString *url = XT_Object_To_Stirng(dic[@"relosixomNc"]);
            if(success) {
                success(url);
            }
        }
        else {
            [XTUtility xt_showTips:str view:nil];
            if(failure){
                failure();
            }
        }
    } failure:^(NSDictionary *dic, NSString *str) {
        [XTUtility xt_showTips:str view:nil];
        if(failure){
            failure();
        }
    } error:^(NSError * _Nonnull error) {
        if(failure){
            failure();
        }
    }];
    
}

@end
