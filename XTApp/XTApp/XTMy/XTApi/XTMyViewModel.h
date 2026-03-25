//
//  XTMyViewModel.h
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTMyModel;
@interface XTMyViewModel : NSObject

@property(nonatomic,strong) XTMyModel *myModel;


- (void)xt_home:(XTBlock)success failure:(XTBlock)failure;

@end

NS_ASSUME_NONNULL_END
