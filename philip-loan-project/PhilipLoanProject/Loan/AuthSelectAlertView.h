//
//  AuthSelectAlertView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/4.
//

#import "PLPBaseAlertView.h"
#import "AuthOptionalModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AuthSelectAlertView : PLPBaseAlertView<UIPickerViewDelegate,UIPickerViewDataSource>


@property(nonatomic)UIPickerView *pickerView;
@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UIButton *closeButton;
@property(nonatomic)UIButton *okButton;
@property(nonatomic)AuthOptionalModel *model;

@property(nonatomic)NSArray *itemArray;



@property(nonatomic,copy)void(^tapItemBlk)(AuthItemModel *itemModel, NSInteger index);


@end

NS_ASSUME_NONNULL_END
