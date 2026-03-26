//
//  AuthSelectAlertView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/4.
//

#import "AuthSelectAlertView.h"

@implementation AuthSelectAlertView
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
    AuthItemModel *model = nil;
    NSInteger index = [self.pickerView selectedRowInComponent:0];
    if(_model) {
        model = self.model.tubotwelvedrillNc[index];
    }
    [self plp_dismiss];
    if (self.tapItemBlk) {
        self.tapItemBlk(model,index);
    }
}
-(void)setModel:(AuthOptionalModel *)model
{
    _model = model;
    self.titleLabel.text = model.fldgtwelveeNc;
    [self.pickerView reloadAllComponents];
    if (model.selectedModel) {
        for(int i = 0; i < model.tubotwelvedrillNc.count; i++) {
            AuthItemModel *item = model.tubotwelvedrillNc[i];
            if ([model.selectedModel.itlitwelveanizeNc isReal]) {
                if ([model.selectedModel.itlitwelveanizeNc isEqualToString:item.itlitwelveanizeNc]) {
                    [self.pickerView selectRow:i inComponent:0 animated:false];
                }
            }else if ([model.selectedModel.uportwelvenNc isReal]) {
                if ([model.selectedModel.regntwelveNc integerValue] == [item.regntwelveNc integerValue]) {
                    [self.pickerView selectRow:i inComponent:0 animated:false];
                }
            }
         }
    }
    self.titleLabel.text = model.fldgtwelveeNc;
}
-(void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    [self.pickerView reloadAllComponents];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenW - 30, 50)];
    
    NSString *str = @"";
    if (_model) {
        AuthItemModel *model = self.model.tubotwelvedrillNc[row];
        str = model.uportwelvenNc;
    }else
    {
        str = _itemArray[row];
    }
    [label pp_setPropertys:@[@(NSTextAlignmentCenter),kFontSize(16),str]];
    label.textColor = row == [pickerView selectedRowInComponent:0] ? kBlueColor_0053FF : kGrayColor_999999;
    return label;;
}

// UIPickerView 每个组件的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_model) {
        return self.model.tubotwelvedrillNc.count;
    }
    return _itemArray.count;
}

// UIPickerView 选择后的回调
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
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
