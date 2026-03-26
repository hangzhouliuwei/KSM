//
//  PTVerifyCountDownView.h
//  PTApp
//
//  Created by Jacky on 2024/8/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface PTVerifyStepView : UIView
@property(nonatomic, assign) NSInteger step;

@end

@interface PTVerifyCountDownView : UIView
@property(nonatomic, assign) NSInteger countTime;
@property(nonatomic, assign) NSInteger step;
@property (nonatomic, copy) PTBlock endBlock;

- (void)hiddenStep;
- (void)hiddenAllSub;
@end

NS_ASSUME_NONNULL_END
