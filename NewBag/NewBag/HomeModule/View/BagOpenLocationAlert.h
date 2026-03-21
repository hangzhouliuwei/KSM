//
//  BagOpenLocationAlert.h
//  NewBag
//
//  Created by Jacky on 2024/4/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagOpenLocationAlert : UIView
+ (instancetype)createView;
- (void)show;

@property (nonatomic, copy) dispatch_block_t clickBlock;
@end

NS_ASSUME_NONNULL_END
