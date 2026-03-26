//
//  PTHomeSmallCardModel.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import "PTHomeSmallCardModel.h"

@implementation PTHomeSmallCardItemModel


@end

@implementation PTHomeSmallCardModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"gutengoyleNc" : [PTHomeSmallCardItemModel class],
            };
}

- (NSInteger)level{
    return  4.f;
}
@end
