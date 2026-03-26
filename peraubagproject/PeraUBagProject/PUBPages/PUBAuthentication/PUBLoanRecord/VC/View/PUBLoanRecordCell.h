//
//  PUBLoanRecordCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBVerifyItemModel;
@interface PUBLoanRecordCell : UICollectionViewCell
-(void) configModel:(PUBVerifyItemModel*)model;
@end

NS_ASSUME_NONNULL_END
