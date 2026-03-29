//
//  PPUserDefaultViewWalletItem.h
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPUserDefaultViewWalletItem : UIView
@property (nonatomic, strong) NSMutableDictionary *saveDic;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *bankName;
- (id)initWithFrame:(CGRect)frame wallets:(NSArray *)arr data:(NSMutableDictionary *)saveDic;

@end

NS_ASSUME_NONNULL_END
