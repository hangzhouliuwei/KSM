//
//  PTHomeLargeEcardModel.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/1.
// 大卡牌

#import "PTHomeLargeEcardModel.h"

@implementation PTHomeLargeEcardItemModel

@end

@implementation PTHomeLargeEcardModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"gutengoyleNc" : [PTHomeLargeEcardItemModel class],
            };
}

- (NSInteger)level{
    return  1.f;
}
@end
