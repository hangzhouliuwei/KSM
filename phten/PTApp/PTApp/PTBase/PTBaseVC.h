//
//  PTBaseVC.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/16.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PTDisplayType) {
    PTDisplayTypeWhite,
    PTDisplayTypeBlack,
};
@interface PTBaseVC : QMUICommonViewController

/// nav背景视图
@property(nonatomic, strong) UIView *navView;
///nav 左边按钮
@property(nonatomic, strong) QMUIButton *leftBtn;
///标题
@property(nonatomic, strong) QMUILabel *titleLabel;
//进入 vc 的时间
@property(nonatomic, copy) NSString *startTime;

- (void)leftBtnClick;

- (void)removeViewController;

- (void)showtitle:(NSString*)title
           isLeft:(BOOL)isLeft
      disPlayType:(PTDisplayType)disPlayType;
- (void)showToast:(NSString *)text;
- (void)showToast:(NSString *)title duration:(CGFloat)duration;
@end

NS_ASSUME_NONNULL_END
