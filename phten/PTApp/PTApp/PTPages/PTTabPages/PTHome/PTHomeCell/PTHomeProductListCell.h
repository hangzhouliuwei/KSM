//
//  PTHomeProductListCell.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PTHomeProductListModel;
@interface PTHomeProductListCell : UITableViewCell

@property(nonatomic, copy) PTStrBlock applyClickBloack;

-(void)configModel:(PTHomeProductListModel*)model;

@end

NS_ASSUME_NONNULL_END
