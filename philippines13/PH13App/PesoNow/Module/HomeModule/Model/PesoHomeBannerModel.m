//
//  PesoHomeBannerModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeBannerModel.h"

@implementation PesoHomeBannerItemModel

@end

@implementation PesoHomeBannerModel
- (NSString *)type
{
    return @"Banner";
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"gugothirteenyleNc" : [PesoHomeBannerItemModel class],
            };
}

- (NSInteger)priority{
    
    return 0.5;
}
- (CGFloat)height{
    return kScreenWidth/375*148+28;
}
@end
