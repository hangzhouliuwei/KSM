//
//  BagChooseEnvPassView.h
//  NewBag
//
//  Created by Jacky on 2024/5/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagChooseEnvPassView : UIView
+ (instancetype)createView;
- (void)show;
@property (nonatomic, copy)dispatch_block_t succeedBlock;
@property (nonatomic, copy)dispatch_block_t failBlock;

@end

NS_ASSUME_NONNULL_END
