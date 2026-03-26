//
//  DataManager.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/27.
//

#import "PLPDataManager.h"
#import "PLPWebViewController.h"
#import "UIViewController+Category.h"
@implementation PLPDataManager

-(UIImageView *)callImageView
{
    if (!_callImageView) {
        _callImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW - 60, kTopHeight, 60, 60)];
        _callImageView.layer.masksToBounds = _callImageView.layer.cornerRadius = _callImageView.height / 2.0;
        _callImageView.userInteractionEnabled = true;
        [_callImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCallImageVIew)]];
        [_callImageView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]];
    }
    return _callImageView;
}
-(void)tapCallImageVIew
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    PLPWebViewController *vc = [PLPWebViewController new];
    vc.url = self.rightJumpURL;
    [[UIViewController getCurrentViewController].navigationController pushViewController:vc animated:YES];
}
-(void)panAction:(UIPanGestureRecognizer *)pan
{
    UIGestureRecognizerState state = pan.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [pan translationInView:[UIApplication sharedApplication].keyWindow];
            pan.view.center = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                if (self.callImageView.centerX > kScreenW / 2) {
                    self.callImageView.left = kScreenW - 60;
                }else
                {
                    self.callImageView.left = 0;
                }
                if (self.callImageView.top < kStatusHeight) {
                    self.callImageView.top = kStatusHeight;
                }
                if (self.callImageView.top > kScreenH - kBottomHeight - self.callImageView.height) {
                    self.callImageView.top = kScreenH - kBottomHeight - self.callImageView.height;
                }
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        default:
            break;
    }
    [pan setTranslation:CGPointMake(0, 0) inView:[UIApplication sharedApplication].keyWindow];
}



-(void)updateInfoWithResponseObject:(NSDictionary *)responseObject
{
    NSDictionary *dic = responseObject[@"viustwelveNc"][@"ieNctwelve"];
    self.serviceInfo = dic;
    self.vipShowImageURL = dic[@"intatwelventNc"];
    self.rightJumpURL = dic[@"kichtwelveiNc"];
    if (dic.allKeys.count > 0 && self.vipShowImageURL.length > 0 && self.rightJumpURL.length > 0) {
        [self.callImageView sd_setImageWithURL:kURL(self.vipShowImageURL)];
        self.showServerImageView = true;
        [[UIApplication sharedApplication].keyWindow addSubview:self.callImageView];
        self.callImageView.hidden = false;
    }else
    {
        self.callImageView.hidden = YES;
        self.showServerImageView = false;
    }
}


-(NSMutableDictionary *)controllerMap
{
    if (!_controllerMap) {
        _controllerMap = [NSMutableDictionary dictionary];
        _controllerMap[@"AATWELVEBO"] = @"PLPAuthInfoViewController";
        _controllerMap[@"AATWELVEBC"] = @"PLPAuthContactViewController";
        _controllerMap[@"AATWELVEBD"] = @"PLPAuthOCRViewController";
        _controllerMap[@"AATWELVEBP"] = @"PLPAuthLivenessViewController";
        _controllerMap[@"AATWELVEBE"] = @"PLPAuthCardViewController";
    }
    return _controllerMap;
}


+(instancetype)manager
{
    static PLPDataManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [PLPDataManager new];
    });
    return manager;
}

@end
