//
//  XTBankModel.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTBankModel.h"
#import "XTBankItemModel.h"

@implementation XTBankModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"xt_countdown" : @"paeosixgrapherNc",
        @"bankModel" : @"murasixyNc",
        @"walletModel" : @"abensixtlyNc",
    };
}

@end
