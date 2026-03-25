//
//  PUBProductDetailModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/29.
//

#import "PUBProductDetailModel.h"

@implementation PUBVerifyItemModel

@end

@implementation PUBHexobioseEgModel


@end

@implementation PUBNextStepModel

@end

@implementation PUBProductDetailModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"allochthonous_eg":[PUBVerifyItemModel class],
            };
}


@end
