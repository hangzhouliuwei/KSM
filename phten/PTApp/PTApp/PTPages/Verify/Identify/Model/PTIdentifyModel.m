//
//  PTIdentifyModel.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTIdentifyModel.h"
#import "PTBasicVerifyModel.h"
@implementation PTIdentifyListModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"uptenornNc":@"rotenanizeNc",
             @"ittenlianizeNc":@"cetenNc"};
}

@end
@implementation PTIdentifyDetailModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"xatenthosisNc":[PTBasicRowModel class],
             @"tutenbodrillNc":[PTIdentifyListModel class],
            };
}

@end
@implementation PTIdentifyModel

@end
