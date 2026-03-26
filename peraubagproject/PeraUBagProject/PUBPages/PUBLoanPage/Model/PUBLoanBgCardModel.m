//
//  PUBLoanBgCardModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/25.
//

#import "PUBLoanBgCardModel.h"

@implementation PUBLoanBgCardItemModel

//+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
//    return @{@"username":@"id"};
//}

@end
@implementation PUBLoanBgCardModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"obliterate_eg":[PUBLoanBgCardItemModel class]};
}

@end
