//
//  PUBLoanBannerCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBLoanBannerModel;
@interface PUBLoanBannerCell : UITableViewCell
@property(nonatomic, copy) ReturnObjectBlock bannerClickBlock;
- (void)configModel:(PUBLoanBannerModel*)model;

@end

NS_ASSUME_NONNULL_END
