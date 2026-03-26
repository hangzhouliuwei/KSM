//
//  PesoBaseVC.h
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoBaseVC : QMUICommonViewController
@property(nonatomic, copy) NSString *startTime;//vc加载时间
@property(nonatomic, copy) NSString *titleString;//title
@property(nonatomic, assign) BOOL hiddenBackBtn;//隐藏返回按钮 默认导航跟试图隐藏其他正常显示，有需要手动设置
- (NSDictionary *)getaSomeApiParam:(NSString *)product_id sceneType:(NSString *)type;
- (void)createUI;
- (void)backClickAction;
- (void)bringNavToFront;
- (void)removeViewController;
@end

NS_ASSUME_NONNULL_END
