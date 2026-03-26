//
//  PUBLanMarketItemCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBLoanMarketItemModel;
@interface PUBLanMarketItemCell : UITableViewCell
///申请按钮点击
@property(nonatomic, copy) ReturnStrBlock applyBtnClickBlock;
- (void)configModel:(PUBLoanMarketItemModel*)model;
@end

NS_ASSUME_NONNULL_END
