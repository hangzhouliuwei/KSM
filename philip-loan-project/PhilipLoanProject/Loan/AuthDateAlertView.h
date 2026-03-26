//
//  AuthDateAlertView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/4.
//

#import "PLPBaseAlertView.h"
#import "AuthOptionalModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AuthDateAlertView : PLPBaseAlertView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic)UIPickerView *pickerView;
@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UIButton *closeButton;
@property(nonatomic)AuthOptionalModel *model;

@property(nonatomic)NSMutableArray *dataSource;

@property(nonatomic)NSMutableArray *dayArray;
@property(nonatomic)NSMutableArray *monArray;
@property(nonatomic)NSMutableArray *yearArray;

@property(nonatomic)NSInteger currentYear;
@property(nonatomic)NSInteger currentMonth;
@property(nonatomic)NSInteger currentDay;

@property(nonatomic)UIButton *okButton;

@property(nonatomic,copy)void(^tapItemBlk)(NSString *date);
@end

NS_ASSUME_NONNULL_END
