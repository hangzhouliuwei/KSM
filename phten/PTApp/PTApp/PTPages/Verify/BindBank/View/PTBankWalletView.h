//
//  PTBankWalletView.h
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import <UIKit/UIKit.h>
@class PTBankWalletModel,PTBankItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface PTBankWalletView : UIView
- (void)updateUIWithModel:(PTBankWalletModel *)model;
@property (nonatomic, copy) NSString *walletText;
@property (nonatomic, strong) PTBankItemModel *selectModel;
@end

NS_ASSUME_NONNULL_END
