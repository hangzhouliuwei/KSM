//
//  PTMineModel.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/12.
//

#import "PTMineModel.h"

@implementation PTMineItemModel


@end

@implementation PTMineModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"getenticNc" : [PTMineItemModel class],
            };
}

@end
