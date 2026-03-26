//
//  PUBTimeButton.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/22.
//

#import "PUBTimeButton.h"

@interface PUBTimeButton ()
@property (nonatomic, strong) NSTimer *timer;//创建

@property (nonatomic, assign) int timeNum;//获取到倒计时的时间

@end

@implementation PUBTimeButton

- (instancetype)initWithFrame:(CGRect)frame andTimer:(int)time {
    if (self = [super initWithFrame:frame]) {
        //设置按钮的时间进行获取
        _timeNum = time;
        _runningTimeNum = 0;
        
        //默认样式
        [self setTitle:@"Resend" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = [UIColor qmui_colorWithHexString:@"#989BA3"];
        [self addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)onClick:(UIButton *)sender{
    //倒数计时开始 的block
    if (_startTimeButtonAction) {
        _startTimeButtonAction(self,_runningTimeNum != 0);
    }
    /*判断如果 _runningTimeNum == 0 的时候表示button没有进入倒计时状态的  如果不是0就是正在进行倒计时（不需要创建NSTimer）
      没有进入倒计时计划要重新创建NSTimer
     */
    if (_runningTimeNum == 0) {
        if (self.timer) {
            [self releaseTimer];
        }
        _runningTimeNum = _timeNum;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshButton) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)startTimes:(int)times
{
    /*判断如果 _runningTimeNum == 0 的时候表示button没有进入倒计时状态的  如果不是0就是正在进行倒计时（不需要创建NSTimer）
      没有进入倒计时计划要重新创建NSTimer
     */
    if (_runningTimeNum == 0) {
        if (self.timer) {
            [self releaseTimer];
        }
        _timeNum = times;
        _runningTimeNum = _timeNum;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshButton) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    //倒数计时开始 的block
    if (_startTimeButtonAction) {
        _startTimeButtonAction(self,_runningTimeNum != 0);
    }
}

// 刷新按钮
- (void)refreshButton {
    _runningTimeNum --;
    NSLog(@"lw======>runningTimeNum %d",_runningTimeNum);
    self.backgroundColor = [UIColor qmui_colorWithHexString:@"#989BA3"];
    //倒计时更新文字
    [self setTitle:[NSString stringWithFormat:@"%ds",_runningTimeNum] forState:UIControlStateNormal];
    //正在进行倒计时 的block
    if (_runningTimeButtonAction) {
        _runningTimeButtonAction(self);
    }
    //_runningTimeNum == 0 已经倒计时完成 更改回原来button的样式
    if (_runningTimeNum == 0) {
        self.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
        [self releaseTimer];
        [self setTitle:@"Resend" forState:UIControlStateNormal];
        //倒计时完成 的block
        if (_endTimeButtonAction) {
            _endTimeButtonAction(self);
        }
    }
}

//释放方法
- (void)releaseTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc {
    NSLog(@"倒计时按钮已释放");
}

@end
