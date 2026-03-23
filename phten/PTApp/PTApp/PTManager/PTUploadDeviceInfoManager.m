//
//  PTUploadDeviceInfoManager.m
//  PTApp
//
//  Created by Jacky on 2024/8/25.
//

#import "PTUploadDeviceInfoManager.h"
#import "PTDeviceService.h"
@implementation PTUploadDeviceInfoManager
+ (PTUploadDeviceInfoManager *)sharedManager
{
    static PTUploadDeviceInfoManager  *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[PTUploadDeviceInfoManager alloc]init];
    });
    return sharedManager;
}

- (void)uploadDeviceInfo
{
    [self uploadDevice:0];
}
///上报设备信息
-(void)uploadDevice:(NSInteger)count
{
    if (count > 5) {
        return;
    }
    PTDeviceService *deviceService = [[PTDeviceService alloc] initWithData:[PTDeviceInfo getDevices]];
    [deviceService startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            
        }else{
            [self uploadDevice:count + 1];
        }
    } failure:^(__kindof PTBaseRequest * _Nonnull request) {
        [self uploadDevice:count + 1];
    }];
}
@end
