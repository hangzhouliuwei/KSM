//
//  PUBLiveViewController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/9.
//

#import "PUBLiveViewController.h"
#import "PUBBasicCountDownView.h"
#import "PUBLoanViewModel.h"
#import "PUBWanLiuView.h"

#import "PUBLiveViewModel.h"
#import "AAILivenessViewController.h"
#import "PUBLiveModel.h"

@interface PUBLiveViewController ()
@property(nonatomic, strong) PUBBasicCountDownView *downView;
@property(nonatomic, strong) UIImageView *nextTopImageView;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) PUBWanLiuView *wanLiuView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *liveImageView;
@property(nonatomic, strong) QMUILabel *tipLabel;
@property(nonatomic, strong) UIImageView  *tipImageView;
@property(nonatomic, strong) QMUIButton *startBtn;
@property(nonatomic, strong) PUBLoanViewModel *loanViewModel;
@property(nonatomic, strong) PUBLiveViewModel *viewModel;
@property(nonatomic, strong) PUBLiveModel *model;
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, assign) BOOL liveFail;
@end

@implementation PUBLiveViewController

/**
 1.点start的时候判断下初始化接口是否有ID，如果初始化有ID，说明已经做过活体了，这时候就直接调用保存接口
 如果初始化接口没有ID，说明没做过活体，调用次数接口，进行活体认证流程
 2.apply判断【ocr上传接口(advance ai)（第三项）】接口返回是否已经认证完成，若已经完成，直接调用【活体保存（第四项）】。若没有完成过，调用【活体认证次数限制接口（advance ai）(第四项)】接口
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.navBar.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    [self.navBar showtitle:@"Facial Recognition" isLeft:YES];
    [AAILivenessSDK initWithMarket: AAILivenessMarketPhilippines];
    [self creatUI];
    [self reponseData];
     self.startTime = [PUBTools getTime];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PUBTrackHandleManager trackAppEventName:@"af_pub_page_liveness" withElementParam:@{}];
    
}

- (void)backBtnClick:(UIButton *)btn
{
    [self.wanLiuView show:FacialType];
}

///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    [self.wanLiuView show:FacialType];
    return NO;
}

- (void)reponseData
{
    NSDictionary *dic = @{
                          @"perikaryon_eg":NotNull(self.productId),
                         };
    WEAKSELF
    [self.viewModel getCertifyLivenessView:self.view dic:dic finish:^(PUBLiveModel * _Nonnull model) {
        STRONGSELF
        strongSelf.model = model;
        [strongSelf updataCountDown:0];
    } failture:^{
        
    }];
    
}

- (void)creatUI
{
    self.contentView.height = KSCREEN_HEIGHT - self.navBar.bottom;
    [self.contentView addSubview:self.downView];
    [self.contentView addSubview:self.nextTopImageView];
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.liveImageView];
    [self.backView addSubview:self.tipLabel];
    [self.backView addSubview:self.tipImageView];
    [self.backView addSubview:self.startBtn];
    [self updataUI];
}

- (void)updataUI
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.top.mas_equalTo(8.f);
    }];
    
    [self.liveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(24.f);
        make.size.mas_equalTo(CGSizeMake(272.f, 168.f));
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.top.mas_equalTo(self.liveImageView.mas_bottom).offset(24.f);
    }];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(24.f);
        make.size.mas_equalTo(CGSizeMake(262.f, 98.f));
    }];
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipImageView.mas_bottom).offset(15.f);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(KSCREEN_WIDTH - 64.f, 48.f));
    }];
    
}

#pragma mark - 更新倒计时
- (void)updataCountDown:(NSInteger)countDown
{
    
    if(countDown > 0){
        self.downView.countTime = countDown;
        self.downView.hidden = NO;
        self.downView.height = 76.f;
        self.nextTopImageView.Y = self.downView.bottom + 8.f;
        self.backView.y = self.nextTopImageView.bottom + 8.f;
        self.backView.height = KSCREEN_HEIGHT - self.nextTopImageView.bottom - 8.f;
        return;
    }
    
    self.downView.countTime = 0;
    self.downView.hidden = YES;
    self.downView.height = 0;
    self.nextTopImageView.Y = 8.f;
    self.backView.y = self.nextTopImageView.bottom + 8.f;
    self.backView.height = KSCREEN_HEIGHT - self.nextTopImageView.bottom - 8.f;
    
}

- (void)startBtnClick
{
    if(![PUBTools isBlankString:self.model.oerlikon_eg]){
        [self savePhotoRequest];
        return;
    }
    
    [self advanceUI];
    [self livenessLimit];
}

///活体限制请求
- (void)livenessLimit
{
    NSDictionary *dic = @{
        @"perikaryon_eg":NotNull(self.productId)
                         };
    WEAKSELF
    [self.viewModel getLivenessLimitView:self.view dic:dic finish:^(NSDictionary * _Nonnull dic) {
        STRONGSELF
        [strongSelf liveAuthRequest];
    } failture:^{
        
    }];
}

///活体授权请求
- (void)liveAuthRequest
{
    WEAKSELF
    [self.viewModel getAdvanceLicenseView:self.view dic:@{} finish:^(NSDictionary * _Nonnull dic) {
        STRONGSELF
        NSString *licenseId = [NSString stringWithFormat:@"%@",dic[@"baulk_eg"]];
        [strongSelf license:licenseId];
    } failture:^{
        
    }];
    
}

#pragma mrak - 活体初始化页面
- (void)advanceUI {
    [AAILivenessSDK initWithMarket:AAILivenessMarketPhilippines];
    [AAILivenessSDK configResultPictureSize:800];
    // 设置是否检测人脸遮挡。默认值为“否”。
    //    [AAILivenessSDK configDetectOcclusion:YES];
    AAIAdditionalConfig *additionC = [AAILivenessSDK additionalConfig];
    additionC.detectionLevel = AAIDetectionLevelEasy;
}

#pragma mrak - 活体失败页面
- (void)liveAuthFail
{
    self.titleLabel.text = @"Recognition failed,please try again";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor qmui_colorWithHexString:@"#E56A56"];
    self.liveImageView.image = [UIImage imageNamed:@"pub_live_error"];
    [self.startBtn setTitle:@"Try again" forState:UIControlStateNormal];
    self.liveFail = YES;
}

#pragma mark - 上传活体认证ID
- (void)livenessDetectionLivenessId:(NSString*)livenessId
{
    NSDictionary *dic = @{
                          @"perikaryon_eg":NotNull(self.productId),
                          @"investigation_eg":NotNull(livenessId),
                         };
    WEAKSELF
    [self.viewModel getlivenessDetectionView:self.view dic:dic finish:^(NSDictionary * _Nonnull dic) {
        STRONGSELF
        NSString *oerlikon_eg = [NSString stringWithFormat:@"%@",dic[@"oversail_eg"]];
        strongSelf.model.oerlikon_eg = oerlikon_eg;
        [strongSelf savePhotoRequest];
    } failture:^{
        
    }];
    
}

- (void)license:(NSString*)license
{
    [PUBTrackHandleManager trackAppEventName:@"af_pub_page_liveness_sdk" withElementParam:@{}];
    if(self.liveFail){
        [PUBTrackHandleManager trackAppEventName:@"af_pub_page_liveness_sdk_again" withElementParam:@{}];
    }
    AAILivenessSDK.additionalConfig.detectionLevel = AAIDetectionLevelEasy;
    // License内容是您的服务器调用我们的openapi获取的。
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
            // Do something... (e.g., call anti-spoofing api to get score)
           
            [rawVC.navigationController qmui_popViewControllerAnimated:YES completion:nil];
            //[rawVC.navigationController dismissViewControllerAnimated:YES completion:nil];
            if(livenessId.length>0){
                [PUBTrackHandleManager trackAppEventName:@"af_pub_result_liveness" withElementParam:@{}];
                [strongSelf livenessDetectionLivenessId:livenessId];
            }else{
                [self liveAuthFail];
            }

        };
        vc.detectionFailedBlk = ^(AAILivenessViewController * _Nonnull rawVC, NSDictionary * _Nonnull errorInfo) {
            STRONGSELF
            [rawVC.navigationController qmui_popViewControllerAnimated:YES completion:nil];
            //[rawVC.navigationController dismissViewControllerAnimated:YES completion:nil];
            [strongSelf liveAuthFail];
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
        [self liveError:checkResult];
    }
}

- (void)savePhotoRequest
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSDictionary *pointDic = @{
                                @"testudinal_eg": @(self.startTime.doubleValue),
                                @"grouse_eg": NotNull(self.productId),
                                @"classer_eg":@"25",
                                @"neuroleptic_eg":@(PUBLocation.latitude),
                                @"milligramme_eg":@([PUBTools getTime].doubleValue),
                                @"infortune_eg": NotNull(NSObject.getIDFV),
                                @"nonrecurring_eg":@(PUBLocation.longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"perikaryon_eg"]= NotNull(self.productId);
    dic[@"copywriter_eg"] = NotNull(self.model.oerlikon_eg);
    WEAKSELF
    [self.viewModel saveLivenessView:self.view dic:dic finish:^(NSDictionary * _Nonnull dic) {
        STRONGSELF
        if(User.is_aduit){
            [strongSelf removeViewController];
            return;
        }
        NSString *nextStr = [NSString stringWithFormat:@"%@",dic[@"nonparticipant_eg"][@"excuse"]];
        if(![PUBTools isBlankString:nextStr]){
            [PUBRouteManager routeWitheNextPage:nextStr productId:NotNull(strongSelf.productId)];
            [strongSelf removeViewController];
            return;
        }
        [strongSelf productPush];
    } failture:^{
        
    }];
}

- (void)removeViewController
{
    NSMutableArray *VCArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [VCArr removeObject:self];
    self.navigationController.viewControllers =VCArr;
}

-(void)productPush
{
    NSDictionary *dic = @{
                          @"order_no":NotNull(Config.hypokinesis_eg),
                          @"furnisher_eg":@"dddd",
                          @"billyboy_eg":@"houijhyus",
                         };
    WEAKSELF
    [self.loanViewModel getproductPushView:self.view dic:dic finish:^(NSString * _Nonnull url) {
        STRONGSELF
        [PUBRouteManager routeWitheNextPage:url productId:@""];
        [strongSelf removeViewController];
    } failture:^{
        
    }];
}

- (void)liveError:(NSString*)Error
{
    NSDictionary *dic = @{
        @"oerlikon_eg":NotNull(Error)
                          };
    [self.viewModel getlivenessErrorView:self.view dic:dic finish:^{
        
    }  failture:^{
        
    }];
    
}

#pragma mark - lazy
- (PUBBasicCountDownView *)downView{
    if(!_downView){
        _downView = [[PUBBasicCountDownView alloc] initWithFrame:CGRectMake(20.f, 16.f, KSCREEN_WIDTH - 40.f, 76.f)];
        _downView.hidden = YES;
        WEAKSELF
        _downView.countDownEndBlock = ^{
          STRONGSELF
            [strongSelf updataCountDown:0];
        };
    }
    return _downView;
}

- (UIImageView *)nextTopImageView{
    if(!_nextTopImageView){
        _nextTopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_photos_next"]];
        _nextTopImageView.frame = CGRectMake(32.f, self.downView.bottom + 8, KSCREEN_WIDTH - 52.f ,0);
        _nextTopImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _nextTopImageView;
}


- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc] qmui_initWithSize:CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT - self.nextTopImageView.bottom + 8.f)];
        _backView.frame = CGRectMake(0, self.nextTopImageView.bottom + 8.f, KSCREEN_WIDTH, KSCREEN_HEIGHT - self.nextTopImageView.bottom + 8.f);
        [_backView showTopRarius: 24.f];
        _backView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1D2B"];
        //_backView.backgroundColor = [UIColor redColor];
    }
    return _backView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(17.f) textColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"To ensure it is operated by yourself, we needs to verify your identity";
    }
    return _titleLabel;
}

- (UIImageView *)liveImageView{
    if(!_liveImageView){
        _liveImageView = [[UIImageView alloc] init];
        _liveImageView.contentMode = UIViewContentModeScaleAspectFill;
        _liveImageView.image = [UIImage imageNamed:@"pub_live_certification"];
    }
    return _liveImageView;
}

- (QMUILabel *)tipLabel{
    if(!_tipLabel){
        _tipLabel = [[QMUILabel alloc] qmui_initWithFont:FONT(12.f) textColor:[UIColor whiteColor]];
        _tipLabel.textAlignment = NSTextAlignmentLeft;
        _tipLabel.text = @"Please take off your hat, align your face on the photo screen, and follow the verifation instructions";
        _tipLabel.numberOfLines = 0;
    }
    return _tipLabel;
}

- (UIImageView *)tipImageView{
    if(!_tipImageView){
        _tipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_live_tip"]];
        _tipImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _tipImageView;
}

-(QMUIButton *)startBtn{
    if(!_startBtn){
        _startBtn = [QMUIButton buttonWithType:UIButtonTypeSystem];
        [_startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _startBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
        _startBtn.cornerRadius = 24.f;
        _startBtn.titleLabel.font = FONT(20.f);
        [_startBtn setTitle:@"Start" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#13062A"] forState:UIControlStateNormal];
    }
    return _startBtn;
}

- (PUBWanLiuView *)wanLiuView{
    if(!_wanLiuView){
        _wanLiuView = [[PUBWanLiuView alloc] init];
        WEAKSELF
        _wanLiuView.confirmBlock = ^{
            STRONGSELF
            [strongSelf.wanLiuView hide];
            [strongSelf.navigationController qmui_popViewControllerAnimated:YES completion:nil];
            [PUBTrackHandleManager trackAppEventName:@"af_pub_page_liveness_exit" withElementParam:@{}];
        };
    }
    return _wanLiuView;
}

-(PUBLoanViewModel *)loanViewModel{
    if(!_loanViewModel){
        _loanViewModel = [[PUBLoanViewModel alloc] init];
    }
    return _loanViewModel;
}

- (PUBLiveViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PUBLiveViewModel alloc] init];
    }
    return _viewModel;
}

@end
