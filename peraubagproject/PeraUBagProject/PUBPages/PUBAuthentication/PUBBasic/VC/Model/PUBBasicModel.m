//
//  PUBBasicModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/2.
//

#import "PUBBasicModel.h"

@implementation PUBBasicHorrificEgModel

@end

@implementation PUBBasicSomesuchEgModel

- (NSString *)cellType{
    if([self.luminal_eg isEqualToString:@"AAA1"]){
        return @"enum";
    }
    if([self.luminal_eg isEqualToString:@"AAA2"]){
        return @"txt";
    }
    if([self.luminal_eg isEqualToString:@"AAA3"]){
        return @"citySelect";
    }
    if([self.luminal_eg isEqualToString:@"AAA4"]){
        return @"option";
    }
    if([self.luminal_eg isEqualToString:@"AAA5"]){
        return @"day";
    }
    if([self.luminal_eg isEqualToString:@"AAA6"]){
        return @"photo";
    }
    if([self.luminal_eg isEqualToString:@"AAA7"]){
        return @"linkage";
    }
    return @"";
}

- (CGFloat)cellHight{
    if([self.luminal_eg isEqualToString:@"AAA1"]){
        return 66.f;
    }
    if([self.luminal_eg isEqualToString:@"AAA2"]){
        return 66.f;
    }
    if([self.luminal_eg isEqualToString:@"AAA3"]){
        return 66.f;
    }
    if([self.luminal_eg isEqualToString:@"AAA4"]){
        return 66.f;
    }
    if([self.luminal_eg isEqualToString:@"AAA5"]){
        return 66.f;
    }
    if([self.luminal_eg isEqualToString:@"AAA6"]){
        return 66.f;
    }
    if([self.luminal_eg isEqualToString:@"AAA7"]){
        return 66.f;
    }
    return 0;
}

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"horrific_eg":[PUBBasicHorrificEgModel class],
            };
}

@end

@implementation PUBBasicItmeModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"somesuch_eg":[PUBBasicSomesuchEgModel class],
            };
}
@end

@implementation PUBBasicModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"draffy_eg":[PUBBasicItmeModel class],
            };
}

@end
