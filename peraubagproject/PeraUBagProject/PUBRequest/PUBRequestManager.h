//
//  PUBRequestManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define HttPPUBRequest [PUBRequestManager sharedPUBRequestManager]
typedef void(^HttpSuccessBlock)(NSDictionary  *responseDataDic,PUBBaseResponseModel *model);
typedef void(^HttpFailureBlock)(NSError *error);
typedef void(^HttpDownloadProgressBlock)(CGFloat progress);
typedef void(^HttpUploadProgressBlock)(CGFloat progress);
typedef void(^HttpDomainSuccessBlock)(NSDictionary  *responseDataDic);

typedef NS_ENUM(NSInteger, NLNetworkPathType) {
    NLNetworkPathTypeRelease = 0,
    NLNetworkPathTypePre,
    NLNetworkPathTypeIp,
    NLNetworkPathTypeTestK8s,
    NLNetworkPathTypeTestFat,
    NLNetworkPathTypeTestUat
};

typedef NS_ENUM(NSInteger, NLNetworkStatus) {
    NLNetworkStatusUnNone = 0,
    NLNetworkStatusUnknown,
    NLNetworkStatusWAN,
    NLNetworkStatusWiFi
};


@interface PUBRequestManager : NSObject
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *h5Url;
@property (nonatomic, assign) NLNetworkPathType networkType;
@property (nonatomic, assign) NLNetworkStatus networkStatus;
SINGLETON_H(PUBRequestManager)

- (void)resetNetworkType;
/**
 get网络请求

 @param path url地址
 @param params url参数 NSDictionary类型
 @param success 请求成功 返回NSDictionary或NSArray
 @param failure 请求失败 返回NSError
 */
- (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

- (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure
        showLoading:(BOOL)loading;


/**
 post网络请求
 
 @param path url地址
 @param params url参数 NSDictionary类型
 @param success 请求成功 返回NSDictionary或NSArray
 @param failure 请求失败 返回NSError
 */
- (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;

- (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure
         showLoading:(BOOL)loading;

/**
 下载文件
 
 @param path url路径
 @param success 下载成功
 @param failure 下载失败
 @param progress 下载进度
 */
- (void)downloadWithPath:(NSString *)path
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpDownloadProgressBlock)progress;

/**
 上传图片
 
 @param path url地址
 @param image UIImage对象
 @param thumbName imagekey
 @param params 上传参数
 @param success 上传成功
 @param failure 上传失败
 @param progress 上传进度
 */
- (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)thumbName
                      image:(UIImage *)image
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress;

/**
 上传多张图片
 
 @param path url地址
 @param imageList UIImage对象
 @param thumbName imagekey
 @param params 上传参数
 @param success 上传成功
 @param failure 上传失败
 @param progress 上传进度
 */
- (void)uploadImagesWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)thumbName
                  imageList:(NSMutableArray *)imageList
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress;


- (void)getDomainNameWithUrl:(NSString *)url
                      params:(NSDictionary *)params
                     success:(HttpDomainSuccessBlock)success
                     failure:(HttpFailureBlock)failure
                  showLoading:(BOOL)loading;

/**
更新网络状态
*/
- (void)updateNetWorkStatus;


+ (NSString *)commonParameter;

@end

NS_ASSUME_NONNULL_END
