//
//  BagLoginViewController.h
//  NewBag
//
//  Created by Jacky on 2024/3/14.
//

#import "BagBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagLoginViewController : BagBaseVC
@property (nonatomic, copy) void (^loginResultBlock)(NSInteger uid);
@end

NS_ASSUME_NONNULL_END
