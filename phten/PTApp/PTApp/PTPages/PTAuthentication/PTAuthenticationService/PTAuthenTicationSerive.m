//
//  PTAuthenTicationSerive.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import "PTAuthenTicationSerive.h"

@implementation PTAuthenTicationSerive

{
    NSString *_litenetusNc;
}

-(instancetype)initWithlitenetusNc:(NSString*)litenetusNc
{
    self = [super init];
    if(self){
        _litenetusNc = litenetusNc ;
    }
    
    return self;
}

- (NSString *)requestUrl {
    return PTHomeDetail;
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
             @"litenetusNc":_litenetusNc,
            };
}

@end
