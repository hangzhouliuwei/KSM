//
//  PesoOrderModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoOrderModel.h"
@implementation PesoOrderListModel
@end
@implementation PesoOrderModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"xaththirteenosisNc":[PesoOrderListModel class]};
}
@end
