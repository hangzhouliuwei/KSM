//
//  XTFirstViewModel.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XTIndexModel;

@interface XTFirstViewModel : NSObject

@property(nonatomic,strong) XTIndexModel *indexModel;

- (void)getFirstSuccess:(XTBlock)success failure:(XTBlock)failure;

- (void)xt_popUpSuccess:(void (^)(NSString *imgUrl,NSString *url,NSString *buttonText))success failure:(XTBlock)failure;

-(void)xt_apply:(NSString *)productId success:(void (^)(NSInteger uploadType,NSString *url,BOOL isList))success failure:(XTBlock)failure;
-(void)xt_detail:(NSString *)productId success:(void (^)(NSString *code,NSString *orderId))success failure:(XTBlock)failure;
-(void)xt_push:(NSString *)orderId success:(XTStrBlock)success failure:(XTBlock)failure;

@end

NS_ASSUME_NONNULL_END
