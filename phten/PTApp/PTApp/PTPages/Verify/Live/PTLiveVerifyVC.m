//
//  PTLiveVerifyVC.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTLiveVerifyVC.h"
#import "PTLiveBgView.h"
#import "PTLivePresenter.h"
#import "PTLiveVerifyModel.h"
#import "AAILivenessViewController.h"
#import "PTVerifyPleaseLeftView.h"
@interface PTLiveVerifyVC ()<PTLiveProtocol>
@property (nonatomic, strong) PTLiveBgView *bgView;
@property (nonatomic, strong) PTLivePresenter *presenter;
@property (nonatomic, strong) PTLiveVerifyModel *model;
@property(nonatomic, assign) BOOL liveFail;

@end

@implementation PTLiveVerifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showtitle:@"Facial Recognition" isLeft:NO disPlayType:PTDisplayTypeBlack];

    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarAndStatusBarHeight+10);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    [self.presenter pt_sendGetLiveRequestWithProductId:self.productId];
    [AAILivenessSDK initWithMarket: AAILivenessMarketPhilippines];
}
#pragma mark - nav back
- (void)leftBtnClick
{
    [self showWanliu];
}

- (void)showWanliu{
    
    PTVerifyPleaseLeftView *view = [[PTVerifyPleaseLeftView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.cancelBlock = ^{
        
    };
    view.confirmBlock = ^{
        [self.navigationController qmui_popViewControllerAnimated:YES completion:^{}];
    };
    view.step = 4;
    [view show];
    
}
///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self showWanliu];
    return NO;
}
#pragma mark - action

//开始活体
- (void)startAdvance{
    /**有 relation_id就直接上传*/
    if (![self.model.datenrymanNc br_isBlankString]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSDictionary *pointDic = @{
                                    @"detenamatoryNc": @(self.startTime.doubleValue),
                                    @"mutenniumNc": PTNotNull(self.productId),
                                    @"hytenrarthrosisNc":@"25",
                                    @"botenomofoNc":PTNotNull([PTLocationManger sharedPTLocationManger].latitude),
                                    @"untenulyNc":@([NSDate br_timestamp].doubleValue),
                                    @"catencotomyNc": PTNotNull([PTDeviceInfo idfv]),
                                    @"untenevoutNc":PTNotNull([PTLocationManger sharedPTLocationManger].longitude),
                                   };
        dic[@"point"] = pointDic;
        dic[@"litenetusNc"]= PTNotNull(self.productId);
        dic[@"altenuminNc"] = PTNotNull(self.model.datenrymanNc);
        [self.presenter pt_sendSaveLiveRequestWithDic:dic productId:self.productId];
        return;
    }
    
    [self advanceUI];
    [self.presenter pt_sendLiveLimitRequestWithProductId:self.productId];
}
//初始化 sdk
- (void)advanceUI {
    [AAILivenessSDK initWithMarket:AAILivenessMarketPhilippines];
    [AAILivenessSDK configResultPictureSize:800];
    // 设置是否检测人脸遮挡。默认值为“否”。
    //    [AAILivenessSDK configDetectOcclusion:YES];
    AAIAdditionalConfig *additionC = [AAILivenessSDK additionalConfig];
    additionC.detectionLevel = AAIDetectionLevelEasy;
}

- (void)liveAuthFail{
    [self.bgView pt_updateUIFail];
    self.liveFail = YES;
}
#pragma mark - PTLiveProtocol
- (void)updateUIWithModel:(PTLiveVerifyModel *)model
{
    _model = model;
}
- (void)router:(NSString *)url
{
    [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:url];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
- (void)updateRelation_id:(NSString *)relation_id
{
    self.model.datenrymanNc = relation_id;
    [self startAdvance];
}
//拿到授权开始认证
- (void)startLivenWithLicense:(NSString*)license
{
    AAILivenessSDK.additionalConfig.detectionLevel = AAIDetectionLevelEasy;
    // License内容是您的服务器调用我们的openapi获取的。
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    NSString * checkResult = [AAILivenessSDK configLicenseAndCheck: license];
    NSLog(@"lw======>checkResult%@",checkResult);
    if ([checkResult  isEqualToString : @"SUCCESS"]) {
        WEAKSELF
        // 许可证有效，显示SDK页面
        AAILivenessViewController *vc = [[AAILivenessViewController alloc] init];
        vc.prepareTimeoutInterval = 100;
        vc.detectionSuccessBlk = ^(AAILivenessViewController * _Nonnull rawVC, AAILivenessResult * _Nonnull result) {
            STRONGSELF
            NSString *livenessId = result.livenessId;
            UIImage *bestImg = result.img;
            CGSize size = bestImg.size;
            [rawVC.navigationController qmui_popViewControllerAnimated:YES completion:nil];
            if(livenessId.length>0){
//                [BagTrackHandleManager trackAppEventName:@"af_cc_result_liveness" withElementParam:@{}];
                [strongSelf.presenter pt_sendLiveLDetctionRequestWithProductId:self.productId liveness_id:livenessId];
            }else{
                [self liveAuthFail];
            }
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

        };
        vc.detectionFailedBlk = ^(AAILivenessViewController * _Nonnull rawVC, NSDictionary * _Nonnull errorInfo) {
            STRONGSELF
            [rawVC.navigationController qmui_popViewControllerAnimated:YES completion:nil];
            //[rawVC.navigationController dismissViewControllerAnimated:YES completion:nil];
            [strongSelf liveAuthFail];
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

        };
        [self.navigationController qmui_pushViewController:vc animated:YES completion:nil];
//        vc.modalPresentationStyle = UIModalPresentationFullScreen;
//        [self.navigationController presentViewController:vc animated:YES completion:nil];
    } else  if ([ checkResult  isEqualToString :@"LICENSE_EXPIRE" ]) {
        //“许可证_过期”
        [self liveAuthFail];
    } else  if ([checkResult  isEqualToString :@"APPLICATION_ID_NOT_MATCH" ]) {
        //“APPLICATION_ID_NOT_MATCH”
        [self liveAuthFail];
    }else{
        // 其他未知错误...
        [self liveAuthFail];
        NSLog(@"其他未知错误");
    }
    
    if(![checkResult isEqualToString:@"SUCCESS"]){
        [self.presenter pt_sendUploadLiveErrorRequestWithError:PTNotNull(checkResult)];
    }
}


#pragma mark -
- (PTLiveBgView *)bgView
{
    if (!_bgView) {
        _bgView = [[PTLiveBgView alloc] initWithFrame:CGRectZero];
        WEAKSELF
        _bgView.startBlock = ^{
            [weakSelf startAdvance];
        };
    }
    return _bgView;
}
- (PTLivePresenter *)presenter
{
    if (!_presenter) {
        _presenter = [[PTLivePresenter alloc]init];
        _presenter.delegate = self;
    }
    return _presenter;
}

@end
