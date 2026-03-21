//
//  BagLoginPresenter.m
//  NewBag
//
//  Created by Jacky on 2024/3/21.
//

#import "BagLoginPresenter.h"
#import "BagLoginGetSMSCodeService.h"
#import "BagLoginService.h"
@interface BagLoginPresenter ()
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *smsCode;
@property (nonatomic, assign) BOOL protocolSelected;

@end
@implementation BagLoginPresenter
- (void)updatePhone:(NSString *)phone
{
    if (phone.length > 10) {
        [self.delegate updateNextBtnEnable:YES];
    }else{
        [self.delegate updateNextBtnEnable:NO];
    }
    _phone = phone;
}
- (void)updateSMSCode:(NSString *)code
{
    _smsCode = code;
}
- (void)updateProtocolSelect:(BOOL)state
{
    _protocolSelected = state;
}

- (void)sendGetSMSCodeRequest
{
    BagLoginGetSMSCodeService *service = [[BagLoginGetSMSCodeService alloc] initWithPhone:_phone];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self.delegate showToast:request.response_message duration:0.5];
            [self.delegate showLoginPage:YES];
            [self.delegate timerCountDown];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)sendLoginRequestWithStartTime:(NSString *)startTime code:(NSString *)code
{
    NSDictionary *pointDic = @{@"deamfourteenatoryNc":startTime,
                               @"munifourteenumNc":@"1",
                               @"hyrafourteenrthrosisNc":@"21",
                               @"boomfourteenofoNc":@([BagLocationManager shareInstance].latitude),//经度
                               @"unulfourteenyNc":[NSDate br_timestamp],
                               @"cacofourteentomyNc":[NSObject getIDFV],
                               @"unevfourteenoutNc":@([BagLocationManager shareInstance].longitude),//纬度
    };
    BagLoginService *service = [[BagLoginService alloc] initWithPhone:_phone code:code point:pointDic];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            //登录成功
            NSDictionary *data = request.responseObject;
            [[BagUserManager shareInstance] updateUserModelWithDic:data[@"viusfourteenNc"][@"gugofourteenyleNc"]];
            if ([self.delegate respondsToSelector:@selector(dissmiss)]) {
                [self.delegate dissmiss];
            }
            if ([self.delegate respondsToSelector:@selector(loginSuccessWithUid:)]) {
                [self.delegate loginSuccessWithUid:BagUserManager.shareInstance.uid];
            }
        }else{
            [self.delegate loginFaild];
            [self.delegate showToast:request.response_message duration:0.7];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}
@end
