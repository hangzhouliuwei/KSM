//
//  XTMyModel.m
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import "XTMyModel.h"
#import "XTExtendListModel.h"

@implementation XTMyModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"xt_memberUrl":@"deensixsiveNc",
        @"repayment":@"unqusixalizeNc",
        @"extendLists" : @"mehasixemoglobinNc",
    };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"extendLists" : XTExtendListModel.class,
    };
}

@end
