//
//  PUBLoanOverdueCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBLoanOverdueItmeModel;
@interface PUBLoanOverdueCell : UITableViewCell

@property(nonatomic, copy) ReturnStrBlock overdueClickBlock;

- (void)configModel:(PUBLoanOverdueItmeModel*)model;
@end

NS_ASSUME_NONNULL_END
