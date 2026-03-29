//
//  NSString+Adds.h
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Adds)

- (NSString *)stringValue;

@end

BOOL isBlankStr(NSString *string);
NSString* notNull(NSString *string);

NS_ASSUME_NONNULL_END
