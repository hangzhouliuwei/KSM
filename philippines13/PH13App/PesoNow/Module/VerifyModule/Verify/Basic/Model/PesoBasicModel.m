//
//  PesoBasicModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBasicModel.h"
@implementation PesoBasicEnumModel

@end
@implementation PesoBasicRowModel
- (NSString *)cellType{
    if([self.lebothirteenardNc isEqualToString:@"AATHIRTEENBF"]){
        return @"enum";
    }
    if([self.lebothirteenardNc isEqualToString:@"AATHIRTEENBG"]){
        return @"txt";
    }
    if([self.lebothirteenardNc isEqualToString:@"AATHIRTEENBJ"]){
        return @"day";
    }
    if([self.lebothirteenardNc isEqualToString:@"AATHIRTEENBI"]){
        return @"option";
    }
    return @"";
}
- (CGFloat)cellHight
{
    return 56;
}
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"tubothirteendrillNc":[PesoBasicEnumModel class]};
}
@end
@implementation PesoBasicItmeModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"xaththirteenosisNc":[PesoBasicRowModel class]};
}
@end

@implementation PesoBasicModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"ovrfthirteenraughtNc":[PesoBasicItmeModel class]};
}
@end
