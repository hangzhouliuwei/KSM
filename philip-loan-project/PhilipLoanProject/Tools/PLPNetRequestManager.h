//
//  HttpManager.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/23.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLPNetRequestManager : NSObject

@property(nonatomic)AFHTTPSessionManager *netRequestmanager;

+(instancetype)plpJsonManager;

-(void)POSTURL:(NSString *)url paramsInfo:(id)params successBlk:(void (^)(id responseObject))success failureBlk:(void (^)(NSError *error))failure;
-(void)GETURL:(NSString *)url paramsInfo:(id)params successBlk:(void (^)(id responseObject))success failureBlk:(void (^)(NSError *error))failure;

-(void)UPLOADURL:(NSString *)url imageData:(UIImage *)image paramsInfo:(id)params successBlk:(void (^)(id responseObject))success failureBlk:(void (^)(NSError *error))failure;


-(NSString *)plp_generateParams;

@end

NS_ASSUME_NONNULL_END
