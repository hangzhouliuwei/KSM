//
//  BasicTimerView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicTimerView : UIView

@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)dispatch_source_t timer;

@property(nonatomic)NSInteger count;

@property(nonatomic)UILabel *hourLabel, *minutesLabel,*secondLabel;

@property(nonatomic,copy)void(^timerFinishBlk)(void);


-(void)startTimer;

@end

NS_ASSUME_NONNULL_END
