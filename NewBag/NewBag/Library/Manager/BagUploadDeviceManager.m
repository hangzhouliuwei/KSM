//
//  BagUploadDeviceManager.m
//  NewBag
//   上报设备信息
//  Created by 刘巍 on 2024/4/27.
//

#import "BagUploadDeviceManager.h"
#import "BagUploadDeviceService.h"

static NSInteger const kMaxRetryCount = 5;
@interface BagUploadDeviceManager ()

@end


@implementation BagUploadDeviceManager

+ (instancetype)shareInstance{
    static BagUploadDeviceManager  *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BagUploadDeviceManager alloc]init];
       
    });
    return sharedManager;
}

- (void)uploadDevice
{
    [self uploadDeviceWithRetryCount:0];
    
}

- (void)uploadDeviceWithRetryCount:(NSInteger)retryCount
{
    if (retryCount >= kMaxRetryCount) {
            return;
      }
    WEAKSELF
    [self uploadDeviceWithCompletion:^(BOOL success) {
        if(!success){
            [weakSelf uploadDeviceWithRetryCount:retryCount + 1];
        }

    }];
    
}


- (void)uploadDeviceWithCompletion:(void (^)(BOOL success))completion
{
        
       [BagTrackHandleManager trackAppEventName:@"af_cc_start_deviceInfo" withElementParam:@{}];
        BagUploadDeviceService *request = [[BagUploadDeviceService alloc] initWithData:[Util getNowDeviceInfo]];
        [request startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
            if (request.response_code == 0) {
                [BagTrackHandleManager trackAppEventName:@"af_cc_success_deviceInfo" withElementParam:@{}];
                if(completion){
                    completion(YES);
                }
            }else{
                [BagTrackHandleManager trackAppEventName:@"af_cc_err_deviceInfo" withElementParam:@{}];
                if(completion){
                    completion(NO);
                }
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [BagTrackHandleManager trackAppEventName:@"af_cc_err_deviceInfo" withElementParam:@{}];
            if(completion){
                completion(NO);
            }
        }];
}

@end
