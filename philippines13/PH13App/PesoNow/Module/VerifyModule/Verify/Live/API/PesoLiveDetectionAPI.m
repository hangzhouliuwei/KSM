//
//  PesoLiveDetectionAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoLiveDetectionAPI.h"

@implementation PesoLiveDetectionAPI
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
    return @"thirteenca/detection";
}
- (BOOL)showLoading
{
    return YES;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
        @"lietthirteenusNc":(_product_id),
        @"gyosthirteeneNc":(_liveness_id)
    };
}
@end
