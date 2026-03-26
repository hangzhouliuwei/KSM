//
//  PUBTimeButton.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBTimeButton : UIButton
@property (nonatomic, assign) int runningTimeNum;//用于倒计时用处
//设置倒是按钮需要到时的时间
- (instancetype)initWithFrame:(CGRect)frame andTimer:(int)time;

//点击时候触发的块 和 是否在倒计时 如果yes标示在倒计时  如果no标示没有开始
@property (nonatomic, copy) void (^startTimeButtonAction)(PUBTimeButton * btn,BOOL isRunning);
//进行倒数计时
@property (nonatomic, copy) void (^runningTimeButtonAction)(PUBTimeButton * btn);
//完成倒计时
@property (nonatomic, copy) void (^endTimeButtonAction)(PUBTimeButton * btn);

//释放NSTimer
- (void)releaseTimer;

- (void)startTimes:(int)times;

@end

NS_ASSUME_NONNULL_END
