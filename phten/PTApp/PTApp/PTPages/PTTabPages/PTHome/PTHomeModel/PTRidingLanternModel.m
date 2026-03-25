//
//  PTRidingLanternModel.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import "PTRidingLanternModel.h"

@implementation PTRidingLanternItemModel

@end

@implementation PTRidingLanternModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"gutengoyleNc" : [PTRidingLanternItemModel class],
            };
}
@end
