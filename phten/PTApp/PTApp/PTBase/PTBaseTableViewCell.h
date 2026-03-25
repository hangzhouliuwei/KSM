//
//  PTBaseTableViewCell.h
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PTBaseTableViewCellProtocol <NSObject>
@optional
- (void)configUIWithModel:(id)model;
- (void)setupUI;
@end
@interface PTBaseTableViewCell : UITableViewCell<PTBaseTableViewCellProtocol>

@end

NS_ASSUME_NONNULL_END
