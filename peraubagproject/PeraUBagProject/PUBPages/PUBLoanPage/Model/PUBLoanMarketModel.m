//
//  PUBLoanMarketModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/25.
//

#import "PUBLoanMarketModel.h"

@implementation PUBLoanMarketItemModel


@end

@implementation PUBLoanMarketModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"obliterate_eg":[PUBLoanMarketItemModel class],
             @"sappy_eg":[NSString class],
            };
}


@end
