//
//  XTBaseVC.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTBaseVC : UIViewController

@property(nonatomic,strong) UIView *xt_navView;
@property(nonatomic,strong) UIButton *xt_bkBtn;

@property(nonatomic,copy) NSString *xt_title;
@property(nonatomic,copy) UIColor *xt_title_color;
@property(nonatomic) XT_BackType xt_backType;

- (void)xt_back;

@end

NS_ASSUME_NONNULL_END
