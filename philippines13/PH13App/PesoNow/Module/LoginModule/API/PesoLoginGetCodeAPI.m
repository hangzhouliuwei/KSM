//
//  PesoLoginGetCodeAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoLoginGetCodeAPI.h"

@implementation PesoLoginGetCodeAPI
{
    NSString *_phoneNumber;
}

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber
{
    self = [super init];
    if(self){
        _phoneNumber = phoneNumber;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"thirteencp/get_code";
}
- (BOOL)showLoading
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
   
    return @{@"chrethirteenographyNc":_phoneNumber,
             @"betythirteenNc":@"juyttrr"};
}

@end
