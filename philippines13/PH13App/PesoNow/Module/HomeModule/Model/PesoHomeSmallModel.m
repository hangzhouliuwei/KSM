//
//  PesoHomeSmallModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeSmallModel.h"
@implementation PesoHomeSmallItemModel
@end
@implementation PesoHomeSmallModel
- (NSString *)type
{
    return @"Small";
}
-(NSInteger)priority
{
    return 2;
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"gugothirteenyleNc" : [PesoHomeSmallItemModel class],
            };
}
- (CGFloat)height
{
    return (kScreenWidth-40)/335*196;
}
@end
