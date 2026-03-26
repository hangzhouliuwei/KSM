//
//  PUBOrederDetailCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBOrederItemModel;
@interface PUBOrederDetailCell : UITableViewCell
@property (nonatomic, copy) ReturnObjectBlock cellBlock;
- (void)configModel:(PUBOrederItemModel*)model;

@end

NS_ASSUME_NONNULL_END
