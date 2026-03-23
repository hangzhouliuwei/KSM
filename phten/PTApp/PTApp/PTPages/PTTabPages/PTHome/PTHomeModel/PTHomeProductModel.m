//
//  PTHomeProductModel.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import "PTHomeProductModel.h"

@implementation PTHomeProductListModel

- (NSInteger)level{
    return  7.f;
}

@end

@implementation PTHomeProductModel


+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"gutengoyleNc" : [PTHomeProductListModel class],
            };
}

- (NSInteger)level{
    return  7.f;
}
@end
