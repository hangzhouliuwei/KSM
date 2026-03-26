//
//  PUBWalletView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBBankValuedEgModel,PUBBankLysinEgModel;
@interface PUBWalletView : UIView
@property(nonatomic, strong) PUBBankLysinEgModel *selecModel;
@property(nonatomic, copy) NSString *walletText;
- (void)updataModel:(PUBBankValuedEgModel*)model;
@end

NS_ASSUME_NONNULL_END
