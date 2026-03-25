//
//  PesoVerifyStepView.h
//  PesoApp
//
//  Created by Jacky on 2024/9/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoVerifyStepView : UIView
@property(nonatomic, assign) NSInteger countTime;
@property(nonatomic, assign) NSInteger step;
@property (nonatomic, copy) dispatch_block_t endBlock;

- (void)hiddenStep;
- (void)hiddenAllSub;
@end

NS_ASSUME_NONNULL_END
