//
//  BagOrderModel.m
//  NewBag
//
//  Created by Jacky on 2024/4/1.
//

#import "BagOrderModel.h"
@implementation BagOrderListModel
- (CGFloat)cellHeight
{
    if (![self.maanfourteenNc br_isBlankString]) {
        return 209.f;
    }
    if (![self.exerfourteeniencelessNc br_isBlankString]) {
        return 178.f;
    }
    return 178.f;
}
@end
@implementation BagOrderModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"xathfourteenosisNc":[BagOrderListModel class]};
}

@end
