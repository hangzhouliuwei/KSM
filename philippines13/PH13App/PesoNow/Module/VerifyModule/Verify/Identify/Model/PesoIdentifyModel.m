//
//  PesoIdentifyModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoIdentifyModel.h"
#import "PesoBasicModel.h"

@implementation PesoIdentifyListModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"uporthirteennNc":@"roanthirteenizeNc",
             @"itlithirteenanizeNc":@"ceNcthirteen"};
}

@end
@implementation PesoIdentifyDetailModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"xaththirteenosisNc":[PesoBasicRowModel class],
             @"tubothirteendrillNc":[PesoIdentifyListModel class],
            };
}

@end
@implementation PesoIdentifyModel

@end
