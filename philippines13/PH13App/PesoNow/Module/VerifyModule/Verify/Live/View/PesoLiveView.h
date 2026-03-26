//
//  PesoLiveView.h
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoLiveView : UIView
@property (nonatomic, copy) dispatch_block_t startBlock;
- (void)updateUIFail;
@end

NS_ASSUME_NONNULL_END
