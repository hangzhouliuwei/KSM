//
//  BagIdentifyTxtCell.h
//  NewBag
//
//  Created by Jacky on 2024/4/10.
//

#import "BagBaseTableViewCell.h"
@class BagBasicRowModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagIdentifyTxtCell : BagBaseTableViewCell
- (void)updateUIWithModel:(BagBasicRowModel *)model;

@property (nonatomic,copy) void(^textBlock)(NSString *str);
//用户即将输入回调给埋点
@property (nonatomic,copy) void(^textBeginBlock)(void);
@end

NS_ASSUME_NONNULL_END
