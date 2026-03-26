//
//  XTLoginVC.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface XTLoginVC : XTBaseVC

- (instancetype)initPhone:(NSString *)phone countDown:(NSString *)countDown;
@property(nonatomic,copy) XTBlock resendBlock;
@property(nonatomic,copy) XTBlock loginBlock;

-(void)reloadCountDown:(NSString *)countDown;

@end

NS_ASSUME_NONNULL_END
