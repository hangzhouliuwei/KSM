//
//  BagBankSegmentView.h
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagBankSegmentView : UIView
@property (nonatomic, assign) NSInteger selecctIndex;
/**选中**/
@property (nonatomic, copy) void(^clickBlock)(NSInteger index);
/**init**/
+ (instancetype)createView;

@end

NS_ASSUME_NONNULL_END
