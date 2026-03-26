//
//  CameraViewController.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/9.
//

#import "PLPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CameraViewController : PLPBaseViewController
@property(nonatomic,copy)void(^takeFinish)(id responseObject,UIImage *cardImage);
@property(nonatomic,copy)NSString *light;
@end

NS_ASSUME_NONNULL_END
