//
//  PTBankModel.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBankModel.h"

@implementation PTBankValue

@end
@implementation PTBankItemModel

@end
@implementation PTBankWalletModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"untenrderlyNc":[PTBankItemModel class]};
}
@end
@implementation PTBankBankModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"untenrderlyNc":[PTBankItemModel class]};
}
@end
@implementation PTBankModel

@end

