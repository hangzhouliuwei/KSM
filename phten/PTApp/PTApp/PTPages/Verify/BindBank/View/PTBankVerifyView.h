//
//  PTBankVerifyView.h
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import <UIKit/UIKit.h>
@class PTBankModel;
#import "PTBankWalletView.h"
#import "PTBankBankView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PTBankVerifyView : UIView
@property (nonatomic, assign) NSInteger selecctIndex;
@property (nonatomic, strong) PTBankWalletView *walletView;
@property (nonatomic, strong) PTBankBankView *bankView;
/**选中**/
@property (nonatomic, copy) void(^clickBlock)(NSInteger index);

- (void)updateUI:(PTBankModel *)model;

@end

NS_ASSUME_NONNULL_END
