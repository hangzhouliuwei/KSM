//
//  BagBankModel.m
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagBankModel.h"
@implementation BagBankValue

@end
@implementation BagBankItemModel

@end
@implementation BagBankWalletModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"heelF":[BagBankItemModel class]};
}
@end
@implementation BagBankBankModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"heelF":[BagBankItemModel class]};
}
@end
@implementation BagBankModel

@end
