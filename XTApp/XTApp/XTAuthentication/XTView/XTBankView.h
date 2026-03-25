//
//  XTBankView.h
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XTBankItemModel;
@interface XTBankView : UIView
@property(nonatomic,weak) XTBankItemModel *model;
@property(nonatomic,copy) XTSelectBlock block;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *value;
@property(nonatomic,strong) UITextField *accountTextField;

@end

NS_ASSUME_NONNULL_END
