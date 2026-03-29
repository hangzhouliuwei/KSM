//
//  PPNetwork.h
// FIexiLend
//
//  Created by jacky on 2024/11/1.
//

#import <Foundation/Foundation.h>


#define PrivacyUrl                  @"/#/privacyAgreement"

@interface Response: UIButton
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *path;

- (id)initResult:(NSDictionary *)dic path:(NSString *)path;

@end

#define Http     [PPNetwork sharedPPNetwork]

typedef void(^SuccessBlock)(Response* response);
typedef void(^FailureBlock)(NSError *error);
typedef void(^UploadProgressBlock)(CGFloat progress);


typedef NS_ENUM(NSInteger, PPNetworkStatus) {
    PPNetworkNone = 0,
    PPNetworkUnknown,
    PPNetworkWAN,
    PPNetworkWiFi
};

@interface PPNetwork : UILabel

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *h5Url;
@property (nonatomic, assign) PPNetworkStatus networkStatus;
@property (nonatomic, copy) NSString *headerString;


SingletonH(PPNetwork)


- (void)get:(NSString *)path params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

- (void)get:(NSString *)path params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure showLoading:(BOOL)loading;


- (void)post:(NSString *)path params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

- (void)post:(NSString *)path params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure showLoading:(BOOL)loading;

- (void)upload:(NSString *)path params:(NSDictionary *)params thumbName:(NSString *)thumbName image:(UIImage *)image success:(SuccessBlock)success failure:(FailureBlock)failure;

- (void)ppRefreshNetworkStatus;
- (void)refreshHeader;
- (void)cleanHttpRequestSessionHeaders;

@end

