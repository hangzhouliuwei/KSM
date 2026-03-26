//
//  NSDictionary+Category.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/26.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)
-(BOOL)isReal
{
    if (self == nil) {
        return NO;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (self.allKeys.count == 0) {
        return NO;
    }
    return YES;
}
@end
