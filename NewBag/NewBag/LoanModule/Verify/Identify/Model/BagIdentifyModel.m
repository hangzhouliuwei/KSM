//
//  BagIdentifyModel.m
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagIdentifyModel.h"
#import "BagVerifyBasicModel.h"
@implementation BagIdentifyListModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"antineoplastonF":@"monitorshipF",
             @"nortriptylineF":@"conniptionF"};
}

@end
@implementation BagIdentifyDetailModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"railageF":[BagBasicRowModel class],
             @"maquisF":[BagIdentifyListModel class],
            };
}

@end
@implementation BagIdentifyModel

@end
