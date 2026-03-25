//
//  PUBRSATool.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/5/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBRSATool : NSObject
/** RSA 加密 */
+ (NSString *)contentWithContent:(NSString *)content privateKey:(NSString*)privateKey;

+ (NSString *)contentWithContent:(NSString *)content publicKey:(NSString *)publicKey;

+ (NSString *)decryptContentWithContent:(NSString *)content publicKey:(NSString *)publicKey;

@end

NS_ASSUME_NONNULL_END
