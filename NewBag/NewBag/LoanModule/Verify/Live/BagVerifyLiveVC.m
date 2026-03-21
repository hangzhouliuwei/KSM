//
//  BagVerifyLiveVC.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyLiveVC.h"
#import "BagVerifyBasicCountDownView.h"
#import "BagVerifyLivePresenter.h"
#import "BagVerifyWanliuView.h"
#import "BagVerifyLiveEgView.h"
#import "AAILivenessViewController.h"
#import "BagVerifyLiveModel.h"
@interface BagVerifyLiveVC ()<BagVerifyLiveProtocol>
@property (nonatomic, strong) BagVerifyLivePresenter *presenter;
@property (nonatomic, strong) BagVerifyBasicCountDownView *countDownView;
@property (nonatomic, strong) BagVerifyLiveEgView *bgView;
@property(nonatomic, copy) NSString *startTime;
@property (nonatomic, strong) BagVerifyLiveModel *model;
@property(nonatomic, assign) BOOL liveFail;

@end

@implementation BagVerifyLiveVC

- (void)viewDidLoad {
    self.leftTitle = @"Facial Recognition";
    [super viewDidLoad];
    self.startTime = [NSDate br_timestamp];
    [self.view addSubview:self.countDownView];
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kNavBarAndStatusBarHeight +20);
    }];
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countDownView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(88+356);
    }];
    [self.bgView layoutIfNeeded];
    
    [AAILivenessSDK initWithMarket: AAILivenessMarketPhilippines];

    [self.presenter sendGetLiveRequestWithProductId:self.productId];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [BagTrackHandleManager trackAppEventName:@"af_cc_page_liveness" withElementParam:@{}];
}
//开始认证点击
- (void)startBtnClick
{
    /**有 relation_id就直接上传*/
    if (![self.model.daryfourteenmanNc br_isBlankString]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSDictionary *pointDic = @{
                                    @"deamfourteenatoryNc": @(self.startTime.doubleValue),
                                    @"munifourteenumNc": NotNull(self.productId),
                                    @"hyrafourteenrthrosisNc":@"25",
                                    @"boomfourteenofoNc":@(BagLocationManager.shareInstance.latitude),
                                    @"unulfourteenyNc":@([NSDate br_timestamp].doubleValue),
                                    @"cacofourteentomyNc": NotNull(NSObject.getIDFV),
                                    @"unevfourteenoutNc":@(BagLocationManager.shareInstance.longitude),
                                   };
        dic[@"point"] = pointDic;
        dic[@"lietfourteenusNc"]= NotNull(self.productId);
        dic[@"alumfourteeninNc"] = NotNull(self.model.daryfourteenmanNc);
        [self.presenter sendSaveLiveRequestWithDic:dic productId:self.productId];
        return;
    }
    
    [self advanceUI];
    [self.presenter sendLiveLimitRequestWithProductId:self.productId];
}
- (void)liveAuthFail{
    [self.bgView updateUIWithFail];
    self.liveFail = YES;
}
#pragma mark - 初始化活体 sdk
- (void)advanceUI {
    [AAILivenessSDK initWithMarket:AAILivenessMarketPhilippines];
    [AAILivenessSDK configResultPictureSize:800];
    // 设置是否检测人脸遮挡。默认值为“否”。
    //    [AAILivenessSDK configDetectOcclusion:YES];
    AAIAdditionalConfig *additionC = [AAILivenessSDK additionalConfig];
    additionC.detectionLevel = AAIDetectionLevelEasy;
}
#pragma mark - 开始活体认证
- (void)startLivenWithLicense:(NSString*)license
{
    [BagTrackHandleManager trackAppEventName:@"af_cc_page_liveness_sdk" withElementParam:@{}];
    if(self.liveFail){
        [BagTrackHandleManager trackAppEventName:@"af_cc_page_liveness_sdk_again" withElementParam:@{}];
    }
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
            NSLog(@">>>>>livenessId: %@, imgSize: %.2f, %.2f", livenessId, size.width, size.height);
            [rawVC.navigationController qmui_popViewControllerAnimated:YES completion:nil];
            if(livenessId.length>0){
                [BagTrackHandleManager trackAppEventName:@"af_cc_result_liveness" withElementParam:@{}];
                [strongSelf.presenter sendLiveLDetctionRequestWithProductId:self.productId liveness_id:livenessId];
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
        [self.presenter sendUploadLiveErrorRequestWithDic:@{@"":NotNull(checkResult)}];
    }
}
#pragma mark - 更新倒计时 view
- (void)updateCountDownView:(NSInteger)time{
    
}
#pragma mark - BagVerifyLiveProtocol
- (void)updateUIWithModel:(BagVerifyLiveModel *)model
{
    _model = model;
    [self updateCountDownView:0];
}
- (void)jumpNextPageWithProductId:(NSString *)product_id nextUrl:(NSString *)url
{
    [[BagRouterManager shareInstance] routeWithUrl:[url br_pinProductId:product_id]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
- (void)updateRelation_id:(NSString *)relation_id
{
    self.model.daryfourteenmanNc = relation_id;
    [self startBtnClick];
}
#pragma mark - nav back
- (void)backClick
{
    [self showWanliu];
}

- (void)showWanliu{
    BagVerifyWanliuView *view = [BagVerifyWanliuView createAlert];
    view.confirmBlock = ^{
        [BagTrackHandleManager trackAppEventName:@"af_cc_page_liveness_exit" withElementParam:@{}];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [view showWithType:VerifyFacialType];
}
///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    [self showWanliu];
    return NO;
}
#pragma mark - getter
- (BagVerifyLivePresenter *)presenter
{
    if (!_presenter) {
        _presenter = [BagVerifyLivePresenter new];
        _presenter.delegate= self;
    }
    return _presenter;
}
- (BagVerifyBasicCountDownView *)countDownView
{
    if (!_countDownView) {
        _countDownView = [BagVerifyBasicCountDownView createView];
        _countDownView.countDownEndBlock = ^{
            
        };
        [_countDownView hiddenStep];
        [_countDownView hiddenCountDown];
    }
    return _countDownView;
}
- (BagVerifyLiveEgView *)bgView
{
    if (!_bgView) {
        _bgView = [BagVerifyLiveEgView createView];
        WEAKSELF
        _bgView.startBlock = ^{
            STRONGSELF
            [strongSelf startBtnClick];
        };
    }
    return _bgView;
}

@end
