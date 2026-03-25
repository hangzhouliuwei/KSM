//
//  PesoMineHeader.h
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoMineHeader : UIView
@property (nonatomic, copy) dispatch_block_t orderClickBlock;
@property (nonatomic, copy) dispatch_block_t borrowClickBlock;
- (void)updateUI;
@end

NS_ASSUME_NONNULL_END
