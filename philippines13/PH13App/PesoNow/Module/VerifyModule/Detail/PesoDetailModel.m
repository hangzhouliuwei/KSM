//
//  PesoDetailModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/12.
//

#import "PesoDetailModel.h"
@implementation PesoVerifyListModel

@end
@implementation PesoVerifyNextModel

@end
@implementation PesoProductInfoModel

@end
@implementation PesoDetailModel
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"atesthirteeniaNc" : [PesoVerifyListModel class],
            };
}
@end
