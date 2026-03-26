//
//  PUBBirthdayView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/3.
//

#import "PUBBirthdayView.h"

@interface PUBBirthdayView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    //记录日期位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
}

@property (nonatomic ,strong) UIView *alertView;
@property (nonatomic ,strong)UIDatePicker *datePick;
@property (nonatomic, strong) NSString *selectDateStr;

@property (nonatomic, strong) UIPickerView *datePickerView;
@property (nonatomic, strong) NSArray *daysArray;
@property (nonatomic, strong) NSArray *monthsArray;
@property (nonatomic, strong) NSArray *yearsArray;

@property (nonatomic ,copy) NSString *dateStr;
@property (nonatomic, assign) BOOL isFinishInit;
@end

@implementation PUBBirthdayView

- (instancetype)init  {
    self = [super init];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enterBackGround:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];

    }
    return self;
}

- (void)enterBackGround:(NSNotificationCenter *)notification{
    [self removeFromSuperview];
}


- (void)loadUITitle:(NSString *)titleText {
    self.isFinishInit = false;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
    self.backgroundColor = [[UIColor qmui_colorWithHexString:@"#313848"] colorWithAlphaComponent:0.7f];
    
    self.alertView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT- 361.f*WScale - KSafeAreaBottomHeight, SCREEN_WIDTH,  361.f*WScale + KSafeAreaBottomHeight)];
    self.alertView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
    [self.alertView showTopRarius:12];
    [self addSubview:self.alertView];
    

    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 64.f)];
    topBackView.backgroundColor = [UIColor qmui_colorWithHexString:@"#444959"];
    [self.alertView addSubview:topBackView];
    
    
    CGFloat Hehgit = [PUBTools getTextHeightWithString:titleText font:FONT_BOLD(24.f) maxWidth:KSCREEN_WIDTH - 84.f numOfLines:0];
    UILabel *tipLabel = [[UILabel alloc] qmui_initWithFont:FONT_BOLD(24.f) textColor:[UIColor whiteColor]];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    tipLabel.frame = CGRectMake(20, 15.f, KSCREEN_WIDTH - 84.f, Hehgit);
    tipLabel.text = titleText;
    [topBackView addSubview:tipLabel];
    topBackView.height = 30.f + Hehgit;
    
    QMUIButton *closeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"pub_baisc_single_close"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(KSCREEN_WIDTH - 64.f, 10.f, 60.f, 30.f);
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topBackView addSubview:closeBtn];
    
    
    QMUIButton *nextBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(32.f, self.alertView.height - 48.f*WScale - KSafeAreaBottomHeight, KSCREEN_WIDTH - 64.f, 48.f * WScale);
    nextBtn.cornerRadius = 24.f;
    nextBtn.titleLabel.font = FONT(20.f);
    nextBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
    [nextBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#13062A"] forState:UIControlStateNormal];
    [nextBtn setTitle:@"OK" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:nextBtn];
    
    CGFloat datePickerViewH = self.alertView.height - 48.f*WScale - KSafeAreaBottomHeight - topBackView.bottom;
    self.datePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, topBackView.bottom, _alertView.width, datePickerViewH)];
    self.datePickerView.delegate = self;
    self.datePickerView.dataSource = self;
    [_alertView addSubview:self.datePickerView];
    
    // 初始化日期数据源数组
    self.daysArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31"];
    
    self.monthsArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    
    
    NSDateComponents *endDateComponents = [[NSDateComponents alloc] init];
    endDateComponents.day = 1;
    endDateComponents.month = 1;
    endDateComponents.year = 2043;
    NSInteger currentYear = [endDateComponents year];
    
    NSMutableArray *yearsMutableArray = [NSMutableArray array];
    for (NSInteger i = 1960; i <= currentYear; i++) {
        [yearsMutableArray addObject:[NSString stringWithFormat:@"%ld", i]];
    }
    self.yearsArray = [yearsMutableArray copy];
    
    static const unsigned componentFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSInteger MINYEAR = 1960;
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:componentFlags fromDate:[NSDate date]];
    
    yearIndex = components.year - MINYEAR;
    monthIndex = components.month - 1;
    dayIndex = components.day - 1;
    
    NSArray * indexArray = @[@(dayIndex),@(monthIndex),@(yearIndex)];
    
    [self.datePickerView reloadAllComponents];
    
    for (int i=0; i<indexArray.count; i++) {
        [self.datePickerView selectRow:[indexArray[i] integerValue] inComponent:i animated:YES];
    }
    
    if(self.dateStr.length<=0){
        self.dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld", components.day, (long)components.month, components.year];
    }
    
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, (_alertView.width - 2*16)/3, 40)];
    title1.text = @"Day";
    title1.textColor = LoginSelectColor;
    title1.font = FONT_BOLD(15);
    title1.textAlignment = NSTextAlignmentCenter;
    [_datePickerView addSubview:title1];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(title1.right, 0, (_alertView.width - 2*16)/3, 40)];
    title2.text = @"Month";
    title2.textColor = LoginSelectColor;
    title2.font = FONT(15);
    title2.textAlignment = NSTextAlignmentCenter;
    [_datePickerView addSubview:title2];
    
    UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(title2.right, 0, (_alertView.width - 2*16)/3, 40)];
    title3.text = @"Year";
    title3.textColor = LoginSelectColor;
    title3.font = FONT(15);
    title3.textAlignment = NSTextAlignmentCenter;
    [_datePickerView addSubview:title3];
    dispatch_after(0, dispatch_get_main_queue(), ^ {
        self.isFinishInit = true;
    });
}

- (void)okBtnClick:(QMUIButton *)btn {
    [self hide];
    if(self.dateStr.length<=0){
        return;
    }
    if(self.confirmBlock){
        self.confirmBlock(self.dateStr);
    }
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3; // 三个component：日、月、年
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        if (self.isFinishInit) {
            return [self daysCountOfMonth];
        }
        return self.daysArray.count;//[self daysCountOfMonth]; // 日
    } else if (component == 1) {
        return self.monthsArray.count; // 月
    } else {
        return self.yearsArray.count; // 年
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50*WScale;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //[self customSelectedRow];
    //设置文字的属性
    UILabel *bedTypeLabel = [UILabel new];
    bedTypeLabel.textAlignment = NSTextAlignmentCenter;

    if(component == 0){
        bedTypeLabel.text = self.daysArray[row];
    }else if (component == 1){
        bedTypeLabel.text = self.monthsArray[row];
    }else if (component == 2){
        bedTypeLabel.text = self.yearsArray[row];
    }
    bedTypeLabel.font = FONT(16);
    // 设置文字的颜色
   NSString *title = [self pickerView:pickerView titleForRow:row forComponent:component];
    NSDictionary *attributes = @{ NSForegroundColorAttributeName: (row == [pickerView selectedRowInComponent:component]) ? LoginSelectColor : COLOR(153, 153, 153)};
   NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    bedTypeLabel.attributedText = attributedTitle;

    if (self.subviews.count > 0) {
        pickerView.subviews[1].backgroundColor = [UIColor clearColor];// 去除原本的灰色背景
    }
    return bedTypeLabel;
}

-(NSInteger) daysCountOfMonth

{
    NSInteger month = [self.monthsArray[[_datePickerView selectedRowInComponent:1]] integerValue];
    if((month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12)) {
        return 31;
    }



    if((month == 4)||(month == 6)||(month == 9)||(month == 11)) {
        return 30;
    }


    NSInteger year = [self.yearsArray[[_datePickerView selectedRowInComponent:2]] integerValue];
    if(year % 4==0 && year % 100 !=0) {//普通年份，非100整数倍

        return 29;
    }

    if(year%400 == 0) {//世纪年份

        return 29;
    }

    return 28;

}

- (void)closeBtnClick
{
    [self hide];
}

////取到选中行背景的图层,修改颜色
//- (void)customSelectedRow {
//    NSArray *subviews = self.datePickerView.subviews;
//    if (!(subviews.count > 0)) {
//           return;
//       }
//    NSArray *coloms = subviews.firstObject;
//    if (coloms) {
//        NSArray *subviewCache = [coloms valueForKey:@"subviewCache"];
//        if (subviewCache.count > 0) {
//            UIView *middleContainerView = [subviewCache.firstObject valueForKey:@"middleContainerView"];
//            UIView *lineView = [[UIView alloc] qmui_initWithSize:CGSizeMake(SCREEN_WIDTH - 2*WScale*14, 0.5f)];
//            lineView.y = 0;
//            lineView.backgroundColor = [UIColor redColor];
//            [middleContainerView addSubview:lineView];
////            if (middleContainerView) {
////                middleContainerView.backgroundColor = COLOR(235, 255, 244);
////                middleContainerView.width = SCREEN_WIDTH - 2*WScale*14;
////                middleContainerView.centerX = self.datePickerView.centerX - 8;
////                [middleContainerView showRadius:8];
////            }
//        }
//    }
//}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.daysArray[row]; // 日
    } else if (component == 1) {
        return self.monthsArray[row]; // 月
    } else {
        return self.yearsArray[row]; // 年
    }
}

#pragma mark - UIPickerViewDataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    [pickerView reloadAllComponents];

    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
        NSString *selectedDay = self.daysArray[[pickerView selectedRowInComponent:0]]; // 获取当前选中的日
        NSString *selectedMonth = self.monthsArray[[pickerView selectedRowInComponent:1]]; // 获取当前选中的月
        NSString *selectedYear = self.yearsArray[[pickerView selectedRowInComponent:2]]; // 获取当前选中的年
        NSLog(@"selected date: %@ %@ %@", selectedDay, selectedMonth, selectedYear);

        self.dateStr = STR_FORMAT(@"%@-%@-%@",selectedDay,selectedMonth,selectedYear);
    });
}

- (void)show {
    CGRect rect = _alertView.frame;
    _alertView.frame = CGRectMake(rect.origin.x, SCREEN_HEIGHT, rect.size.width, rect.size.height);
    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.frame = rect;
    }completion:^(BOOL finished) {
        
    }];
    self.alpha = 1;
    if (IOS_VRESION_13) {
        [TOP_WINDOW addSubview:self];
    }else {
        [[VCManager topViewController].view addSubview:self];
    }
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)bgBtnClick:(UIButton *)btn {
    [self hide];
}


@end
