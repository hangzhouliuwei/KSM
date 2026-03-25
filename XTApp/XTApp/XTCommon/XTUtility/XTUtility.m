//
//  XTUtility.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTUtility.h"
#import "UIView+XTToast.h"
#import <MBProgressHUD.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "XTLoginCodeVC.h"

//弹框设置
#define AlertView_Duration 2
#define AlertView_Center @"center"

@implementation XTUtility

+(instancetype)xt_share {
    static XTUtility* shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

///显示菊花
+ (void)xt_showProgress:(UIView *)view message:(NSString *)msg {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view?view:XT_AppDelegate.window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = msg;
}

///隐藏菊花
+ (void)xt_hideProgress:(UIView*)view {
    dispatch_async(dispatch_get_main_queue(), ^{
       [MBProgressHUD hideHUDForView:view?view:XT_AppDelegate.window animated:NO];
    });
}
+ (void)xt_atHideProgress:(UIView*)view {
    [MBProgressHUD hideHUDForView:view?view:XT_AppDelegate.window animated:NO];
}

/// 对象转为json格式String
+ (NSString *)xt_objectToJSONString:(id)obj {
    if(!obj){
        return nil;
    }
    if([obj isKindOfClass:[NSString class]]){
        return obj;
    }
    if([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]){
        return [obj yy_modelToJSONString];
    }
    return nil;
}

+ (void)xt_showTips:(NSString *)str view:(UIView*)view {
    if (![str isKindOfClass:[NSString class]] || str.length == 0)
        return;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(view) {
            [view makeToast:str duration:AlertView_Duration position:AlertView_Center title:nil];
        }
        else {
            [XT_AppDelegate.window makeToast:str duration:AlertView_Duration position:AlertView_Center title:nil];
        }
    });
    
}

///删除文件
- (void)xt_removeFileWithPath:(NSString *)path {
    NSFileManager *file = [NSFileManager defaultManager];
    ///是否存在
    if ([file fileExistsAtPath:path]){
        NSError *error;
        [file removeItemAtPath:path error:&error];
        if(error){
            XTLog(@"删除文件失败:%@",error);
        }
    }
}

+ (NSString *)xt_urlEncode:(NSString *)urlStr {
    NSString *encodedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodedString;
}

//当前时间戳
- (NSString *)xt_nowTimeStamp{
    unsigned long long time = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%llu000",time];
}

///保存图片
- (NSString *)xt_saveImg:(NSData *)imgData path:(NSString *)path {
    NSString *fillPath = path;
    if([NSString xt_isEmpty:path]) {
        fillPath = [NSString stringWithFormat:@"%@/%@.jpg",XT_DocumentPath,[self xt_nowTimeStamp]];
    }
    [imgData writeToFile:fillPath atomically:YES];
    return fillPath;
}

#pragma mark 获取当前vc
+ (UIViewController *)xt_getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView;
    if([[window subviews] count] > 0)
    {
        frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            result = nextResponder;
        else
            result = window.rootViewController;
    }
    
    return result;
}

+ (UIViewController *)xt_getCurrentVCInNav
{
    id current = [XTUtility xt_getCurrentVC];
    UIViewController *currentVC;
    if([current isKindOfClass:[UINavigationController class]]){
        currentVC = ((UINavigationController *)current).visibleViewController;
    }
    else{
        currentVC = (UIViewController *)current;
    }
    return currentVC;
}

#pragma mark 相册权限
+ (void)xt_checkPhotoAuthorization:(void (^)(BOOL resultBool))successBlock {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusAuthorized) {
                // 用户同意授权
                successBlock(YES);
            }else {
                UIAlertController *altVC = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Please allow access to your phone's albums in the Settings - Privacy - Albums option on your iPhone" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                [altVC addAction:cancelAction];
                
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                }];
                
                [altVC addAction:sureAction];
                
                [[XTUtility xt_getCurrentVCInNav] xt_presentViewController:altVC animated:YES completion:nil modalPresentationStyle:UIModalPresentationFullScreen];
                successBlock(NO);
            }
        });
        
        
    }];
    
}
#pragma mark 相机权限
+ (void)xt_checkAVCaptureAuthorization:(void (^)(BOOL resultBool))successBlock {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                successBlock(YES);
            }else{
                UIAlertController *altVC = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Please allow access to your phone's camera in the Settings - Privacy - Camera option on your iPhone" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                [altVC addAction:cancelAction];
                
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                }];
                
                [altVC addAction:sureAction];
                
                [[XTUtility xt_getCurrentVCInNav] xt_presentViewController:altVC animated:YES completion:nil modalPresentationStyle:UIModalPresentationFullScreen];
                successBlock(NO);
            }
        });
        
    }];
}

+ (id)xt_objectFromJSON:(id)json{
    if (json == nil) {
        return nil;
    }
    if([json isKindOfClass:[NSDictionary class]]){
        return json;
    }
    NSData *jsonData;
    if([json isKindOfClass:[NSData class]]){
        jsonData = (NSData *)json;
    }
    else if([json isKindOfClass:[NSString class]]){
        jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    }
    else{
       return nil;
    }
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        XTLog(@"jsonData:  %@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        XTLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

+ (void)xt_login:(XTBlock)block {
    UIViewController *currentVC = [XTUtility xt_getCurrentVCInNav];
    if([currentVC isKindOfClass:NSClassFromString(@"XTLoginCodeVC")] || [currentVC isKindOfClass:NSClassFromString(@"XTLoginVC")]){
        return;
    }
    XTLoginCodeVC *loginVC = XT_Controller_Init(@"XTLoginCodeVC");
    XTNavigationController *nv = [[XTNavigationController alloc] initWithRootViewController:loginVC];
    [currentVC xt_presentViewController:nv animated:YES completion:^{
        
    } modalPresentationStyle:UIModalPresentationFullScreen];
    
    loginVC.loginBlock = ^{
        if(block) {
            block();
        }
    };
}

@end
