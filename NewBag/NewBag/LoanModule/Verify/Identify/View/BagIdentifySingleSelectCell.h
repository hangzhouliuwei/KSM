//
//  BagIdentifySingleSelectCell.h
//  NewBag
//
//  Created by Jacky on 2024/4/10.
//

#import "BagBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class BagBasicRowModel;
@interface BagIdentifySingleSelectCell : BagBaseTableViewCell
- (void)updateUIWithModel:(BagBasicRowModel *)model;
@property (nonatomic, copy) void(^selectBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
