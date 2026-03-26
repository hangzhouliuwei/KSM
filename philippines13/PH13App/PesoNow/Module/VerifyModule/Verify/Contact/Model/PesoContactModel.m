//
//  PesoContactModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoContactModel.h"
@implementation PesoContactRelationEnumModel

@end
@implementation PesoContactRelationModel

@end
@implementation PesoContactItmeModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"bedithirteeneNc":[PesoContactRelationEnumModel class]};
}
@end
@implementation PesoContactModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"ovrfthirteenraughtNc":[PesoContactItmeModel class]};
}
@end
