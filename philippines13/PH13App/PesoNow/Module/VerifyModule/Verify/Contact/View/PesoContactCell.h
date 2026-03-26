//
//  PesoContactCell.h
//  PesoApp
//
//  Created by Jacky on 2024/9/14.
//

#import "PesoBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoContactCell : PesoBaseTableViewCell
@property (nonatomic, copy) dispatch_block_t relationClick;
@property (nonatomic, copy) dispatch_block_t contactClick;
@end

NS_ASSUME_NONNULL_END
