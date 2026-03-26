//
//  PUBBaseViewController.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/16.
//

#import "QMUICommonViewController.h"
#import "PUBNavigationBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface PUBBaseViewController : QMUICommonViewController
@property (nonatomic, strong) PUBNavigationBar *navBar;
//容器view代替self.view
@property (nonatomic,strong) UIView *contentView;
- (void)backBtnClick:(UIButton *)btn;
- (void)reponseData;
- (void)hiddeNarbar;
@end

NS_ASSUME_NONNULL_END
