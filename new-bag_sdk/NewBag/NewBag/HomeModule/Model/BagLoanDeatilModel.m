//
//  BagLoanDeatilModel.m
//  NewBag
//
//  Created by Jacky on 2024/4/5.
//

#import "BagLoanDeatilModel.h"

@implementation BagProductDetailModel

@end
@implementation BagVerifyItemModel

@end
@implementation BagNextStepModel

@end

@implementation BagLoanDeatilModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"sportyF":[BagVerifyItemModel class],
            };
}
@end
