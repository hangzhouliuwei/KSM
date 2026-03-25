//
//  PesoLoginCodeVC.h
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoLoginCodeVC : PesoBaseVC
@property(nonatomic, copy) NSString *phoneNumber;
@property(nonatomic, copy) PHBlock loginResultBlock;
//@property(nonatomic, copy) PTTwoObjectBlock timeBtRunn;
@property (nonatomic, copy) void(^countBlock)(int countdown);
@property(nonatomic, assign) int countDownTime;
@end

NS_ASSUME_NONNULL_END
