//
//  BagVerifyBasicCountDownView.m
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import "BagVerifyBasicCountDownView.h"
#import "BagCountDown.h"
@interface BagVerifyBasicCountDownView()
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UIImageView *countClock;
@property (weak, nonatomic) IBOutlet UIImageView *countIncreaseImage;

@property (weak, nonatomic) IBOutlet UIImageView *stepImage;
@property(nonatomic, strong) BagCountDown *countDownTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stepBottomConst;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end
@implementation BagVerifyBasicCountDownView

+ (instancetype)createView{
    BagVerifyBasicCountDownView *view= [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    [view.backImageView sd_setImageWithURL:[Util loadImageUrl:@"basic_bg"]];
    [view.countClock sd_setImageWithURL:[Util loadImageUrl:@"basic_clock"]];
    [view.countIncreaseImage sd_setImageWithURL:[Util loadImageUrl:@"basic_increase"]];
    return view;
}
- (void)setCountTime:(NSInteger)countTime
{
    _countTime = countTime;
    if(countTime <= 0){
        if (self.countDownEndBlock) {
            self.countDownEndBlock();
        }
        [self hiddenCountDown];
        return;
    }
    
    WEAKSELF
    [self.countDownTime cmsCountDownWithSecond:countTime completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        STRONGSELF
        NSString *hourstr = @"";
        NSString *minutestr = @"";
        NSString *secondstr = @"";
        
        if (hour<10) {
            hourstr = [NSString stringWithFormat:@"0%ld",(long)hour];
        }else{
            hourstr = [NSString stringWithFormat:@"%ld",(long)hour];
        }
        if (minute<10) {
            minutestr = [NSString stringWithFormat:@"0%ld",(long)minute];
        }else{
            minutestr = [NSString stringWithFormat:@"%ld",(long)minute];
        }
        if (second<10) {
            secondstr = [NSString stringWithFormat:@"0%ld",(long)second];
        }else{
            secondstr = [NSString stringWithFormat:@"%ld",(long)second];
        };
        self.countDownLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hourstr,minutestr,secondstr];

        if([hourstr isEqualToString:@"00"]
           &&[minutestr isEqualToString:@"00"]
           && [secondstr isEqualToString:@"00"]
           && self.countDownEndBlock){
            
            self.countDownEndBlock();
            [self hiddenCountDown];
        }
    }];
}
- (void)setStep:(NSInteger)step
{
    _step = step;
//    _stepImage.image = [UIImage imageNamed: step == 1 ? @"basic_step_first" : (step == 2 ? @"basic_step_second" : @"basic_step_third")];
    switch (step) {
        case 1:
            [self.stepImage sd_setImageWithURL:[Util loadImageUrl:@"basic_step_first"]];
            break;
        case 2:
            [self.stepImage sd_setImageWithURL:[Util loadImageUrl:@"basic_step_second"]];
            break;
        case 3:
            [self.stepImage sd_setImageWithURL:[Util loadImageUrl:@"basic_step_third"]];
            break;
        default:
            break;
    }
    
}
- (void)hiddenCountDown{
    self.countDownLabel.hidden = self.countClock.hidden = self.countIncreaseImage.hidden = YES;
}
- (void)hiddenStep{
    self.stepImage.hidden = YES;
}
- (void)drawRect:(CGRect)rect
{
    self.frame = CGRectMake(0, 0, kScreenWidth, 255);
}
- (BagCountDown *)countDownTime{
    if(!_countDownTime){
        _countDownTime = [[BagCountDown alloc] init];
    }
    return _countDownTime;
}
@end
