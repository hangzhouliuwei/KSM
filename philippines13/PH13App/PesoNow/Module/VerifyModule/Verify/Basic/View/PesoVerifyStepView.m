//
//  PesoVerifyStepView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/14.
//

#import "PesoVerifyStepView.h"
#import "PesoVerifyCountDown.h"
@interface PesoVerifyStepView()
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) QMUILabel *titleL;
@property(nonatomic, strong) PesoVerifyCountDown *countDownTime;
@end
@implementation PesoVerifyStepView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)setStep:(NSInteger)step
{
    _step = step;
    _image.image = [UIImage imageNamed:[NSString stringWithFormat:@"verify_step_%ld",(long)step]];
}
- (void)setCountTime:(NSInteger)countTime
{
    _countTime = countTime;
    
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
            self.titleL.text = [NSString stringWithFormat:@"%@ : %@ : %@",hourstr,minutestr,secondstr];

            if([hourstr isEqualToString:@"00"]
               &&[minutestr isEqualToString:@"00"]
               && [secondstr isEqualToString:@"00"]
               && self.endBlock){
                
                self.endBlock();
                [self hiddenCountDown];
            }
        }];
    
}
- (void)hiddenCountDown{
    
}
- (void)hiddenAllSub
{
    
}
- (void)createUI{
    UIImageView *image  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.frame = CGRectMake(0, 0, self.width, self.height);
    image.userInteractionEnabled = YES;
    [self addSubview:image];
    _image = image;
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(25) textColor:ColorFromHex(0xffffff)];
    titleL.frame = CGRectMake(40, 34, 150, 30);
    titleL.numberOfLines = 0;
    [image addSubview:titleL];
    _titleL = titleL;
    
}
- (PesoVerifyCountDown *)countDownTime{
    if(!_countDownTime){
        _countDownTime = [[PesoVerifyCountDown alloc] init];
    }
    return _countDownTime;
}
@end
