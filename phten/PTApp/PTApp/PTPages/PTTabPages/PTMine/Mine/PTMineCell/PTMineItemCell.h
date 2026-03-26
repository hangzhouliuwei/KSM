//
//  PTMineItemCell.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PTMineItemModel;
@interface PTMineItemCell : UITableViewCell

-(void)configModel:(PTMineItemModel*)model;

@end

NS_ASSUME_NONNULL_END
