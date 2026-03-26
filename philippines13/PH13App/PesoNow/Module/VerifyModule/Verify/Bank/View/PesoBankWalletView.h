//
//  PesoBankWalletView.h
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import <UIKit/UIKit.h>
@class PesoBankWalletModel,PesoBankItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface PesoBankWalletView : UIView
- (void)updateUIWithModel:(PesoBankWalletModel *)model;
@property (nonatomic, copy) NSString *walletText;
@property (nonatomic, strong) PesoBankItemModel *selectModel;
@end

NS_ASSUME_NONNULL_END
