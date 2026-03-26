//
//  PesoHomeBigModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeBigModel.h"
@implementation PesoBItemModel

@end
@implementation PesoHomeBigModel
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"gugothirteenyleNc" : [PesoBItemModel class],
            };
}

- (NSInteger)priority{
    return  1.f;
}
- (CGFloat)height
{
    return 270.f;
}
- (NSString *)type
{
    return @"Big";
}
@end
