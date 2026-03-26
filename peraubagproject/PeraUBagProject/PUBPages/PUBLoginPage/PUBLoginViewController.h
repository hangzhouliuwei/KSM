//
//  PUBLoginViewController.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/18.
//

#import "PUBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PUBLoginViewController : PUBBaseViewController
@property (nonatomic, copy) void (^loginResultBlock)(NSInteger uid);
@end

NS_ASSUME_NONNULL_END
