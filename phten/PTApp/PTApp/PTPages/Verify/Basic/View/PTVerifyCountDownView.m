//
//  PTVerifyCountDownView.m
//  PTApp
//
//  Created by Jacky on 2024/8/23.
//

#import "PTVerifyCountDownView.h"
#import "PtVerifyCountDown.h"

@interface PTVerifyStepView ()
@property (nonatomic, strong) UIImageView *bgImage1;
@property (nonatomic, strong) UIImageView *titleImage1;
@property (nonatomic, strong) UIImageView *bgImage2;
@property (nonatomic, strong) UIImageView *titleImage2;
@property (nonatomic, strong) UIImageView *bgImage3;
@property (nonatomic, strong) UIImageView *titleImage3;
@end
@implementation PTVerifyStepView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self addSubview: self.bgImage1];
    [self.bgImage1 addSubview:self.titleImage1];
    [self addSubview: self.bgImage2];
    [self.bgImage2 addSubview:self.titleImage2];
    [self addSubview: self.bgImage3];
    [self.bgImage3 addSubview:self.titleImage3];
    [self.bgImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(88, 34));
    }];
    [self.titleImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bgImage1);
    }];
    [self.bgImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.bgImage1.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(113, 34));
    }];
    [self.titleImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bgImage2);
    }];
    [self.bgImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.bgImage2.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(145, 34));
    }];
    [self.titleImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bgImage3);
    }];
}
- (void)setStep:(NSInteger)step
{
    _step = step;
    _bgImage1.image =  [UIImage imageNamed:_step == 1 ? @"PT_verify_step_1_selected" : @"PT_verify_step_1_normal"];
    _bgImage2.image =  [UIImage imageNamed:_step == 2 ? @"PT_verify_step_2_selected" : @"PT_verify_step_2_normal"];
    _bgImage3.image =  [UIImage imageNamed:_step == 3 ? @"PT_verify_step_3_selected" : @"PT_verify_step_3_normal"];

}
-(UIImageView *)bgImage1{
    if (!_bgImage1) {
        _bgImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_verify_step_1_normal"]];
    }
    return _bgImage1;
}
-(UIImageView *)titleImage1{
    if (!_titleImage1) {
        _titleImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_verify_step_1_title"]];
    }
    return _titleImage1;
}
-(UIImageView *)bgImage2{
    if (!_bgImage2) {
        _bgImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_verify_step_2_normal"]];
    }
    return _bgImage2;
}
-(UIImageView *)titleImage2{
    if (!_titleImage2) {
        _titleImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_verify_step_2_title"]];
    }
    return _titleImage2;
}
-(UIImageView *)bgImage3{
    if (!_bgImage3) {
        _bgImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_verify_step_3_normal"]];
    }
    return _bgImage3;
}
-(UIImageView *)titleImage3{
    if (!_titleImage3) {
        _titleImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_verify_step_3_title"]];
    }
    return _titleImage3;
}
@end

@interface PTVerifyCountDownView ()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) QMUILabel *countDownLabel;
@property (nonatomic, strong) UIImageView *clockImageView;
@property (nonatomic, strong) UIImageView *rectClockImage;
@property(nonatomic, strong) PtVerifyCountDown *countDownTime;
@property (nonatomic, strong) UIImageView *shadowImage;
@property (nonatomic, strong) PTVerifyStepView *stepImage;

@end
@implementation PTVerifyCountDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setupUI{
    [self addSubview:self.shadowImage];
    [self addSubview:self.backImageView];
    [self addSubview:self.rectClockImage];
    [self addSubview:self.clockImageView];
    [self addSubview:self.countDownLabel];
    [self addSubview:self.stepImage];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo((kScreenWidth-32)/343*200.f);
    }];
    [self.rectClockImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(276*kScreenWidth/375, 65*kScreenWidth/375));
        make.top.mas_equalTo(80);
        make.centerX.mas_equalTo(0);
    }];
    [self.clockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(94, 94));
        make.top.mas_equalTo(35);
        make.right.mas_equalTo(self.rectClockImage.mas_right);
    }];
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.rectClockImage);
    }];
    [self.stepImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(31);
        make.right.mas_equalTo(-31);
        make.height.mas_equalTo(34);
        make.bottom.mas_equalTo(self.backImageView.mas_bottom).offset(-13);
    }];
    [self.shadowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(186);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo((kScreenWidth-32)/343*36.f);
    }];
   
}
- (void)setStep:(NSInteger)step
{
    _step = step;
    self.stepImage.step = step;
}
- (void)hiddenStep
{
    if (_step > 3) {
        //
        self.stepImage.hidden = YES;
        self.backImageView.image = [UIImage imageNamed:@"PT_verify_step_bg_small"];
        self.shadowImage.hidden = YES;
        [self.backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((kScreenWidth-32)/343*164.f);
        }];
        [self layoutIfNeeded];
    }else{
        self.backImageView.hidden = self.shadowImage.hidden = self.clockImageView.hidden = self.rectClockImage.hidden = YES;
        self.countDownLabel.hidden = YES;
        self.stepImage.hidden = NO;
        [self.stepImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
        }];
        [UIView animateWithDuration:0.3 animations:^{
            [self layoutIfNeeded];
        }];
    }
}
- (void)hiddenAllSub
{
    self.backImageView.hidden = self.shadowImage.hidden = self.clockImageView.hidden = self.rectClockImage.hidden = YES;
    self.countDownLabel.hidden = YES;
}
- (void)setCountTime:(NSInteger)countTime
{
    {
        _countTime = countTime;
        if(countTime <= 0){
            if (self.endBlock) {
                self.endBlock();
            }
            [self hiddenCountDown];
            return;
        }
        
        [self.countDownTime cmsCountDownWithSecond:countTime completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
            
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
            self.countDownLabel.text = [NSString stringWithFormat:@"%@ : %@ : %@",hourstr,minutestr,secondstr];

            if([hourstr isEqualToString:@"00"]
               &&[minutestr isEqualToString:@"00"]
               && [secondstr isEqualToString:@"00"]
               && self.endBlock){
                
                self.endBlock();
                [self hiddenCountDown];
            }
        }];
    }
}
- (void)hiddenCountDown{
//    self.countDownLabel.hidden = self.countClock.hidden = self.countIncreaseImage.hidden = YES;
}
- (QMUILabel *)countDownLabel
{
    if (!_countDownLabel) {
        _countDownLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(30) textColor:[UIColor blackColor]];
        _countDownLabel.text = @"00:00:00";
    }
    return _countDownLabel;
}
- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_verify_step_bg"]];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImageView;
}
- (UIImageView *)clockImageView
{
    if (!_clockImageView) {
        _clockImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_verify_step_clock"]];
    }
    return _clockImageView;
}
- (UIImageView *)rectClockImage
{
    if (!_rectClockImage) {
        _rectClockImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_verify_step_rect"]];
    }
    return _rectClockImage;
}
- (UIImageView *)shadowImage
{
    if (!_shadowImage) {
        _shadowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_verify_step_shadow"]];
    }
    return _shadowImage;
}
- (PtVerifyCountDown *)countDownTime{
    if(!_countDownTime){
        _countDownTime = [[PtVerifyCountDown alloc] init];
    }
    return _countDownTime;
}
- (PTVerifyStepView *)stepImage
{
    if (!_stepImage) {
        _stepImage = [[PTVerifyStepView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 34)];
    }
    return _stepImage;
}
@end
