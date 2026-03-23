//
//  AuthSelectAlertView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/4.
//

#import "AuthDateAlertView.h"

@implementation AuthDateAlertView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = kWhiteColor;
        [self clipTopLeftAndTopRightCornerRadius:12];
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeButton.frame = CGRectMake(self.width - 32 - 5, 13, 32, 32);
//        self.closeButton.backgroundColor = kBlueColor_0053FF;
        [self.closeButton setImage:kImageName(@"alert_close") forState:UIControlStateNormal];
        [self.closeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closeButton];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 22, self.width - 2 * 45, 50)];
        [_titleLabel pp_setPropertys:@[@(NSTextAlignmentCenter),kFontSize(18),kBlackColor_333333]];
        _titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20 + _titleLabel.bottom, self.width, 175)];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self addSubview:self.pickerView];
        [self initData];
        
        self.okButton= [UIButton buttonWithType:UIButtonTypeCustom];
        self.okButton.frame = CGRectMake(14, _pickerView.bottom + 5, self.width - 28, 47);
        self.okButton.backgroundColor = kBlueColor_0053FF;
        self.okButton.layer.cornerRadius = self.okButton.height / 2;
        [self.okButton setTitle:@"Ok" forState:UIControlStateNormal];
        [self.okButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [self.okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.okButton];
    }
    return self;
}
-(void)okButtonAction:(UIButton *)button
{
    NSString *day = self.dayArray[[self.pickerView selectedRowInComponent:0]];
    NSString *mon = self.monArray[[self.pickerView selectedRowInComponent:1]];
    NSString *year = self.yearArray[[self.pickerView selectedRowInComponent:2]];
    NSString *date = [NSString stringWithFormat:@"%@-%@-%@",day,mon,year];
    [self plp_dismiss];
    if (self.tapItemBlk) {
        self.tapItemBlk(date);
    }
}
-(void)setModel:(AuthOptionalModel *)model
{
    _model = model;
    NSString *day=@"",*mon=@"",*year=@"";
    if (model.valueStr.length > 0) {
        NSArray *array = [model.valueStr componentsSeparatedByString:@"-"];
        day = [NSString stringWithFormat:@"%02ld", [array.firstObject integerValue]];
        mon = [NSString stringWithFormat:@"%02ld", [array[1] integerValue]];
        year = [NSString stringWithFormat:@"%02ld", [array.lastObject integerValue]];
    }else
    {
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy"];
        NSString *str = [formatter stringFromDate:date];
        NSArray *array = [str componentsSeparatedByString:@"-"];
        day = [NSString stringWithFormat:@"%02ld", [array.firstObject integerValue]];
        mon = [NSString stringWithFormat:@"%02ld", [array[1] integerValue]];
        year = [NSString stringWithFormat:@"%02ld", [array.lastObject integerValue]];
    }
    NSInteger index_day = [self.dayArray indexOfObject:day];
    NSInteger index_mon = [self.monArray indexOfObject:mon];
    NSInteger index_year = [self.yearArray indexOfObject:year];
    [self.pickerView selectRow:index_day inComponent:0 animated:true];
    [self.pickerView selectRow:index_mon inComponent:1 animated:true];
    [self.pickerView selectRow:index_year inComponent:2 animated:true];
    self.titleLabel.text = model.fldgtwelveeNc;
 }
-(void)initData
{
    self.dataSource = [NSMutableArray array];
    self.dayArray = [NSMutableArray array];
    self.monArray = [NSMutableArray array];
    self.yearArray = [NSMutableArray array];
    [self.dataSource addObject:self.dayArray];
    [self.dataSource addObject:self.monArray];
    [self.dataSource addObject:self.yearArray];
    for (int i = 1960; i < 2044; i++) {
        [self.yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i = 1; i < 32; i++) {
        [self.dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    for (int i = 1; i < 13; i++) {
        [self.monArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    [self.pickerView reloadAllComponents];
}

-(void)generateDayArray:(NSInteger)year mon:(NSInteger)mon
{
    NSInteger count = 29;
    if((mon == 0)||(mon == 1)||(mon == 3)||(mon == 5)||(mon == 7)||(mon == 8)||(mon == 10)||(mon == 12)) {
        count = 31;
    }else if((mon == 4)||(mon == 6)||(mon == 9)||(mon == 11)) {
        count = 30;
    }else if((year%4 == 1)||(year%4 == 2)||(year%4 == 3)){
        count = 28;
    }else if(year%400 == 0) {
        count = 29;
    }else if(year%100 == 0) {
        count = 28;
    }
    [self.dayArray removeAllObjects];
    for(int i = 1; i < count + 1; i++) {
        [self.dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    [self.pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataSource.count;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenW - 30, 50)];
    [label pp_setPropertys:@[@(NSTextAlignmentCenter),kFontSize(16)]];
    label.textColor = row == [pickerView selectedRowInComponent:0] ? kBlueColor_0053FF : kGrayColor_999999;
    label.text = _dataSource[component][row];
    return label;;
}

// UIPickerView 每个组件的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *array = self.dataSource[component];
    return array.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *day = self.dayArray[[pickerView selectedRowInComponent:0]];
    NSString *mon = self.monArray[[pickerView selectedRowInComponent:1]];
    NSString *year = self.yearArray[[pickerView selectedRowInComponent:2]];
    
//    AuthItemModel *model = self.model.tubotwelvedrillNc[row];
    [self generateDayArray:year.intValue mon:mon.intValue];
    
    [pickerView reloadAllComponents];
}

-(void)buttonAction:(UIButton *)button
{
    [self plp_dismiss];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
