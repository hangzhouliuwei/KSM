//
//  PTHomeBigCardCell.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PTHomeLargeEcardItemModel;
@interface PTHomeBigCardCell : UITableViewCell
@property(nonatomic, copy) PTStrBlock applyClickBloack;
-(void)configModel:(PTHomeLargeEcardItemModel*)model;

@end

NS_ASSUME_NONNULL_END
