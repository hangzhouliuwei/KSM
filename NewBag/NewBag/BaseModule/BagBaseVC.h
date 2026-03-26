//
//  BagBaseVC.h
//  NewBag
//
//  Created by Jacky on 2024/3/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagBaseVC : QMUICommonViewController
@property (nonatomic, copy) NSString *leftTitle;
/**默认导航栏返回键和文字都是白色，如果需要修改颜色设置leftTitleColor即可**/
@property (nonatomic, copy) NSString *leftTitleColor;

- (void)showToast:(NSString *)title duration:(CGFloat)duration;
- (void)dissmiss;
- (void)removeViewController;
/**返回**/
- (void)backClick;
@end

NS_ASSUME_NONNULL_END
