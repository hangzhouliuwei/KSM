//
//  XTWalletView.h
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XTBankItemModel;
@class XTNoteModel;

@interface XTWalletView : UIView

@property(nonatomic,weak) UITextField *textField;
@property(nonatomic,weak) XTNoteModel *indexModel;
@property(nonatomic,weak) XTBankItemModel *model;

@end

NS_ASSUME_NONNULL_END
