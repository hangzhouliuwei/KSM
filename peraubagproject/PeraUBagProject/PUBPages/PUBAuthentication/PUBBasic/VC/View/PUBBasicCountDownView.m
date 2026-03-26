//
//  PUBBasicCountDownView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/2.
//

#import "PUBBasicCountDownView.h"
#import "PUBCountDown.h"

@interface PUBBasicCountDownView()
@property (nonatomic, strong) CAGradientLayer *backLayer;
@property(nonatomic, strong) YYLabel *tipLabel;
@property(nonatomic, strong) UIImageView *hourDownView;
@property(nonatomic, strong) UILabel *hourDownLabel;
@property(nonatomic, strong) UILabel *hourPint;

@property(nonatomic, strong) UIImageView *minuteDownView;
@property(nonatomic, strong) UILabel *minuteDownLabel;
@property(nonatomic, strong) UILabel *minutePint;

@property(nonatomic, strong) UIImageView *secondDownView;
@property(nonatomic, strong) UILabel *secondDownLabel;

@property(nonatomic, strong) PUBCountDown *countDownTime;
@end

@implementation PUBBasicCountDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.layer.cornerRadius = 24.f;
        [self ininSubViews];
        [self ininSubFrames];
    }
    return self;
}

- (void)ininSubViews
{
    [self.layer addSublayer:self.backLayer];
    [self addSubview:self.tipLabel];
    
    [self addSubview:self.hourDownView];
    [self.hourDownView addSubview:self.hourDownLabel];
    [self addSubview:self.hourPint];
    
    
    [self addSubview:self.minuteDownView];
    [self.minuteDownView addSubview:self.minuteDownLabel];
    [self addSubview:self.minutePint];
    
    
    [self addSubview:self.secondDownView];
    [self.secondDownView addSubview:self.secondDownLabel];

    
}

- (void)ininSubFrames
{
    self.backLayer.frame = self.bounds;
    self.tipLabel.frame = CGRectMake(0, 4.f, self.width, 14.f);
    self.hourDownView.frame = CGRectMake((KSCREEN_WIDTH - 240.f)/2.f, self.tipLabel.bottom + 5, 42.f, 42.f);
    
    [self.hourDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        
    }];
    
    self.hourPint.frame = CGRectMake(self.hourDownView.right + 10, self.tipLabel.bottom + 14, 10.f, 22.f);
    
    
    self.minuteDownView.frame = CGRectMake(self.hourPint.right + 10, self.tipLabel.bottom + 5, 42.f, 42.f);
    
    [self.minuteDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        
    }];
    
    self.minutePint.frame = CGRectMake(self.minuteDownView.right + 10, self.tipLabel.bottom + 14, 10.f, 22.f);
    
    
    self.secondDownView.frame = CGRectMake(self.minutePint.right + 10, self.tipLabel.bottom + 5, 42.f, 42.f);
    
    [self.secondDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];

}

-(void)setCountTime:(NSInteger)countTime
{
    _countTime = countTime;
    if(countTime < 0)return;
    
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
        
        strongSelf.hourDownLabel.text = NotNull(hourstr);
        strongSelf.minuteDownLabel.text = NotNull(minutestr);
        strongSelf.secondDownLabel.text = NotNull(secondstr);
        if([hourstr isEqualToString:@"00"]
           &&[minutestr isEqualToString:@"00"]
           && [secondstr isEqualToString:@"00"]
           && self.countDownEndBlock){
            
            self.countDownEndBlock();
        }
    }];
}

#pragma mark - lazy

-(CAGradientLayer *)backLayer{
    if (!_backLayer) {
        _backLayer = [[CAGradientLayer alloc] init];
        _backLayer.cornerRadius =24.f;
        _backLayer.masksToBounds = YES;
        _backLayer.startPoint = CGPointMake(1, 0);
        _backLayer.endPoint = CGPointMake(0, 1);
        _backLayer.colors = @[
            (__bridge id)UIColorFromHexF(0x8E3EFB, 1.0).CGColor,
            (__bridge id)UIColorFromHexF(0x5845F3, 1.0).CGColor
        ];
        _backLayer.locations = @[@0, @1];
    }
    return _backLayer;
    
}

- (YYLabel *)tipLabel{
    if(!_tipLabel){
        _tipLabel = [[YYLabel alloc] init];
        _tipLabel.font = FONT_Semibold(12.f);
        _tipLabel.textColor = [UIColor qmui_colorWithHexString:@"#FFFFFF"];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc]init];
        paragrapStyle.alignment = NSTextAlignmentCenter;//文字居中属性
        NSDictionary *attributes = @{NSFontAttributeName:FONT_Semibold(12.f), NSForegroundColorAttributeName: [UIColor qmui_colorWithHexString:@"#FFFFFF"],NSParagraphStyleAttributeName : paragrapStyle};
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString: @"Increase pass rate by 20% for a limited time!" attributes:attributes];
        [text yy_setTextHighlightRange:[[text string] rangeOfString:@"20%"] color:[UIColor qmui_colorWithHexString:@"#FFAE00"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        }];
        _tipLabel.attributedText = text;
    }
    return _tipLabel;
}

- (UIImageView *)hourDownView{
    if(!_hourDownView){
        _hourDownView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_baisc_timeBack"]];
    }
    return _hourDownView;
}

- (UILabel *)hourDownLabel{
    if(!_hourDownLabel){
        _hourDownLabel = [[UILabel alloc] qmui_initWithFont:FONT_Semibold(22.f) textColor:[UIColor blackColor]];
        _hourDownLabel.textAlignment = NSTextAlignmentCenter;
        _hourDownLabel.text = @"01";
    }
    return _hourDownLabel;
}

- (UILabel *)hourPint{
    if(!_hourPint){
        _hourPint = [[UILabel alloc] qmui_initWithFont:FONT_Semibold(22.f) textColor:[UIColor whiteColor]];
        _hourPint.textAlignment = NSTextAlignmentCenter;
        _hourPint.text = @":";
    }
    return _hourPint;
}



- (UIImageView *)minuteDownView{
    if(!_minuteDownView){
        _minuteDownView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_baisc_timeBack"]];
    }
    return _minuteDownView;
}

- (UILabel *)minuteDownLabel{
    if(!_minuteDownLabel){
        _minuteDownLabel = [[UILabel alloc] qmui_initWithFont:FONT_Semibold(22.f) textColor:[UIColor blackColor]];
        _minuteDownLabel.textAlignment = NSTextAlignmentCenter;
        _minuteDownLabel.text = @"01";
    }
    return _minuteDownLabel;
}

- (UILabel *)minutePint{
    if(!_minutePint){
        _minutePint = [[UILabel alloc] qmui_initWithFont:FONT_Semibold(22.f) textColor:[UIColor whiteColor]];
        _minutePint.textAlignment = NSTextAlignmentCenter;
        _minutePint.text = @":";
    }
    return _minutePint;
}


- (UIImageView *)secondDownView{
    if(!_secondDownView){
        _secondDownView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_baisc_timeBack"]];
    }
    return _secondDownView;
}

- (UILabel *)secondDownLabel{
    if(!_secondDownLabel){
        _secondDownLabel = [[UILabel alloc] qmui_initWithFont:FONT_Semibold(22.f) textColor:[UIColor blackColor]];
        _secondDownLabel.textAlignment = NSTextAlignmentCenter;
        _secondDownLabel.text = @"01";
    }
    return _secondDownLabel;
}

- (PUBCountDown *)countDownTime{
    if(!_countDownTime){
        _countDownTime = [[PUBCountDown alloc] init];
    }
    return _countDownTime;
}

@end
