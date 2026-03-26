//
//  PUBContanctCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBContactItmeModel;
@interface PUBContanctCell : UITableViewCell
///关系选择
@property (nonatomic,copy) ReturnNoneBlock relationshipViewBlock;
///通讯录选择
@property (nonatomic,copy) ReturnNoneBlock contactViewBlock;
- (void)configModel:(PUBContactItmeModel*)model;

@end

NS_ASSUME_NONNULL_END
