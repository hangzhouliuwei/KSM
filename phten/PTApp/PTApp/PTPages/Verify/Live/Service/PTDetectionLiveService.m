//
//  PTDetectionLiveService.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTDetectionLiveService.h"

@implementation PTDetectionLiveService
{
    NSString *_product_id;
    NSString *_liveness_id;
}
- (instancetype)initWithProductId:(NSString *)product_id liveness_id:(NSString *)liveness_id
{
    if (self = [super init]) {
        _product_id = product_id;
        _liveness_id = liveness_id;
    }
    return self;
}
- (NSString *)requestUrl {
    return PTDetectionLive;
}
- (BOOL)isShowLoading
{
    return YES;
}
- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
        @"litenetusNc":(_product_id),
        @"gytenoseNc":(_liveness_id)
    };
}
@end
