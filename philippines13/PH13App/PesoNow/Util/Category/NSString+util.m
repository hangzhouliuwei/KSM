//
//  NSString+util.m
//  PesoApp
//
//  Created by Jacky on 2024/9/12.
//

#import "NSString+util.h"

@implementation NSString (util)
- (NSString *)pinProductId:(NSString *)product_id
{
    if ([self containsString:@"http"] || [self containsString:@"https"]) {
        return self;
    }
    
    if (![self containsString:@"lietthirteenusNc"]) {
        if ([self containsString:@"?"]) {
            return [NSString stringWithFormat:@"%@lietthirteenusNc=%@",self,product_id];
        }
        return [NSString stringWithFormat:@"%@?lietthirteenusNc=%@",self,product_id];
    }
    return self;
}
@end
