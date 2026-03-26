//
//  PesoHomePLModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomePLModel.h"

@implementation PesoHomePLItemModel

- (CGFloat)height
{
    return 150.f;
}

- (NSInteger)priority{
    return  5;
}
- (NSString *)type
{
    return @"list";;
}
@end

@implementation PesoHomePLModel


+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"gugothirteenyleNc" : [PesoHomePLItemModel class],
            };
}
@end
