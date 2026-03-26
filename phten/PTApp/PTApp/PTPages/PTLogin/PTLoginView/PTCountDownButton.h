//
//  PTCountDownButton.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PTCountDownButton;
typedef NSString* _Nullable (^CountDownChanging)(PTCountDownButton *countDownButton,NSUInteger second);
typedef NSString* _Nullable (^CountDownFinished)(PTCountDownButton *countDownButton,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(PTCountDownButton *countDownButton,NSInteger tag);

@interface PTCountDownButton : UIButton

@property(nonatomic, assign) NSInteger second;
@property(nonatomic,strong) id userInfo;
///倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
//倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;
//倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
///停止倒计时
- (void)stopCountDown;

@end

NS_ASSUME_NONNULL_END
