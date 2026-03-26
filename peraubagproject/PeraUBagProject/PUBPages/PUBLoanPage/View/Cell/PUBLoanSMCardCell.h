//
//  PUBLoanSMCardCell.h
//  PeraUBagProject
//  小卡位
//  Created by 刘巍 on 2023/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBLoanBgCardItemModel;
@interface PUBLoanSMCardCell : UITableViewCell
///申请按钮点击
@property(nonatomic, copy) ReturnStrBlock applyBtnClickBlock;
///协议点击
@property(nonatomic, copy) ReturnNoneBlock privacyClickBlock;

- (void)configModel:(PUBLoanBgCardItemModel*)model;
@end

NS_ASSUME_NONNULL_END
