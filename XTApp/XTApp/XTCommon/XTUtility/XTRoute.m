//
//  XTRoute.m
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import "XTRoute.h"
#import "XTHtmlVC.h"
#import "XTVerifyListVC.h"
#import "XTVerifyBaseVC.h"
#import "XTVerifyContactVC.h"
#import "XTOCRVC.h"
#import "XTVerifyFaceVC.h"
#import "XTVerifyBankVC.h"

@implementation XTRoute

+(instancetype)xt_share {
    static XTRoute *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

-(void)goHtml:(NSString *)url
      success:(XTBoolBlock)success {
    if(![NSString xt_isValidateUrl:url]){
        if(success){
            success(NO);
        }
        return;
    }
    XTHtmlVC *htmlVC = [[XTHtmlVC alloc] initUrl:url];
    [[XTUtility xt_getCurrentVCInNav].navigationController pushViewController:htmlVC animated:YES];
    if(success){
        success(YES);
    }
}

-(void)goVerifyList:(NSString *)productId {
    XTVerifyListVC *vc = [[XTVerifyListVC alloc] initWithProductId:productId];
    [[XTUtility xt_getCurrentVCInNav].navigationController pushViewController:vc animated:YES];
}

-(void)goVerifyItem:(NSString *)code
          productId:(NSString *)productId
            orderId:(NSString *)orderId
            success:(XTBoolBlock)success {
    if([code isEqualToString:@"AASIXTENBO"]) {
        XTVerifyBaseVC *vc = [[XTVerifyBaseVC alloc] initWithProductId:productId orderId:orderId];
        [[XTUtility xt_getCurrentVCInNav].navigationController pushViewController:vc animated:YES];
        if(success){
            success(YES);
        }
    }
    else if([code isEqualToString:@"AASIXTENBC"]) {
        XTVerifyContactVC *vc = [[XTVerifyContactVC alloc] initWithProductId:productId orderId:orderId];
        [[XTUtility xt_getCurrentVCInNav].navigationController pushViewController:vc animated:YES];
        if(success){
            success(YES);
        }
    }
    else if([code isEqualToString:@"AASIXTENBD"]) {
        XTOCRVC *vc = [[XTOCRVC alloc] initWithProductId:productId orderId:orderId];
        [[XTUtility xt_getCurrentVCInNav].navigationController pushViewController:vc animated:YES];
        if(success){
            success(YES);
        }
    }
    else if([code isEqualToString:@"AASIXTENBP"]) {
        XTVerifyFaceVC *vc = [[XTVerifyFaceVC alloc] initWithProductId:productId orderId:orderId];
        [[XTUtility xt_getCurrentVCInNav].navigationController pushViewController:vc animated:YES];
        if(success){
            success(YES);
        }
    }
    else if([code isEqualToString:@"AASIXTENBE"]) {
        XTVerifyBankVC *vc = [[XTVerifyBankVC alloc] initWithProductId:productId orderId:orderId];
        [[XTUtility xt_getCurrentVCInNav].navigationController pushViewController:vc animated:YES];
        if(success){
            success(YES);
        }
    }
    else {
        if(success){
            success(NO);
        }
    }
}

@end
