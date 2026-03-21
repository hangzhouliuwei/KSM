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
    if([self.lebofourteenardNc isEqualToString:@"AAFOURTEENBF"]){
        return @"enum";
    }
    if([self.lebofourteenardNc isEqualToString:@"AAFOURTEENBG"]){
        return @"txt";
    }
    if([self.lebofourteenardNc isEqualToString:@"AAFOURTEENBJ"]){
        return @"day";
    }
    if([self.lebofourteenardNc isEqualToString:@"AAFOURTEENBI"]){
        return @"option";
    }
    return @"";
}

- (CGFloat)cellHight{
    if([self.lebofourteenardNc isEqualToString:@"AAFOURTEENBF"]){
        return 56.f;
    }
    if([self.lebofourteenardNc isEqualToString:@"AAFOURTEENBG"]){
        return 56.f;
    }
    if([self.lebofourteenardNc isEqualToString:@"AAFOURTEENBJ"]){
        return 56.f;
    }
    if([self.lebofourteenardNc isEqualToString:@"AAFOURTEENBI"]){
        return 56.f;
    }
    return 0;
}
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"tubofourteendrillNc":[BagBasicEnumModel class]};
}
@end
@implementation BagBasicItmeModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"xathfourteenosisNc":[BagBasicRowModel class]};
}
@end
@implementation BagVerifyBasicModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"ovrffourteenraughtNc":[BagBasicItmeModel class]};
}
@end
