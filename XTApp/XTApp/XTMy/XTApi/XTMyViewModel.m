//
//  XTMyViewModel.m
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import "XTMyViewModel.h"
#import "XTHomeApi.h"
#import "XTMyModel.h"

@implementation XTMyViewModel

- (void)xt_home:(XTBlock)success failure:(XTBlock)failure {
    XTHomeApi *api = [[XTHomeApi alloc] init];
    @weakify(self)
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        self.myModel = [XTMyModel yy_modelWithDictionary:dic];
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

@end
