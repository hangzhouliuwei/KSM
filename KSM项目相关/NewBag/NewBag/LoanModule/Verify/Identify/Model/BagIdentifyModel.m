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
    return @{@"uporfourteennNc":@"roanfourteenizeNc",
             @"itlifourteenanizeNc":@"ceNcfourteen"};
}

@end
@implementation BagIdentifyDetailModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"xathfourteenosisNc":[BagBasicRowModel class],
             @"tubofourteendrillNc":[BagIdentifyListModel class],
            };
}

@end
@implementation BagIdentifyModel

@end
