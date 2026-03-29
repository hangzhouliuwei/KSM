//
//  LLUserConfigLocationServiceManager.h
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLUserConfigLocationServiceManager : UIView
@property (nonatomic, copy) CallBackBool resultBlock;
@property(nonatomic, copy) CallBackNone  resultlocationBlock;
- (void)ppGotoReqUserPhonesLoction;

@end

NS_ASSUME_NONNULL_END
