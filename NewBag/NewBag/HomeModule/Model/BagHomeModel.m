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
    return @{@"gugofourteenyleNc":[BagHomeBannerItemModel class]};
}
- (CGFloat)cellHeight
{
    return kScreenWidth/347*125 + 9;
}
- (NSString *)cellId
{
    return Home_BANNER;
}
- (NSInteger)level
{
    return  97;
}
@end

@implementation BagHomeBigCardItemModel

- (CGFloat)cellHeight
{
    return kScreenWidth/374*363;
}
- (NSString *)cellId
{
    return Home_LARGE_CARD;
}
- (NSInteger)level
{
    return  100;
}
@end
@implementation BagHomeBigCardModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"gugofourteenyleNc":[BagHomeBigCardItemModel class]};
}
@end

@implementation BagHomeSmallModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"gugofourteenyleNc":[BagHomeSmallCardModel class]};
}
@end
@implementation BagHomeSmallCardModel
- (CGFloat)cellHeight
{
    return (kScreenWidth-28)/347*216 + 13;
}
- (NSString *)cellId
{
    return Home_SMALL_CARD;
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
    return @{@"gugofourteenyleNc":[BagHomeRepayItemModel class]};
}
@end

@implementation BagHomeHorseItemModel
@end

@implementation BagHomeHorseModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"gugofourteenyleNc":[BagHomeHorseItemModel class]};
}
- (NSString *)cellId
{
    return Home_RIDING_LANTERN;
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
    return Home_PRODUCT_LIST;
}
- (NSInteger)level
{
    return  95;
}
@end

@implementation BagHomeProductListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"gugofourteenyleNc":[BagHomeProductListItemModel class]};
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
