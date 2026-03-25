//
//  PesoLiveVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoLiveVC.h"
#import "PesoLiveView.h"
#import "PesoLiveViewModel.h"
#import "PesoLiveModel.h"
#import "AAILivenessViewController.h"
#import "PesoHomeViewModel.h"
#import "PesoVerifyWanliuView.h"
@interface PesoLiveVC ()
@property (nonatomic, strong) PesoLiveView *liveView;
@property (nonatomic, strong) PesoLiveModel *model;
@property (nonatomic, strong) PesoLiveViewModel *viewModel;

@property(nonatomic, assign) BOOL liveFail;

@end

@implementation PesoLiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF
    [self.viewModel loadLiveRequestWithProductId:self.productId callback:^(PesoLiveModel *model) {
        weakSelf.model = model;
    }];
    [AAILivenessSDK initWithMarket: AAILivenessMarketPhilippines];
    // Do any additional setup after loading the view.
}
- (void)backClickAction
{
    [self wanliuAlert];
}
- (void)wanliuAlert{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    PesoVerifyWanliuView *alert = [[PesoVerifyWanliuView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    alert.step = 4;
    alert.confirmBlock = ^{
        [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
            
        }];
    };
    [alert show];
}
///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    [self wanliuAlert];
    return NO;
}
 - (void)createUI
{
    [super createUI];
    UIImageView *backImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"basic_bg"]];
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    backImage.frame = CGRectMake(0, 0, kScreenWidth, 260);
    [self.view addSubview:backImage];
    
    UIImageView *titleImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_title"]];
    titleImage.contentMode = UIViewContentModeScaleAspectFit;
    titleImage.frame = CGRectMake(0, kNavBarAndStatusBarHeight - 20, 222, 72);
    titleImage.centerX = kScreenWidth/2;
    [backImage addSubview:titleImage];
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_M(13) textColor:RGBA(0, 0, 0, 0.3)];
    titleL.frame = CGRectMake(0, titleImage.bottom+7, kScreenWidth, 30);
    titleL.numberOfLines = 0;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = @"Increase pass rate by 20% for a limited time!";
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"Increase pass rate by 20% for a limited time!"];
    [attr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:[@"Increase pass rate by 20% for a limited time!" rangeOfString:@"20%"]];
    [attr addAttributes:@{NSFontAttributeName:PH_Font_B(13)} range:[@"Increase pass rate by 20% for a limited time!" rangeOfString:@"20%"]];
    titleL.attributedText = attr;
    [backImage addSubview:titleL];
    
    
    _liveView = [[PesoLiveView alloc] initWithFrame:CGRectMake(0, backImage.bottom-60, kScreenWidth, kScreenHeight - backImage.bottom)];
    _liveView.layer.cornerRadius = 16;
    _liveView.layer.masksToBounds = YES;
    WEAKSELF
    _liveView.startBlock = ^{
        [weakSelf saveorStartAdvance];
    };
    [self.view addSubview:_liveView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self bringNavToFront];
}
- (void)routerUrl:(NSString *)url{
    [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:url];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
//开始活体
- (void)saveorStartAdvance{
    /**有 relation_id就直接上传*/
    WEAKSELF
    if (br_isNotEmptyObject(self.model.darythirteenmanNc)) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"point"] = [self getaSomeApiParam:self.productId sceneType:@"25"];
        dic[@"lietthirteenusNc"]= NotNil(self.productId);
        dic[@"alumthirteeninNc"] = NotNil(self.model.darythirteenmanNc);
        [self.viewModel loadSaveLiveRequestWithDic:dic productId:self.productId callback:^(NSString * url) {
//            if (PesoUserCenter.sharedPesoUserCenter.isaduit) {
//                [self removeViewController];
//                return;
//            }
            if (br_isNotEmptyObject(url)) {
                [self routerUrl:[url pinProductId:self.productId]];
                return;
            }
            PesoHomeViewModel *homeVM = [PesoHomeViewModel new];
            [homeVM loadPushRequestWithOrderId:PesoUserCenter.sharedPesoUserCenter.order product_id:weakSelf.productId callback:^(NSString *nexturl) {
                if (br_isNotEmptyObject(nexturl)) {
                    [self routerUrl:[nexturl pinProductId:self.productId]];
                    return;
                }
            }];
        }];
        return;
    }
    [self initAdvanceUI];
    [self.viewModel loadLiveLimitRequestWithProductId:self.productId callback:^(NSString *license) {
        [weakSelf startLivenWithLicense:license];
    }];
}
//初始化 sdk
- (void)initAdvanceUI {
    [AAILivenessSDK initWithMarket:AAILivenessMarketPhilippines];
    [AAILivenessSDK configResultPictureSize:800];
    // 设置是否检测人脸遮挡。默认值为“否”。
    //    [AAILivenessSDK configDetectOcclusion:YES];
    AAIAdditionalConfig *additionC = [AAILivenessSDK additionalConfig];
    additionC.detectionLevel = AAIDetectionLevelEasy;
}
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
                [strongSelf.viewModel loadLiveLDetctionRequestWithProductId:self.productId liveness_id:livenessId callback:^(NSString *relatin_id) {
                    weakSelf.model.darythirteenmanNc = relatin_id;
                    //发送保存请求
                    [weakSelf saveorStartAdvance];
                }];
            }else{
                [self liveAuthFail];
            }
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

        };
        vc.detectionFailedBlk = ^(AAILivenessViewController * _Nonnull rawVC, NSDictionary * _Nonnull errorInfo) {
            STRONGSELF
            [rawVC.navigationController qmui_popViewControllerAnimated:YES completion:nil];
            [strongSelf liveAuthFail];
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

        };
        [self.navigationController qmui_pushViewController:vc animated:YES completion:nil];
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
        [self.viewModel loadUploadLiveErrorRequestWithError:NotNil(checkResult)];
    }
}
- (void)liveAuthFail{
    [self.liveView updateUIFail];
    self.liveFail = YES;
}

- (PesoLiveViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [PesoLiveViewModel new];
    }
    return _viewModel;
}
@end
