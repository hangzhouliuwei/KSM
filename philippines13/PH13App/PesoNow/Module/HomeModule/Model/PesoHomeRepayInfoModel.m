//
//  PesoHomeRepayInfoModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeRepayInfoModel.h"

@implementation PHRepayItemModel


@end
@implementation PesoHomeRepayInfoModel
- (NSString *)type
{
    return @"Repay";
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"gugothirteenyleNc" : [PHRepayItemModel class],
            };
}
- (NSInteger)priority
{
    return 3;
}
- (CGFloat)height
{
    return ((kScreenWidth-30)/345*65 + 10);
}
@end
