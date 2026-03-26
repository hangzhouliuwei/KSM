//
//  PTHomeBannerModel.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/1.
//

#import "PTHomeBannerModel.h"

@implementation PTHomeBannerItemModel


@end

@implementation PTHomeBannerModel

+ (NSDictionary *)modelContainerPropertyGenericClass 
{
    return @{
             @"gutengoyleNc" : [PTHomeBannerItemModel class],
            };
}

- (NSInteger)level{
    
    return 6.f;
}

@end
