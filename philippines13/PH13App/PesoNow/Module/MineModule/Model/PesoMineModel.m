//
//  PesoMineModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoMineModel.h"
@implementation PesoMineRepayModel
@end
@implementation PesoMineItemModel
@end
@implementation PesoMineModel
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"getithirteencNc" : [PesoMineItemModel class],
            };
}
@end
