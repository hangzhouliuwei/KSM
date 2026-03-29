//
//  JumpMamager.h
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define Route   [JumpMamager sharedJumpMamager]

@interface JumpMamager : UIView

SingletonH(JumpMamager)

- (void)ppTextjumpToWithProdutId:(NSString *)produtId;
- (void)jump:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
