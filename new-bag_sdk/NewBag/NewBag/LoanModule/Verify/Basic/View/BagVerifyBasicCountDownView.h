//
//  BagVerifyBasicCountDownView.h
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyBasicCountDownView : UIView
+ (instancetype)createView;
- (void)hiddenStep;
- (void)hiddenCountDown;
@property(nonatomic, assign) NSInteger countTime;
@property(nonatomic, assign) NSInteger step;
@property (nonatomic, copy) void(^countDownEndBlock)(void);
@end

NS_ASSUME_NONNULL_END
