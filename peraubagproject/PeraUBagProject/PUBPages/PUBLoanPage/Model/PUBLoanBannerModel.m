//
//  PUBLoanBannerModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/23.
//

#import "PUBLoanBannerModel.h"

@implementation PUBLoanBannerItemModel

@end

@implementation PUBLoanBannerModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"obliterate_eg":[PUBLoanBannerItemModel class]};
}
@end
