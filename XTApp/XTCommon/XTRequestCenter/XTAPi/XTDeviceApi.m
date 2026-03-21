//
//  XTDeviceApi.m
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import "XTDeviceApi.h"

@implementation XTDeviceApi

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixcr/device"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return [XTDevice xt_share].xt_deviceInfoDic;
}

@end
