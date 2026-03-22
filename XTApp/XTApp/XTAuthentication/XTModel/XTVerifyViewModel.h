//
//  XTVerifyViewModel.h
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTVerifyBaseModel;
@class XTVerifyContactModel;
@class XTOcrModel;
@class XTFaceModel;
@class XTBankModel;

@interface XTVerifyViewModel : NSObject

@property(nonatomic,strong) NSArray *list;
@property(nonatomic,strong) XTVerifyBaseModel *baseModel;
@property(nonatomic,strong) XTVerifyContactModel *contactModel;
@property(nonatomic,strong) XTOcrModel *ocrModel;
@property(nonatomic,strong) XTFaceModel *faceModel;
@property(nonatomic,strong) XTBankModel *bankModel;

-(void)xt_detail:(NSString *)productId success:(void (^)(NSString *code,NSString *orderId))success failure:(XTBlock)failure;

- (void)xt_person:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure;

- (void)xt_person_next:(NSDictionary *)parameter success:(XTStrBlock)success failure:(XTBlock)failure;

-(void)xt_push:(NSString *)orderId success:(XTStrBlock)success failure:(XTBlock)failure;

- (void)xt_contact:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure;

- (void)xt_contact_next:(NSDictionary *)parameter success:(XTStrBlock)success failure:(XTBlock)failure;

- (void)xt_photo:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure;

- (void)xt_upload_ocr_image:(NSString *)path typeId:(NSString *)typeId success:(XTBlock)success failure:(XTBlock)failure;

- (void)xt_photo_next:(NSDictionary *)parameter success:(XTStrBlock)success failure:(XTBlock)failure;

- (void)xt_auth:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure;

- (void)xt_limit:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure;

- (void)xt_licenseSuccess:(XTStrBlock)success failure:(XTBlock)failure;

- (void)xt_auth_err:(NSString *)str;

- (void)xt_detectionProductId:(NSString *)productId livenessId:(NSString *)livenessId success:(XTStrBlock)success failure:(XTBlock)failure;

- (void)xt_save_auth:(NSDictionary *)parameter success:(XTStrBlock)success failure:(XTBlock)failure;

- (void)xt_card:(NSString *)productId success:(XTBlock)success failure:(XTBlock)failure;

- (void)xt_card_next:(NSDictionary *)parameter success:(XTStrBlock)success failure:(XTBlock)failure;

@end

NS_ASSUME_NONNULL_END
