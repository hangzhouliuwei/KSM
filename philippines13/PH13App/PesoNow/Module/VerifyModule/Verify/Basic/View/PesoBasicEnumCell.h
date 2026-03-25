//
//  PesoBasicEnumCell.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoBasicEnumCell : PesoBaseTableViewCell
@property (nonatomic, copy) dispatch_block_t clickBlock;
- (void)click;
@end

NS_ASSUME_NONNULL_END
