//
//  PTHomeRidingLanternCell.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PTRidingLanternModel;
@interface PTHomeRidingLanternCell : UITableViewCell

-(void)configModel:(PTRidingLanternModel*)model;
@end

NS_ASSUME_NONNULL_END
