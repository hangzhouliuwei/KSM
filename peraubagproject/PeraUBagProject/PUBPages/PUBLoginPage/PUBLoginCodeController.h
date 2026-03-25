//
//  PUBLoginCodeController.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/22.
//

#import "PUBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PUBLoginCodeController : PUBBaseViewController
///手机号码
@property(nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) void (^loginResultBlock)(NSInteger uid);
@property(nonatomic, copy) ReturnTwoObjectLoginBlock timeBtRunning;
@property(nonatomic, assign) NSInteger runningTimeNum;
@end

NS_ASSUME_NONNULL_END
