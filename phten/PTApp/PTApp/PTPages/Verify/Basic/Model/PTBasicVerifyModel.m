//
//  PTBasicVerifyModel.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBasicVerifyModel.h"

@implementation PTBasicEnumModel

@end
@implementation PTBasicRowModel
- (NSString *)cellType{
    if([self.letenboardNc isEqualToString:@"AABFTEN"]){
        return @"enum";
    }
    if([self.letenboardNc isEqualToString:@"AABGTEN"]){
        return @"txt";
    } 
    if([self.letenboardNc isEqualToString:@"AABJTEN"]){
        return @"day";
    }
    if([self.letenboardNc isEqualToString:@"AABITEN"]){
        return @"option";
    }
    return @"";
}

- (CGFloat)cellHight{
//    if([self.letenboardNc isEqualToString:@"enum"]){
//        return 56.f;
//    }
//    if([self.letenboardNc isEqualToString:@"txt"]){
//        return 56.f;
//    }
//    if([self.letenboardNc isEqualToString:@"day"]){
//        return 56.f;
//    }
//    if([self.letenboardNc isEqualToString:@"option"]){
//        return 56.f;
//    }
    return 56;
}
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"tutenbodrillNc":[PTBasicEnumModel class]};
}
@end
@implementation PTBasicItmeModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"xatenthosisNc":[PTBasicRowModel class]};
}
@end
@implementation PTBasicVerifyModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"ovtenrfraughtNc":[PTBasicItmeModel class]};
}
@end
