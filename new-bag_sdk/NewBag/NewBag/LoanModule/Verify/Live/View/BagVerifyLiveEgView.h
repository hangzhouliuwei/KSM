//
//  BagVerifyLiveEgView.h
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyLiveEgView : UIView
@property (nonatomic, copy) dispatch_block_t startBlock;

+ (instancetype)createView;
- (void)updateUIWithFail;
@end

NS_ASSUME_NONNULL_END
