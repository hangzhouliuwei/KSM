//
//  BagVerifyBasicModel.m
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import "BagVerifyBasicModel.h"
@implementation BagBasicEnumModel

@end
@implementation BagBasicRowModel
- (NSString *)cellType{
    if([self.javaneseF isEqualToString:@"enum"]){
        return @"enum";
    }
    if([self.javaneseF isEqualToString:@"txt"]){
        return @"txt";
    }
    if([self.javaneseF isEqualToString:@"day"]){
        return @"day";
    }
    if([self.javaneseF isEqualToString:@"option"]){
        return @"option";
    }
    return @"";
}

- (CGFloat)cellHight{
    if([self.javaneseF isEqualToString:@"enum"]){
        return 56.f;
    }
    if([self.javaneseF isEqualToString:@"txt"]){
        return 56.f;
    }
    if([self.javaneseF isEqualToString:@"day"]){
        return 56.f;
    }
    if([self.javaneseF isEqualToString:@"option"]){
        return 56.f;
    }
    return 0;
}
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"maquisF":[BagBasicEnumModel class]};
}
@end
@implementation BagBasicItmeModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"railageF":[BagBasicRowModel class]};
}
@end
@implementation BagVerifyBasicModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"heterogenistF":[BagBasicItmeModel class]};
}
@end
