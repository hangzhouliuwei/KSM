//
//  PTLoginCodeController.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/31.
//

#import "PTBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTLoginCodeController : PTBaseVC
@property(nonatomic, copy) NSString *phoneNumber;
@property(nonatomic, copy) PTBlock loginResultBlock;
@property(nonatomic, copy) PTTwoObjectBlock timeBtRunn;
@property(nonatomic, assign) NSInteger  runningTimeNum;
@end

NS_ASSUME_NONNULL_END
