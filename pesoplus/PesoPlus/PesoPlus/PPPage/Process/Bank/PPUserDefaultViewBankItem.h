//
//  PPUserDefaultViewBankItem.h
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPUserDefaultViewBankItem : UIView
@property (nonatomic, strong) NSMutableDictionary *saveDic;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *bankName;
- (id)initWithFrame:(CGRect)frame banks:(NSArray *)arr data:(NSMutableDictionary *)saveDic;

@end

NS_ASSUME_NONNULL_END
