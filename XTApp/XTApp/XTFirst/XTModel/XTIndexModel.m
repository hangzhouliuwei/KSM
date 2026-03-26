//
//  XTIndexModel.m
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import "XTIndexModel.h"
#import "XTBannerModel.h"
#import "XTCardModel.h"
#import "XTRepayModel.h"
#import "XTLanternModel.h"
#import "XTProductModel.h"

@interface XTIndexModel()

@property(nonatomic,strong) NSArray *xathsixosisNc;

@end

@implementation XTIndexModel

//普通映射
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"iconModel" : @"ieNcsix",
    };
}

- (void)setXathsixosisNc:(NSArray *)xathsixosisNc{
    _xathsixosisNc = xathsixosisNc;
    for(NSDictionary *dic in xathsixosisNc) {
        NSString *itlisixanizeNc = XT_Object_To_Stirng(dic[@"itlisixanizeNc"]);
        NSArray *gugosixyleNc = dic[@"gugosixyleNc"];
        ///banner
        if([itlisixanizeNc isEqualToString:@"AASIXTENAV"]) {
            self.bannerArr = [NSArray yy_modelArrayWithClass:XTBannerModel.class json:gugosixyleNc];
        }
        else if([itlisixanizeNc isEqualToString:@"AASIXTENAW"]) {///跑马灯
            self.lanternArr = [NSArray yy_modelArrayWithClass:XTLanternModel.class json:gugosixyleNc];
        }
        else if([itlisixanizeNc isEqualToString:@"AASIXTENAX"]) {///大卡
            self.big = [XTCardModel yy_modelWithDictionary:gugosixyleNc.firstObject];
        }
        else if([itlisixanizeNc isEqualToString:@"AASIXTENAY"]) {///小卡
            self.small = [XTCardModel yy_modelWithDictionary:gugosixyleNc.firstObject];
        }
        else if([itlisixanizeNc isEqualToString:@"AASIXTENAZ"]) {///产品
            self.productArr = [NSArray yy_modelArrayWithClass:XTProductModel.class json:gugosixyleNc];
        }
        else if([itlisixanizeNc isEqualToString:@"REPAY_NOTICE"]) {///提醒
            self.noticeModel = [XTRepayModel yy_modelWithDictionary:gugosixyleNc.firstObject];
        }
    }
}

@end
