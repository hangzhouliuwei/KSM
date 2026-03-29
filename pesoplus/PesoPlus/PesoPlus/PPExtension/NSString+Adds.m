//
//  NSString+Adds.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "NSString+Adds.h"

@implementation NSString (Adds)

- (NSString *)stringValue {
    if (self) {
        return self;
    }else {
        return @"";
    }
}

- (BOOL)isBlank {
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (self.length == 0) {
        return YES;
    }
    return NO;
}

@end

NSString* notNull(NSString *string) {
    if (isBlankStr(string)) {
        return @"";
    }else {
        return string;
    }
}

BOOL isBlankStr(NSString *string) {
    return string == nil || [string isBlank];
}

