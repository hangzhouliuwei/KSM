//
//  PUBSetLogoutAlertView.h
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBSetLogoutAlertView : UIView
+ (instancetype) createAlertView;
- (void)showTiltle:(NSString*)tiltle;
@property (nonatomic, copy) dispatch_block_t cancelBlock;
@property (nonatomic, copy) dispatch_block_t confirmBlock;
@end

NS_ASSUME_NONNULL_END
