//
//  PTContactVerifyCell.h
//  PTApp
//
//  Created by Jacky on 2024/8/24.
//

#import "PTBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTContactVerifyCell : PTBaseTableViewCell
@property (nonatomic, copy) dispatch_block_t relationClick;
@property (nonatomic, copy) dispatch_block_t contactClick;

@end

NS_ASSUME_NONNULL_END
