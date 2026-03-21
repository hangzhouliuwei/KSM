//
//  XTLoginViewModel.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTLoginViewModel : NSObject

- (void)getLogin:(NSDictionary *)dic success:(XTBlock)success failure:(XTBlock)failure;

@end

NS_ASSUME_NONNULL_END
