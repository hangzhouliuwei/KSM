//
//  PUBBankModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import "PUBBankModel.h"

@implementation PUBBankMegrimEg

@end

@implementation PUBBankLysinEgModel


@end

@implementation PUBBankValuedEgModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"lysine_eg":[PUBBankLysinEgModel class],
            };
}

@end

@implementation PUBBankWiltEgModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"lysine_eg":[PUBBankLysinEgModel class],
            };
}


@end

@implementation PUBBankModel

@end
