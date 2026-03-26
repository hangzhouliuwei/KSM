//
//  XTItemsModel.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTItemsModel.h"
#import "XTListModel.h"

@implementation XTItemsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"xt_title" : @"fldgsixeNc",
        @"xt_sub_title" : @"sub_title",
        @"xt_more" : @"more",
        @"list" : @"xathsixosisNc",
    };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"list" : XTListModel.class,
    };
}

@end
