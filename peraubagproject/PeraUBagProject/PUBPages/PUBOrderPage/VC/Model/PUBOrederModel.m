//
//  PUBOrederModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/15.
//

#import "PUBOrederModel.h"

@implementation PUBOrederItemModel

-(NSInteger)cellHeght{
    if(![PUBTools isBlankString:self.pinxit_eg] && ![PUBTools isBlankString:self.flinders_eg]){
        return 237.f;
    }else if(![PUBTools isBlankString:self.pinxit_eg]){
        
        return 160.f;
        
    }else if([PUBTools isBlankString:self.pinxit_eg]){
        return 150.f;
    }
    return 0;
}

@end

@implementation PUBOrederModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"somesuch_eg":[PUBOrederItemModel class],
            };
}

@end
