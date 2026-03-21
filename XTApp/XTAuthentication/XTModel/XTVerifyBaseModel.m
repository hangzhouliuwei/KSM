//
//  XTVerifyBaseModel.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTVerifyBaseModel.h"
#import "XTItemsModel.h"

@implementation XTVerifyBaseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"xt_countdown" : @"paeosixgrapherNc",
        @"items" : @"ovrfsixraughtNc",
    };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"items" : XTItemsModel.class,
    };
}


@end
