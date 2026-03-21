//
//  BagVerifyContactModel.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyContactModel.h"
@implementation BagContactRelationEnumModel

@end
@implementation BagContactRelationModel

@end
@implementation BagContactItmeModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"bedifourteeneNc":[BagContactRelationEnumModel class]};
}
@end


@implementation BagVerifyContactModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"ovrffourteenraughtNc":[BagContactItmeModel class]};
}
@end
