//
//  PesoBankModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBankModel.h"
@implementation PesoBankValue

@end
@implementation PesoBankItemModel

@end
@implementation PesoBankWalletModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"unrdthirteenerlyNc":[PesoBankItemModel class]};
}
@end
@implementation PesoBankBankModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"unrdthirteenerlyNc":[PesoBankItemModel class]};
}
@end
@implementation PesoBankModel

@end
