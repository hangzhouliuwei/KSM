//
//  XTSelectDayView.h
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTSelectDayView : UIView

- (instancetype)initTit:(NSString *)tit;

- (void)xt_value:(NSString *)value;

@property(nonatomic,copy) XTBlock closeBlock;
@property(nonatomic,copy) XTDicBlock sureBlock;

@end

NS_ASSUME_NONNULL_END
