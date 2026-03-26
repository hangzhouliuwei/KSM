//
//  BagLoginPresenter.h
//  NewBag
//
//  Created by Jacky on 2024/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BagLoginPresenterDelegate <NSObject,BagBaseProtocol>
/**更新下一步按钮**/
- (void)updateNextBtnEnable:(BOOL)enable;
/**展示输入手机号或输入验证码**/
- (void)showLoginPage:(BOOL)show;
/**开始倒计时**/
- (void)timerCountDown;
/**登录成功**/
- (void)loginSuccessWithUid:(NSInteger)uid;
- (void)loginFaild;
@end

@interface BagLoginPresenter : NSObject

@property (nonatomic, weak) id<BagLoginPresenterDelegate>delegate;
/**传入手机号文本给Presenter**/
- (void)updatePhone:(NSString *)phone;
/**传入验证码文本给Presenter**/
- (void)updateSMSCode:(NSString *)code;

- (void)updateProtocolSelect:(BOOL)state;

- (void)sendGetSMSCodeRequest;
- (void)sendLoginRequestWithStartTime:(NSString *)startTime code:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
