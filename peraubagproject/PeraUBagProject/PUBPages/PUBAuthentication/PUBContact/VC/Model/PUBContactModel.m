//
//  PUBContactModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/4.
//

#import "PUBContactModel.h"


@implementation PUBContactMgrimEgModel


@end

@implementation PUBContactFeatherstitchEgModel


@end

@implementation PUBContactItmeModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"endothelium_eg":[NSDictionary class],
             @"featherstitch_eg":[PUBContactFeatherstitchEgModel class],
            };
}

@end

@implementation PUBContactModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"draffy_eg":[PUBContactItmeModel class],
            };
}
@end
