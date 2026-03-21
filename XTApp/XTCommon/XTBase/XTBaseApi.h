//
//  DCBaseApi.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTBaseApi : YTKRequest

/**
 网络请求

 @param success 网络请求成功回调
 @param failure 网络请求失败回调
 */
- (void)xt_startRequestSuccess:(nullable XTDicAndStrBlock)success
                       failure:(nullable XTDicAndStrBlock)failure
                         error:(void (^)(NSError *error))error;

- (NSString *)urlAppendQueryParameterToUrl:(NSString *)url;

+ (NSString *)urlAppendDicToUrl:(NSString *)url dic:(NSDictionary *)dic;

- (NSString *)webUrlAppendQueryParameterToUrl:(NSString *)url;
+ (NSString *)webUrlAppendDicToUrl:(NSString *)url dic:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END
