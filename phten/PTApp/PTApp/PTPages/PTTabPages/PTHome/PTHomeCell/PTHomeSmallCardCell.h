//
//  PTHomeSmallCardCell.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PTHomeSmallCardItemModel;
@interface PTHomeSmallCardCell : UITableViewCell
@property(nonatomic, copy) PTStrBlock applyClickBloack;
-(void)configModel:(PTHomeSmallCardItemModel*)model;

@end

NS_ASSUME_NONNULL_END
