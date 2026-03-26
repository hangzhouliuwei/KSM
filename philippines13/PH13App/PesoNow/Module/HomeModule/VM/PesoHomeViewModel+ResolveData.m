//
//  PesoHomeViewModel+ResolveData.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeViewModel+ResolveData.h"
#import "PesoHomeBigModel.h"
#import "PesoHomeSmallModel.h"
#import "PesoHomeBannerModel.h"
#import "PesoHomePLModel.h"
#import "PesoHomeRepayInfoModel.h"
//'"itlithirteenanizeNc":"BANNER"',
//'"itlithirteenanizeNc":"RIDING_LANTERN"',
//'"itlithirteenanizeNc":"LARGE_CARD"',
//'"itlithirteenanizeNc":"SMALL_CARD"',
//'"itlithirteenanizeNc":"PRODUCT_LIST"',

//'"itlithirteenanizeNc":"AATHIRTEENAV"',
//'"itlithirteenanizeNc":"AATHIRTEENAW"',
//'"itlithirteenanizeNc":"AATHIRTEENAX"',
//'"itlithirteenanizeNc":"AATHIRTEENAY"',
//'"itlithirteenanizeNc":"AATHIRTEENAZ"',
@implementation PesoHomeViewModel (ResolveData)
- (void)resolveData:(NSDictionary *)data callback:(void(^)(NSArray *))callback{
    __block NSMutableArray *dataArray = @[].mutableCopy;
    __block BOOL haveBig = NO;
    NSArray *array = data[@"xaththirteenosisNc"];
    NSDictionary *keyValueDic = @{@"AATHIRTEENAX":[PesoHomeBigModel class],
                                  @"REPAY_NOTICE":[PesoHomeRepayInfoModel class],
                                  @"AATHIRTEENAV":[PesoHomeBannerModel class],
                                  @"AATHIRTEENAY":[PesoHomeSmallModel class],
                                  @"AATHIRTEENAZ":[PesoHomePLModel class]
                                  
    };
    if (array && [array isKindOfClass:[NSArray class]]) {
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isKindOfClass:[NSDictionary class]]) {
                return;
            }
            NSString *type = obj[@"itlithirteenanizeNc"];
            Class class = keyValueDic[type];
            if (class) {
                PesoHomeBaseModel *model = [class yy_modelWithDictionary:obj];
                if ([type isEqual:@"AATHIRTEENAZ"]) {
                    //list
                    PesoHomePLModel *list = (PesoHomePLModel *)model;
                    [list.gugothirteenyleNc enumerateObjectsUsingBlock:^(PesoHomePLItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [dataArray addObject:obj];
                    }];
                    return;
                }
                if ([type isEqual:@"AATHIRTEENAX"]) {
                    haveBig = YES;
                }
                if ([type isEqual:@"AATHIRTEENAW"]) {
                    //跑马灯
                    return;
                }
                if (model) {
                    [dataArray addObject:model];
                }
            }
        }];
//        if (haveBig) {
//            NSMutableIndexSet *bannerIndex = [NSMutableIndexSet indexSet];
//            [dataArray enumerateObjectsUsingBlock:^(PesoHomeBaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if([obj.type isEqualToString:@"Banner"]) {
//                    [bannerIndex addIndex:idx];
//                }
//            }];
//            [dataArray removeObjectsAtIndexes:bannerIndex];
//        }
        
        PesoHomeBaseModel *brand = [PesoHomeBaseModel new];
        brand.height = (kScreenWidth -30)/335* 136 + 20;
        brand.priority = 10;
        brand.type = @"Brand";
        [dataArray addObject:brand];
        
//        PesoHomeSmallModel *item = [PesoHomeSmallModel new];
//        [dataArray addObject:item];
        
//        PesoHomeRepayInfoModel *repay = [PesoHomeRepayInfoModel new];
//        [dataArray addObject:repay];
//        PesoHomePLItemModel *list = [PesoHomePLItemModel new];
//        list.moosthirteenyllabismNc = @"111";
//        list.eahothirteenleNc = @"200000";
//        list.cotethirteennderNc = @"Maximum Loan Amount1";//
//        list.height = 150;
//        list.priority = 10;
//        list.maanthirteenNc = @"Apply now";
//        list.type = @"list";
//        [dataArray addObject:list];
    }
    NSArray *sortedArray = [dataArray sortedArrayUsingComparator:^NSComparisonResult(PesoHomeBaseModel *obj1, PesoHomeBaseModel *obj2) {
        return obj1.priority > obj2.priority;
    }];
    if (callback) {
        callback(sortedArray);
    }
    NSLog(@"bruce>>>%@",sortedArray);
}
@end
