//
//  XTOrderView.h
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTOrderView : UIView

@property(nonatomic,copy) XTBlock block;

- (instancetype)initWithFrame:(CGRect)frame xt_order_type:(NSString *)xt_order_type;

-(void)xt_reload;

@end

NS_ASSUME_NONNULL_END
