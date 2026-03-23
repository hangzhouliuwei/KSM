//
//  PTOrderModel.m
//  PTApp
//
//  Created by Jacky on 2024/8/28.
//

#import "PTOrderModel.h"

@implementation PTOrderListModel



@end
@implementation PTOrderModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"xatenthosisNc":[PTOrderListModel class]};
}

@end
