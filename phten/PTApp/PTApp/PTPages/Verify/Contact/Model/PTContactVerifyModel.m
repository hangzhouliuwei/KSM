//
//  PTContactVerifyModel.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTContactVerifyModel.h"

@implementation PTContactRelationEnumModel

@end
@implementation PTContactRelationModel

@end
@implementation PTContactItmeModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"betendieNc":[PTContactRelationEnumModel class]};
}
@end


@implementation PTContactVerifyModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"ovtenrfraughtNc":[PTContactItmeModel class]};
}
@end
