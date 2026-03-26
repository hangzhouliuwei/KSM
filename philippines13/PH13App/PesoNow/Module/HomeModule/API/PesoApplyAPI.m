//
//  PesoApplyAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoApplyAPI.h"

@implementation PesoApplyAPI
{
    NSString *_pdid;
}

-(instancetype)initWithProductId:(NSString*)pdid
{
    self = [super init];
    if(self){
        _pdid = pdid ;
    }
    
    return self;
}

- (NSString *)requestUrl {
    return @"thirteennv2/gce/apply";
}
- (BOOL)showLoading
{
    return YES;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
   
    return @{@"lietthirteenusNc":NotNil(_pdid),
             @"fuhathirteenmNc":@"cakestand"
            };
}

@end
