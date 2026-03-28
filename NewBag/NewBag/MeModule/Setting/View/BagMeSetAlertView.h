//
//  BagMeSetAlertView.h
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagMeSetAlertView : UIView
+ (instancetype)createAlert;
- (void)showwithTitle:(NSString *)title;
- (void)updateUIWithTitle:(NSString *)title;
@property (nonatomic, copy) dispatch_block_t cancelBlock;

@property (nonatomic, copy) dispatch_block_t confirmBlock;
@end

NS_ASSUME_NONNULL_END
