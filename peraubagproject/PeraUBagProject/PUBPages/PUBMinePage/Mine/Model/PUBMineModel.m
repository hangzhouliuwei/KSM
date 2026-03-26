//
//  PUBMineModel.m
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/15.
//

#import "PUBMineModel.h"

@implementation PUBMineListItemModel


@end
@implementation PUBMineOrderModel


@end

@implementation PUBMineModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cockateel_eg" : [PUBMineListItemModel class],
             @"owly_eg":[PUBMineOrderModel class]
            };
}
@end

