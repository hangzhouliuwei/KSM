//
//  PUBWalletAndBandView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBWalletAndBandView : UIView
@property (nonatomic,copy)ReturnIntBlock clickBtnBlock;
@property(nonatomic, assign) NSInteger  selecIndex;
- (void)selecIndexBtn:(NSInteger)selecIndex;
@end

NS_ASSUME_NONNULL_END
