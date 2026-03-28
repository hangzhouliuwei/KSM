//
//  BagHomeModel.m
//  NewBag
//
//  Created by Jacky on 2024/3/26.
//

#import "BagHomeModel.h"
@implementation BagHomeModel
@end

@implementation BagHomeCustomerModel
@end

@implementation BagHomeBannerItemModel
@end

@implementation BagHomeBannerModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"hematopoiesisF":[BagHomeBannerItemModel class]};
}
- (CGFloat)cellHeight
{
    return kScreenWidth/347*125 + 9;
}
- (NSString *)cellId
{
    return @"BANNER";
}
- (NSInteger)level
{
    return  97;
}
@end

@implementation BagHomeBigCardItemModel

- (CGFloat)cellHeight
{
    return 374;
}
- (NSString *)cellId
{
    return @"LARGE_CARD";
}
- (NSInteger)level
{
    return  100;
}
@end
@implementation BagHomeBigCardModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"hematopoiesisF":[BagHomeBigCardItemModel class]};
}
@end

@implementation BagHomeSmallModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"hematopoiesisF":[BagHomeSmallCardModel class]};
}
@end
@implementation BagHomeSmallCardModel
- (CGFloat)cellHeight
{
    return kScreenWidth/347*216+22;
}
- (NSString *)cellId
{
    return @"SMALL_CARD";
}
- (NSInteger)level
{
    return  99;
}
@end
@implementation BagHomeRepayItemModel

- (NSString *)cellId
{
    return @"REPAY";
}
- (CGFloat)cellHeight
{
    return 116;
}
- (NSInteger)level
{
    return  98;
}
@end
@implementation BagHomeRepayModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"hematopoiesisF":[BagHomeRepayItemModel class]};
}
@end

@implementation BagHomeHorseItemModel
@end

@implementation BagHomeHorseModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"hematopoiesisF":[BagHomeHorseItemModel class]};
}
- (NSString *)cellId
{
    return @"RIDING_LANTERN";
}
- (CGFloat)cellHeight
{
    return 48.f;
}
- (NSInteger)level
{
    return  96;
}
@end

@implementation BagHomeProductListItemModel
- (CGFloat)cellHeight
{
    return 175.f;
}
- (NSString *)cellId
{
    return @"PRODUCT_LIST";
}
- (NSInteger)level
{
    return  95;
}
@end

@implementation BagHomeProductListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"hematopoiesisF":[BagHomeProductListItemModel class]};
}
@end

@implementation BagHomeBrandModel
- (CGFloat)cellHeight
{
    return 280.f;
}
- (NSString *)cellId
{
    return @"BRAND";
}
- (NSInteger)level
{
    return  94;
}
@end

@implementation BagHomeApplyInfoModel
@end
@implementation BagHomePopModel

@end
