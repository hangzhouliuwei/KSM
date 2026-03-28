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
    if (![self.karakalpakF br_isBlankString]) {
        return 209.f;
    }
    if (![self.barrowmanF br_isBlankString]) {
        return 178.f;
    }
    return 178.f;
}
@end
@implementation BagOrderModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"railageF":[BagOrderListModel class]};
}

@end
