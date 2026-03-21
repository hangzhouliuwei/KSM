//
//  BagOrderNodataView.h
//  NewBag
//
//  Created by Jacky on 2024/4/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagOrderNodataView : UIView
@property (nonatomic, copy) dispatch_block_t applyBlock;
+ (instancetype)createView;
@end

NS_ASSUME_NONNULL_END
