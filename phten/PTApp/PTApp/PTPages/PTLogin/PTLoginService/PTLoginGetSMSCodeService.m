//
//  PTLoginGetSMSCodeService.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/31.
//

#import "PTLoginGetSMSCodeService.h"

@implementation PTLoginGetSMSCodeService
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
    return PTGetLonginCode;
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
   
    return @{@"chtenreographyNc":_phoneNumber,
             @"betentyNc":@"juyttrr"};
}

@end
