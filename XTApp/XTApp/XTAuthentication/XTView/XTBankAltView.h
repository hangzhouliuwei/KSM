//
//  XTBankAltView.h
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTBankAltView : UIView

- (instancetype)initTit:(NSString *)tit name:(NSString *)name account:(NSString *)account;
@property(nonatomic,copy) XTBlock submitBlock;
@property(nonatomic,copy) XTBlock cancelBlock;

@end

NS_ASSUME_NONNULL_END
