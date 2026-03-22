//
//  XTVerifyContactModel.m
//  XTApp
//
//  Created by xia on 2024/9/9.
//

#import "XTVerifyContactModel.h"
#import "XTContactItemModel.h"

@implementation XTVerifyContactModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"xt_countdown" : @"paeosixgrapherNc",
        @"items" : @"ovrfsixraughtNc",
    };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"items" : XTContactItemModel.class,
    };
}

@end
