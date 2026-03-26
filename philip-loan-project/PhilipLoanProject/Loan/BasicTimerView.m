//
//  BasicTimerView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/3.
//

#import "BasicTimerView.h"

@implementation BasicTimerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        self.layer.cornerRadius = 12;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 16, self.width - 10, 20)];
        [_titleLabel pp_setPropertys:@[kFontSize(14),kBlackColor_333333,@"Increase pass rate by 20% for a limited time",@(NSTextAlignmentCenter)]];
        [self addSubview:self.titleLabel];
        
        CGFloat itemWidth = 35,space = 31;
        CGFloat left = (self.width - 2 * space - 3 * itemWidth) / 2.0;
        for (int i = 0; i < 3; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left + (itemWidth + space) * i, 14 + _titleLabel.bottom, itemWidth, 40)];
            label.backgroundColor = kHexColor(0xe5eeff);
            [label pp_setPropertys:@[@(NSTextAlignmentCenter),kFontSize(20),kBlueColor_0053FF]];
            label.layer.cornerRadius = 5;
            [self addSubview:label];
            if (i < 2) {
                UILabel *sepLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.right + (space - 5) / 2.0, label.top, 5, label.height)];
                [sepLabel pp_setPropertys:@[@":",kFontSize(17),kGrayColor_999999,@(NSTextAlignmentCenter)]];
                
                [self addSubview:sepLabel];
            }
            if (i == 0) {
                self.hourLabel = label;
            }else if (i == 1) {
                self.minutesLabel = label;
            }else
            {
                self.secondLabel = label;
            }
        }
    }
    return self;
}
-(void)setCount:(NSInteger)count
{
    _count = count;
}
-(void)startTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    kWeakSelf
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (weakSelf.count <=0) {
            if (weakSelf.timerFinishBlk) {
                weakSelf.timerFinishBlk();
            }
            return;
        }
        weakSelf.count--;
        NSInteger hour = weakSelf.count / 3600;
        NSInteger minutes = weakSelf.count % 3600 / 60;
        NSInteger second = weakSelf.count % 3600 % 60;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.hourLabel.text = [NSString stringWithFormat:@"%02ld",hour];
            weakSelf.minutesLabel.text = [NSString stringWithFormat:@"%02ld",minutes];
            weakSelf.secondLabel.text = [NSString stringWithFormat:@"%02ld",second];
        });
    });
    dispatch_activate(timer);
    self.timer = timer;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
