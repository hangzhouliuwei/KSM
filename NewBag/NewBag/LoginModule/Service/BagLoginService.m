//
//  BagLoginService.m
//  NewBag
//
//  Created by Jacky on 2024/3/21.
//

#import "BagLoginService.h"

@implementation BagLoginService
{
    NSString *_phone;
    NSString *_code;
    NSDictionary *_point;

}
- (instancetype)initWithPhone:(NSString *)phone code:(NSString *)code point:(NSDictionary *)point{
    if (self = [super init]) {
        _phone = phone;
        _code = code;
        _point = point;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"fourteencp/login";
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
    return @{@"stwafourteenrdessNc":_phone,
             @"firofourteenticNc":_code,
             @"latefourteenscencyNc":@"duiuyiton",
             @"point":_point ? : @{}
    };
}
@end
