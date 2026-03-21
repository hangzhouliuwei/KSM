//
//  BagVerifyLiveDetectionService.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyLiveDetectionService.h"

@implementation BagVerifyLiveDetectionService
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
    return @"fourteenca/detection";
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
        @"lietfourteenusNc":NotNull(_product_id),
        @"gyosfourteeneNc":NotNull(_liveness_id)
    };
}
@end
