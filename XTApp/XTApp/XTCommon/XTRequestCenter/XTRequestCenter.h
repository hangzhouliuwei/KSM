//
//  XTRequestCenter.h
//  XTApp
//
//  Created by xia on 2024/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTRequestCenter : NSObject

+ (instancetype)xt_share;

-(void)xt_market:(NSString *)idfa;
-(void)xt_location:(XTBoolBlock)block;
-(void)xt_device;

@end

NS_ASSUME_NONNULL_END
