//
//  BagLoginGetSMSCodeService.m
//  NewBag
//
//  Created by Jacky on 2024/3/21.
//

#import "BagLoginGetSMSCodeService.h"

@implementation BagLoginGetSMSCodeService
{
    NSString *_phone;
}
- (instancetype)initWithPhone:(NSString *)phone{
    if (self = [super init]) {
        _phone = phone;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"fourteencp/get_code";
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
   
    return @{@"chrefourteenographyNc":_phone,
             @"betyfourteenNc":@"juyttrr"};
}
@end
