//
//  PesoOrderCell.h
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoOrderCell : PesoBaseTableViewCell
@property (nonatomic, copy) dispatch_block_t repayBlock;

@end

NS_ASSUME_NONNULL_END
