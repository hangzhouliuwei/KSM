//
//  PPUser.m
// FIexiLend
//
//  Created by jacky on 2024/11/1.
//

#import "PPUser.h"
#import "PPLoginPage.h"
#import "NSString+Adds.h"

@implementation PPUser

SingletonM(PPUser)

- (void)ppConfigUserAndSetupUserInfo {
    self.userName = [PPCacheConfigManager getStr:@"PPUserAcc"];
    self.sessionid = [PPCacheConfigManager getStr:@"PPUserSid"];
    self.token = [PPCacheConfigManager getStr:@"PPSessionToken"];
    self.appstore = [[PPCacheConfigManager getStr:@"PPCheckStoreAcc"] isEqualToString:@"1"];
    if (isBlankStr(self.userName) || isBlankStr(self.sessionid) || isBlankStr(self.token)) {
        self.isLogin = NO;
    }else {
        self.isLogin = YES;
    }
}
- (void)ppConfigUserAndClearUserInfo {
    self.isLogin = NO;
    self.userName = @"";
    self.token = @"";
    self.sessionid = @"";
    self.appstore = false;
}

- (void)login {
    PPLoginPage *login = [[PPLoginPage alloc] init];
    login.naviBarHidden = YES;
    login.modalPresentationStyle = UIModalPresentationFullScreen;
    [Page present:login animated:YES completion:nil];
}

- (void)ppConfigshowSuspend {
    self.suspend = [[PPDefaultCardPopView alloc] initWithFrame:CGRectMake(ScreenWidth - 75, StatusBarHeight + ScreenHeight/2, 70, 70) image:@"ic_service"];
    self.suspend.hidden = YES;
    kWeakself;
    self.suspend.clickBlock = ^{
        [weakSelf service];
    };
    [TopWindow addSubview:self.suspend];
}

- (void)ppConfighideSuspend {
    [self.suspend removeFromSuperview];
}

- (void)service {
    if (!User.isLogin) {
        [User login];
        return;
    }
    NSString *url = User.suspendDic[@""];
    if(isBlankStr(url)){
        return;
    }
    [Page pushToRootTabViewController:@"PPWKWebViewControllerPage" param:@{@"url":url, @"naviBarHidden":@(NO), @"title":@""}];
}

@end
