//
//  PesoBankCredictView.h
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import <UIKit/UIKit.h>
#import "PesoBankWalletView.h"
#import "PesoBankBankView.h"
@class PesoBankModel;
NS_ASSUME_NONNULL_BEGIN

@interface PesoBankCredictView : UIView
@property (nonatomic, assign) NSInteger selecctIndex;
@property (nonatomic, strong) PesoBankWalletView *walletView;
@property (nonatomic, strong) PesoBankBankView *bankView;
@property (nonatomic, copy) void(^clickBlock)(NSInteger index);

- (void)updateUI:(PesoBankModel *)model;
@end

NS_ASSUME_NONNULL_END
