//
//  PesoHomeSmallCell.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoHomeSmallCell : PesoBaseTableViewCell
@property (nonatomic, copy) void(^applyBlock)(NSString *pro_id) ;
@end

NS_ASSUME_NONNULL_END
