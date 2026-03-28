//
//  BagMeModel.m
//  NewBag
//
//  Created by Jacky on 2024/3/29.
//

#import "BagMeModel.h"

@implementation BagMeRepayModel

@end
@implementation BagMeListItemModel
@end

@implementation BagMeModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
        @"antidiphtheriticF":[BagMeListItemModel class],
    };
}

@end
