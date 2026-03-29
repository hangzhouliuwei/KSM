//
//  JumpMamager.m
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import "JumpMamager.h"

@interface JumpMamager ()
@property (nonatomic, copy) NSString *pid;
@end

@implementation JumpMamager

SingletonM(JumpMamager)


- (void)ppTextjumpToWithProdutId:(NSString *)produtId {
    if (produtId.length == 0) {
        return;
    }
    self.pid = produtId;
    NSDictionary *dic = @{
        p_product_id: notNull(self.pid),
        @"rsmsamCiopjko":@"cakestand"
    };
    kWeakself;
    [Http post:R_productCheck params:dic success:^(Response *response) {
        if (response.success) {
            NSString *url = response.dataDic[@"rseltCiopjko"];
            NSInteger style = [response.dataDic[@"rsuspsCiopjko"] intValue];
            [self jumpWithUrl:url];
            if (style == 0){
                [Track uploadDevice:^(BOOL value) {
                }];
            }
        }
    } failure:^(NSError *error) {
    } showLoading:YES];
}


- (void)jumpWithUrl:(NSString *)url {
    if ([url containsString:@"http"]) {
        [Page pushToRootTabViewController:@"PPWKWebViewControllerPage" param:@{@"url":url, @"naviBarHidden":@(NO), @"title":@""}];
        return;
    }
    
    NSDictionary *dic = @{
        p_product_id: notNull(self.pid),
    };
    kWeakself;
    [Http post:R_productDetail params:dic success:^(Response *response) {
        if (response.success) {
            [weakSelf jumpTo:response.dataDic];
        }
    } failure:^(NSError *error) {
    } showLoading:YES];
}

- (void)jump:(NSString *)url {
    if (url.length == 0) {
        return;
    }
    if ([url containsString:@"http"]) {
        NSString *urlStr = StrFormat(@"%@", url);
        [Page pushToRootTabViewController:@"PPWKWebViewControllerPage" param:@{@"url":urlStr, @"naviBarHidden":@(NO), @"title":@""}];
    }else if ([url containsString:@"eagleJump"]) {
        if ([url containsString:@"PLQQQQ"]) {
            [Page pushToRootTabViewController:@"PPNormalCardOrderPage" param:@{@"selectTabIndex":@(0), @"orderType":@"6"}];
        }else if ([url containsString:@"PLEEEE"]) {
            [User login];
        }else if ([url containsString:@"PLWWWW"]) {
            [Page pushToRootTabViewController:@"SettingPPNormalCardPage"];
        }else if ([url containsString:@"PLGGGG"]) {
            [Page popToRootTabViewController];
        }else if ([url containsString:@"PLAAAA"]) {
            [Page popToRootTabViewController];
            [Page switchTab:1];
        }
    }
}

- (void)jumpTo:(NSDictionary *)dic {
    NSString *orderNo = dic[p_productDetail][p_orderNo];
    NSDictionary *parm = @{@"productId":notNull(_pid), @"orderNo":notNull(orderNo)};
    NSDictionary *next = dic[p_nextStep];
    if (next) {
        NSString *nextItem = next[p_step];
        [self jumpNextPage:nextItem parm:parm];
    }else {
        NSString *url = dic[p_url];
        [self jump:url];
    }
}

- (void)jumpNextPage:(NSString *)nextItem parm:(NSDictionary *)parm {
    if ([nextItem containsString:@"http://"] || [nextItem containsString:@"https://"]) {
        [Page popToRootTabViewControllerAnimated:NO];
        NSString *urlStr = StrFormat(@"%@", nextItem);
        [Page pushToRootTabViewController:@"PPWKWebViewControllerPage" param:@{@"url":urlStr, @"naviBarHidden":@(NO), @"title":@""}];
        return;
    }
    if ([nextItem isEqualToString:@"Basic"]) {
        [Page pushToRootTabViewController:@"InformationPagePPNormalCard" param:parm];
    }else if ([nextItem isEqualToString:@"Contact"]) {
        [Page pushToRootTabViewController:@"LinkmanPagePPNormalCard" param:parm];
    }else if ([nextItem isEqualToString:@"Identification"]) {
        [Page pushToRootTabViewController:@"PPUserDefaultViewIdCardPage" param:parm];
    }else if ([nextItem isEqualToString:@"Facial Recognition"]) {
        [Page pushToRootTabViewController:@"FacePageUserDefaultView" param:parm];
    }else if ([nextItem isEqualToString:@"Withdrawal account"]) {
        [Page pushToRootTabViewController:@"BankPagePPToProcessVC" param:parm];
    }
}

@end

