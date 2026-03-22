//
//  XTVerifyViewModel.m
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import "XTVerifyViewModel.h"
#import "XTDetailApi.h"
#import "XTVerifyListModel.h"
#import "XTPersonApi.h"
#import "XTVerifyBaseModel.h"
#import "XTPersonNextApi.h"
#import "XTPushApi.h"
#import "XTContactApi.h"
#import "XTVerifyContactModel.h"
#import "XTContactNextApi.h"
#import "XTPhotoApi.h"
#import "XTOcrModel.h"
#import "XTUpApi.h"
#import "XTPhotoModel.h"
#import "XTListModel.h"
#import "XTPhotoNextApi.h"
#import "XTAuthApi.h"
#import "XTFaceModel.h"
#import "XTLimitApi.h"
#import "XTLicenseApi.h"
#import "XTAuthErrApi.h"
#import "XTDetectionApi.h"
#import "XTSaveAuthApi.h"
#import "XTCardApi.h"
#import "XTBankModel.h"
#import "XTCardNextApi.h"

@implementation XTVerifyViewModel

-(void)xt_detail:(NSString *)productId success:(void (^)(NSString *code,NSString *orderId))success failure:(XTBlock)failure {
    XTDetailApi *api = [[XTDetailApi alloc] initProductId:productId];
    @weakify(self)
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        if([dic isKindOfClass:[NSDictionary class]] && [dic[@"atessixiaNc"] isKindOfClass:[NSArray class]] && [dic[@"leonsixishNc"] isKindOfClass:[NSDictionary class]]) {
            self.list = [NSArray yy_modelArrayWithClass:XTVerifyListModel.class json:dic[@"atessixiaNc"]];
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

- (void)xt_person:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure {
    XTPersonApi *api = [[XTPersonApi alloc] initProductId:productId];
    @weakify(self)
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        self.baseModel = [XTVerifyBaseModel yy_modelWithDictionary:dic];
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

- (void)xt_person_next:(NSDictionary *)parameter success:(XTStrBlock)success failure:(XTBlock)failure {
    XTPersonNextApi *api = [[XTPersonNextApi alloc] initWithDic:parameter];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]] && [dic[@"deecsixtibleNc"] isKindOfClass:[NSDictionary class]]){
            NSString *code = XT_Object_To_Stirng(dic[@"deecsixtibleNc"][@"excuse"]);
            if(success) {
                success(code);
            }
        }
        else{
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

- (void)xt_contact:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure {
    XTContactApi *api = [[XTContactApi alloc] initProductId:productId];
    @weakify(self)
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        self.contactModel = [XTVerifyContactModel yy_modelWithDictionary:dic];
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

- (void)xt_contact_next:(NSDictionary *)parameter success:(XTStrBlock)success failure:(XTBlock)failure {
    XTContactNextApi *api = [[XTContactNextApi alloc] initWithDic:parameter];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]] && [dic[@"deecsixtibleNc"] isKindOfClass:[NSDictionary class]]){
            NSString *code = XT_Object_To_Stirng(dic[@"deecsixtibleNc"][@"excuse"]);
            if(success) {
                success(code);
            }
        }
        else{
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

- (void)xt_photo:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure {
    XTPhotoApi *api = [[XTPhotoApi alloc] initProductId:productId];
    @weakify(self)
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        self.ocrModel = [XTOcrModel yy_modelWithDictionary:dic];
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

- (void)xt_upload_ocr_image:(NSString *)path typeId:(NSString *)typeId success:(XTBlock)success failure:(XTBlock)failure {
    XTUpApi *api = [[XTUpApi alloc] initPath:path typeId:typeId];
    @weakify(self)
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        self.ocrModel.model.list = [NSArray yy_modelArrayWithClass:XTListModel.class json:dic[@"xathsixosisNc"]];
        self.ocrModel.model.xt_img = path;
        self.ocrModel.model.xt_relation_id = XT_Object_To_Stirng(dic[@"paalsixympicsNc"]);
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

- (void)xt_photo_next:(NSDictionary *)parameter success:(XTStrBlock)success failure:(XTBlock)failure {
    XTPhotoNextApi *api = [[XTPhotoNextApi alloc] initWithDic:parameter];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]] && [dic[@"deecsixtibleNc"] isKindOfClass:[NSDictionary class]]){
            NSString *code = XT_Object_To_Stirng(dic[@"deecsixtibleNc"][@"excuse"]);
            if(success) {
                success(code);
            }
        }
        else{
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

- (void)xt_auth:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure {
    XTAuthApi *api = [[XTAuthApi alloc] initProductId:productId];
    @weakify(self)
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        if([dic isKindOfClass:[NSDictionary class]] && [dic[@"prtosixzoalNc"] isKindOfClass:[NSDictionary class]]) {
            self.faceModel = [XTFaceModel yy_modelWithDictionary:dic[@"prtosixzoalNc"]];
            if(success){
                success();
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

- (void)xt_limit:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure {
    XTLimitApi *api = [[XTLimitApi alloc] initProductId:productId];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
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

- (void)xt_licenseSuccess:(XTStrBlock)success failure:(XTBlock)failure {
    XTLicenseApi *api = [[XTLicenseApi alloc] init];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]]) {
            if(success){
                NSString *license = XT_Object_To_Stirng(dic[@"tafysixNc"]);
                success(license);
            }
        }
        else{
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
- (void)xt_auth_err:(NSString *)str {
    XTAuthErrApi *api = [[XTAuthErrApi alloc] initWithErrorStr:str];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        
    } failure:^(NSDictionary *dic, NSString *str) {
        
    } error:^(NSError * _Nonnull error) {
       
    }];
}

- (void)xt_detectionProductId:(NSString *)productId livenessId:(NSString *)livenessId success:(XTStrBlock)success failure:(XTBlock)failure {
    XTDetectionApi *api = [[XTDetectionApi alloc] initWithProductId:productId livenessId:livenessId];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]]) {
            if(success){
                NSString *xt_relation_id = XT_Object_To_Stirng(dic[@"paalsixympicsNc"]);
                success(xt_relation_id);
            }
        }
        else{
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

- (void)xt_save_auth:(NSDictionary *)parameter success:(XTStrBlock)success failure:(XTBlock)failure {
    XTSaveAuthApi *api = [[XTSaveAuthApi alloc] initWithDic:parameter];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]] && [dic[@"deecsixtibleNc"] isKindOfClass:[NSDictionary class]]){
            NSString *code = XT_Object_To_Stirng(dic[@"deecsixtibleNc"][@"excuse"]);
            if(success) {
                success(code);
            }
        }
        else{
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

- (void)xt_card:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure {
    XTCardApi *api = [[XTCardApi alloc] initProductId:productId];
    @weakify(self)
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        if([dic isKindOfClass:[NSDictionary class]]) {
            self.bankModel = [XTBankModel yy_modelWithDictionary:dic];
            if(success){
                success();
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

- (void)xt_card_next:(NSDictionary *)parameter success:(XTStrBlock)success failure:(XTBlock)failure {
    XTCardNextApi *api = [[XTCardNextApi alloc] initWithDic:parameter];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        if([dic isKindOfClass:[NSDictionary class]] && [dic[@"deecsixtibleNc"] isKindOfClass:[NSDictionary class]]){
            NSString *code = XT_Object_To_Stirng(dic[@"deecsixtibleNc"][@"excuse"]);
            if(success) {
                success(code);
            }
        }
        else{
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
