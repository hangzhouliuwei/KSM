//
//  PesoHomeListCell.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoHomeListCell : PesoBaseTableViewCell
//@property (nonatomic, copy) void(^applyBlock)(NSString *pro_id);
@property (nonatomic, copy) dispatch_block_t applyBlock;


@end

NS_ASSUME_NONNULL_END
