//
//  XTLoginViewModel.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTLoginViewModel.h"
#import "XTPhoneCodeApi.h"
#import "XTLoginApi.h"

@implementation XTLoginViewModel

- (instancetype)init {
    self = [super init];
    if(self) {
    }
    return self;
}


- (void)getLogin:(NSDictionary *)dic success:(XTBlock)success failure:(XTBlock)failure {
    XTLoginApi *codeApi = [[XTLoginApi alloc] initDic:dic];
    [codeApi xt_startRequestSuccess:^(NSDictionary *result,NSString *msg) {
        [XTUtility xt_showTips:msg view:nil];
        if([result isKindOfClass:[NSDictionary class]] && [result[@"gugosixyleNc"] isKindOfClass:[NSDictionary class]]){
            NSDictionary *userDic = result[@"gugosixyleNc"];
            [XTUserManger xt_share].xt_user = [XTUserModel yy_modelWithDictionary:userDic];
            [[XTUserManger xt_share] xt_saveUserDic:userDic];
            if(success){
                success();
            }
            return;
        }
        if(failure) {
            failure();
        }
    } failure:^(NSDictionary *dic, NSString *str) {
        [XTUtility xt_showTips:str view:nil];
        if(failure) {
            failure();
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
}

@end
