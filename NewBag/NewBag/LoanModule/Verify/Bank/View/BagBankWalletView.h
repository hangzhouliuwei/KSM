//
//  BagBankWalletView.h
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import <UIKit/UIKit.h>
@class BagBankWalletModel,BagBankItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagBankWalletView : UIView
- (void)updateUIWithModel:(BagBankWalletModel *)model;
@property (nonatomic, copy) NSString *walletText;
@property (nonatomic, strong) BagBankItemModel *selectModel;

@end

NS_ASSUME_NONNULL_END
