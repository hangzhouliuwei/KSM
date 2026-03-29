//
//  DayPPNormalCardAlert.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "DayPPNormalCardAlert.h"

@interface DayPPNormalCardAlert ()

@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic ,strong) UIView *alertView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation DayPPNormalCardAlert

- (id)initWithData:(nullable NSString *)dateStr title:(NSString *)titleStr {
    self = [super init];
    if (self) {
        self.dateStr = dateStr;
        self.titleStr = titleStr;
        [self cantoFolderIsExtendUI];
    }
    return self;
}

- (void)cantoFolderdateChange:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy";
    _dateStr = [formatter stringFromDate:datePicker.date];
    NSLog(@"===%@",_dateStr);
}

- (void)selectAction {
    if (_dateStr.length > 0) {
        if (self.selectBlock) {
            self.selectBlock(_dateStr);
        }
    }
    [self hide];
}

- (void)cantoFolderIsExtendUI {
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    UIButton* bgViewGrey = [UIButton buttonWithType:UIButtonTypeCustom];
    bgViewGrey.backgroundColor = [UIColor blackColor];
    bgViewGrey.alpha = 0.3;
    bgViewGrey.frame = self.frame;

    [bgViewGrey addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgViewGrey];
    
    CGFloat alertWidth = ScreenWidth;
    CGFloat alertHeight = 400;
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - alertHeight, alertWidth, alertHeight)];
    _alertView.backgroundColor = UIColor.whiteColor;
    [_alertView showCponfigRadiusTop:16];
    [self addSubview:_alertView];
    
    UILabel *titleValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, 0, alertWidth - LeftMargin - 60, 66)];
    titleValueLabel.text = notNull(_titleStr);

    titleValueLabel.textAlignment = NSTextAlignmentCenter;
    titleValueLabel.font = Font(16);
    titleValueLabel.numberOfLines = 0;
    [_alertView addSubview:titleValueLabel];
    titleValueLabel.textColor = TextBlackColor;

    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(alertWidth - 55, 0, 55, 55);
    [closeBtn setImage:ImageWithName(@"close_alert") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:closeBtn];
    
    UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 66, SafeWidth, 0.8)];
    middleLine.backgroundColor = rgba(223, 237, 255, 1);
    [_alertView addSubview:middleLine];
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, titleValueLabel.bottom, alertWidth, 200)];
    if (@available(iOS 13.4, *)) {
        _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-AU"];
    _datePicker.frame = CGRectMake(0, titleValueLabel.bottom, alertWidth, 200);
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSInteger minValue = [self timeWithStringChange:@"01-01-1960" formatter:@"dd-MM-yyyy"];
    NSInteger maxValue = [self timeWithStringChange:@"31-12-2040" formatter:@"dd-MM-yyyy"];
    NSDate *minDateValue = [NSDate  dateWithTimeIntervalSince1970:minValue];
    NSDate *maxDateValue = [NSDate  dateWithTimeIntervalSince1970:maxValue];
    _datePicker.maximumDate = maxDateValue;
    _datePicker.minimumDate = minDateValue;
    [_datePicker addTarget:self action:@selector(cantoFolderdateChange:) forControlEvents:UIControlEventValueChanged];
    
    if (_dateStr.length == 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        _dateStr = [dateFormatter stringFromDate:[NSDate date]];
    }
    NSInteger times = [self timeWithStringChange:_dateStr formatter:@"dd-MM-yyyy"];
    _dateStr = [self strTransTimegChange:times formatter:@"dd-MM-yyyy"];
    NSDate *date = [NSDate  dateWithTimeIntervalSince1970:times];
    [_datePicker setDate:date animated:YES];
    
    [_alertView addSubview:_datePicker];
    
    UIButton *confirmItem = [PPKingHotConfigView normalBtn:CGRectMake(20, _datePicker.bottom + 15, alertWidth - 40, 48) title:@"Confirm" font:18];
    [_alertView addSubview:confirmItem];
    [confirmItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction)]];
}


- (void)show {
    CGFloat y = _alertView.y;
    _alertView.y = ScreenHeight;
    kWeakself;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = y;
    } completion:^(BOOL finished) {
        
    }];
    [TopWindow addSubview:self];
}


- (NSInteger)timeWithStringChange:(NSString *)dateStr formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSInteger time = (long)[date timeIntervalSince1970];
    return time;
}

- (void)bgBtnClick:(UIButton *)btn {
    [self hide];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSString *)strTransTimegChange:(NSInteger)time formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [NSDate  dateWithTimeIntervalSince1970:time];;
    return [dateFormatter stringFromDate:date];
}



@end

