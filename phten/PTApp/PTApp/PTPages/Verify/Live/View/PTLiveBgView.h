//
//  PTLiveBgView.h
//  PTApp
//
//  Created by Jacky on 2024/8/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTLiveBgView : UIView
@property (nonatomic, copy) dispatch_block_t startBlock;
- (void)pt_updateUIFail;
@end

NS_ASSUME_NONNULL_END
