//
//  PUBNavigationBar.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBNavigationBar : UIView

@property (nonatomic, copy) ReturnNoneBlock leftBtnClick;
@property (nonatomic, copy) ReturnNoneBlock rightBtnClick;
- (void)hideLeftBtn;
- (void)showLeftBtn;
- (void)hideRightBtn;
- (void)showRightBtn;

/// 页面标题显示
/// - Parameters:
///   - title: 标题
///   - isLeft: 是否靠右显示，默认居中显示
- (void)showtitle:(NSString*)title
         isLeft:(BOOL)isLeft;

@end

NS_ASSUME_NONNULL_END
