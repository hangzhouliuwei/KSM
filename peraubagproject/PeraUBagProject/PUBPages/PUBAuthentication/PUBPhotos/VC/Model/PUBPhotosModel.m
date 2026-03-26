//
//  PUBPhotosModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/5.
//

#import "PUBPhotosModel.h"

@implementation PUBPhotosHorrificEgModel

@end


@implementation PUBPhotosDesideratumEgModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"horrific_eg":[PUBPhotosHorrificEgModel class],
             @"somesuch_eg":[PUBBasicSomesuchEgModel class],
            };
}

@end

@implementation PUBPhotosModel

@end
