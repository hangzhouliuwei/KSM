//
//  PTHomeRepayModel.m
//  PTApp
//
//  Created by Jacky on 2024/9/2.
//

#import "PTHomeRepayModel.h"

@implementation PTHomeRepayRealModel
- (NSInteger)cellHigh
{
    return 128.f;
}
- (NSInteger)level{
    return  5.f;
}
@end
@implementation PTHomeRepayModel
- (NSInteger)cellHigh
{
    return 128.f;
}
- (NSInteger)level{
    return  5.f;
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"gutengoyleNc" : [PTHomeRepayRealModel class],
            };
}
@end
