//
//  PUBMineHeaderView.h
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBMineHeaderView : UIView

+ (PUBMineHeaderView *)createHeader;
- (void)updateUIWithUsername:(NSString *)phone;

@property (nonnull, copy) dispatch_block_t goSetBlock;
@end

NS_ASSUME_NONNULL_END
