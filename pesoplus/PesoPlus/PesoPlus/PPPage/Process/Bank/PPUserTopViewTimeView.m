//
//  PPUserTopViewTimeView.m
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import "PPUserTopViewTimeView.h"

@interface PPUserTopViewTimeView ()
@property (nonatomic, strong) UILabel *hourView;

@property (nonatomic, assign) NSInteger timeInter;
@property (nonatomic, weak) NSTimer *counterTimer;
@property (nonatomic, strong) UILabel *minView;
@property (nonatomic, strong) UILabel *secondView;
@end

@implementation PPUserTopViewTimeView

- (void)ppcancelNowControllerTimer {
    [self.counterTimer invalidate];
    self.counterTimer = nil;
}

- (void)dealloc {
    [self ppcancelNowControllerTimer];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self ppConfigAddViewShadow];
        
        UILabel *leadLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 20, 0, 40)];
        leadLabel.text = @"Increase pass rate by";
        leadLabel.font = FontBold(11);
        [leadLabel sizeToFit];
        leadLabel.textColor = TextBlackColor;
        leadLabel.h = 40;
        [self addSubview:leadLabel];
        
        UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(leadLabel.right, 20, 0, 40)];
        centerLabel.text = @" 20% ";
        centerLabel.textColor = rgba(237, 155, 5, 1);
        centerLabel.font = FontBold(11);
        [centerLabel sizeToFit];
        centerLabel.h = 40;
        [self addSubview:centerLabel];
        
        UILabel *endingLabel = [[UILabel alloc] initWithFrame:CGRectMake(centerLabel.right, 20, 0, 40)];
        endingLabel.text = @"for a limited time!";
        endingLabel.font = FontBold(11);
        [endingLabel sizeToFit];
        endingLabel.h = 40;
        endingLabel.textColor = TextBlackColor;

        [self addSubview:endingLabel];
        
        for (int i = 0; i < 3; i++) {
            UIImageView *bgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.w - 120, 27, 100, 26)];
            bgIcon.image =ImageWithName(@"time_bg");
            [self addSubview:bgIcon];
            
            self.hourView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 24, 26)];
            self.hourView.text = @"00";
            self.hourView.textColor = rgba(237, 155, 5, 1);
            self.hourView.font = FontCustom(12);
            self.hourView.textAlignment = NSTextAlignmentCenter;
            [bgIcon addSubview:self.hourView];
            
            self.minView = [[UILabel alloc] initWithFrame:CGRectMake(38, 0, 24, 26)];
            self.minView.text = @"00";
            self.minView.textColor = rgba(237, 155, 5, 1);
            self.minView.font = FontCustom(12);
            self.minView.textAlignment = NSTextAlignmentCenter;
            [bgIcon addSubview:self.minView];
            
            self.secondView = [[UILabel alloc] initWithFrame:CGRectMake(76, 0, 24, 26)];
            self.secondView.text = @"00";
            self.secondView.textColor = rgba(237, 155, 5, 1);
            self.secondView.font = FontCustom(12);
            self.secondView.textAlignment = NSTextAlignmentCenter;
            [bgIcon addSubview:self.secondView];
        }
    }
    return self;
}

- (void)startConfigTimer {
    self.counterTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countRefresh) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.counterTimer forMode:NSRunLoopCommonModes];
}

- (void)start:(NSInteger)time {
    self.timeInter = time;
    [self countRefresh];
    [self startConfigTimer];
}



- (void)countRefresh {
    NSString *minValue = [NSString stringWithFormat:@"%@", @((self.timeInter/60)%60)];
    NSString *secondsValue = [NSString stringWithFormat:@"%@", @(self.timeInter%60)];
    NSString *hourValue = [NSString stringWithFormat:@"%@", @(self.timeInter/3600)];
    if (hourValue.length == 1) {
        hourValue = [NSString stringWithFormat:@"0%@", hourValue];
    }
    if (minValue.length == 1) {
        minValue = [NSString stringWithFormat:@"0%@", minValue];
    }
    if (secondsValue.length == 1) {
        secondsValue = [NSString stringWithFormat:@"0%@", secondsValue];
    }
     
    self.hourView.text = hourValue;
    self.minView.text  = minValue;
    self.secondView.text  = secondsValue;

    if (self.timeInter == 0) {
        [self ppcancelNowControllerTimer];
        if (self.finishBlock) {
            self.finishBlock();
        }
    }
    self.timeInter--;
}



@end

