//
//  PTVerifyEnumCell.h
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTVerifyEnumCell : PTBaseTableViewCell
- (void)clickAction;
@property (nonatomic, copy) dispatch_block_t clickBlock;
@end

NS_ASSUME_NONNULL_END
