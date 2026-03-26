//
//  AuthLivenessViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/5.
//

#import "PLPAuthLivenessViewController.h"
//#import "AAILivenessViewController.h"
@interface PLPAuthLivenessViewController ()

@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UIImageView *headImageView;
@property(nonatomic)UILabel *tipLabel;
@property(nonatomic)NSString *relation_id;
@property(nonatomic)UIView *errorView;
@property(nonatomic)UILabel *tryLabel;
@property(nonatomic)UIButton *nextButton;
@end

@implementation PLPAuthLivenessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 283);
    gradientLayer.colors = @[
        (__bridge id)kBlueColor_0053FF.CGColor,  // #2964F6
        (__bridge id)kHexColor(0xF5F5F5).CGColor   // #F9F9F9
    ];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    self.navigationItem.title = @"Facial Recognition";
    self.holdConetent = @"Boost your credit score by completing faciarecognition now.";
    self.shouldPopHome = true;
}
-(void)BASE_RequestHTTPInfo
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/auth" paramsInfo:@{@"liettwelveusNc":[PLPDataManager manager].productId} successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        NSDictionary *data = responseObject[@"viustwelveNc"];
        self.relation_id = data[@"prtotwelvezoalNc"][@"darytwelvemanNc"];
        
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(void)livenessFailure
{
    self.tryLabel.hidden = false;
    self.errorView.hidden = false;
    [self.nextButton setTitle:@"Try Again" forState:UIControlStateNormal];
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/auth_err" paramsInfo:@{@"darytwelvemanNc":@"CHECKING_OVER_QUERY_LIMIT"} successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(void)livenessSave
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    result[@"alumtwelveinNc"] = self.relation_id;
    result[@"point"] = [self BASE_GeneragePointDictionaryWithType:@"25"];
    result[@"liettwelveusNc"] = [PLPDataManager manager].productId;
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/saveauth" paramsInfo:result successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        NSDictionary *data = responseObject[@"viustwelveNc"][@"deectwelvetibleNc"];
        [self decodeAuthResponseData:data];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(void)uploadLivenessId:(NSString *)livenessId
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/detection" paramsInfo:@{@"liettwelveusNc":[PLPDataManager manager].productId,@"gyostwelveeNc":livenessId} successBlk:^(id  _Nonnull responseObject) {
        NSDictionary *data = responseObject[@"viustwelveNc"];
        self.relation_id = data[@"paaltwelveympicsNc"];
        [self livenessSave];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
    
}
-(void)handleNextButtonAction:(UIButton *)button
{
    kWeakSelf
    kShowLoading
    if ([self.relation_id isReal]) {
        [weakSelf livenessSave];
    }else
    {
//        [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/limit" paramsInfo:@{@"liettwelveusNc":[PLPDataManager manager].productId} successBlk:^(id  _Nonnull responseObject) {
//            [[PLPNetRequestManager plpJsonManager] GETURL:@"twelveca/license" paramsInfo:nil successBlk:^(id  _Nonnull res) {
//                kHideLoading
//                NSDictionary *data = res[@"viustwelveNc"];
//                NSString *tafytwelveNc = data[@"tafytwelveNc"];
//                [AAILivenessSDK initWithMarket:AAILivenessMarketPhilippines];
//                [AAILivenessSDK configResultPictureSize:800];
//                AAIAdditionalConfig *additionC = [AAILivenessSDK additionalConfig];
//                additionC.detectionLevel = AAIDetectionLevelEasy;
//                NSString *checkResult = [AAILivenessSDK configLicenseAndCheck:tafytwelveNc];
//                if ([checkResult isEqualToString:@"SUCCESS"]) {
//                    AAILivenessViewController *vc = [[AAILivenessViewController alloc] init];
//                    vc.prepareTimeoutInterval = 100;
//                    vc.detectionSuccessBlk = ^(AAILivenessViewController * _Nonnull liveVC, AAILivenessResult * _Nonnull result) {
//                        NSString *livenessId = result.livenessId;
//                        UIImage *bestImg = result.img;
//                        self.tryLabel.hidden = true;
//                        self.errorView.hidden = true;
//                        [self.nextButton setTitle:@"Start" forState:UIControlStateNormal];
////                        self.headImageView.image = bestImg;
//                        CGSize size = bestImg.size;
//                        weakSelf.navigationController.navigationBar.tintColor = kWhiteColor;
//                        [weakSelf.navigationController popViewControllerAnimated:YES];
//                        if(livenessId.length>0){
//                            [weakSelf uploadLivenessId:livenessId];
//                        }else{
//                            [weakSelf livenessFailure];
//                        }
//                    };
//                    vc.detectionFailedBlk = ^(AAILivenessViewController * _Nonnull rawVC, NSDictionary * _Nonnull errorInfo) {
//                        weakSelf.navigationController.navigationBar.tintColor = kWhiteColor;
//                        [weakSelf.navigationController popViewControllerAnimated:YES];
//                        [weakSelf livenessFailure];
//                    };
//                    vc.navigationItem.leftBarButtonItem.title = @"";
//                    self.navigationController.navigationBar.tintColor = kBlueColor_0053FF;
//                    [weakSelf.navigationController pushViewController:vc animated:YES];
//                }else
//                {
//                    [weakSelf livenessFailure];
//                }
//            } failureBlk:^(NSError * _Nonnull error) {
//                
//            }];
//        } failureBlk:^(NSError * _Nonnull error) {
//            
//        }];
        
        [self uploadLivenessId:@"234234"];
    }
}
-(void)BASE_GenerateSubview
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(15, 14 + kTopHeight, kScreenW - 30, 60)];
    headerView.layer.cornerRadius = 10;
    headerView.backgroundColor = kHexColor(0xECF3FF);
    [self.view addSubview:headerView];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((headerView.height - 22) / 2.0, (headerView.height - 22) / 2.0, 22, 22)];
    iconImageView.image = kImageName(@"liveness_icon");
    [headerView addSubview:iconImageView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, headerView.width - 70, headerView.height)];
    titleLabel.numberOfLines = 2;
    [titleLabel pp_setPropertys:@[@"The more the amount used / The higher the interest rate",kFontSize(14),kBlueColor_0053FF]];
    [headerView addSubview:titleLabel];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 184) / 2.0, 47 + headerView.bottom + 47, 184, 184)];
    self.headImageView.image = kImageName(@"");
    self.headImageView.layer.masksToBounds = self.headImageView.layer.cornerRadius = _headImageView.height / 2.0;
    self.headImageView.image = kImageName(@"liveness_head_0");
    [self.view addSubview:self.headImageView];
    self.errorView = [[UIView alloc] initWithFrame:self.headImageView.bounds];
    _errorView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.56];
    _errorView.layer.masksToBounds = _errorView.layer.cornerRadius = _errorView.height / 2.0;
    UIImageView *close = [[UIImageView alloc] initWithFrame:CGRectMake((_errorView.width - 42) / 2.0, (_errorView.width - 42) / 2.0, 42, 42)];
    close.image = kImageName(@"alert_close");
    [self.errorView addSubview:close];
    [self.headImageView addSubview:self.errorView];
    self.errorView.hidden = true;
    
    self.tryLabel = [[UILabel alloc] initWithFrame:CGRectMake(29, 27 + headerView.bottom, kScreenW - 58, 44)];
    self.tryLabel.backgroundColor = kHexColor(0xFFF5EC);
    [self.tryLabel pp_setPropertys:@[@"Authentication failed, please try again",@(NSTextAlignmentCenter), kFontSize(14),kHexColor(0xFE7500)]];
    self.tryLabel.layer.cornerRadius = _tryLabel.height / 2.0;
    self.tryLabel.hidden = true;
    [self.view addSubview:self.tryLabel];
    
    
    self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 16 + _headImageView.bottom, kScreenW - 60, 45)];
    self.tipLabel.numberOfLines = 2;
    [self.tipLabel pp_setPropertys:@[@"To ensure it is operated by yourself, weneeds to verify your identity.",kFontSize(16),kBlackColor_333333,@(NSTextAlignmentCenter)]];
    [self.view addSubview:self.tipLabel];
    
    CGFloat itemWidth = (kScreenW - 2 * 15 - 2 * 23) / 3.0;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23 + (itemWidth + 15) * i, 70 + self.tipLabel.bottom, itemWidth, itemWidth)];
        imageView.layer.masksToBounds = imageView.layer.cornerRadius = 6;
        NSString *name = [NSString stringWithFormat:@"liveness_head_%d",i + 1];
        imageView.image = kImageName(name);
        [self.view addSubview:imageView];
    }
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(14, kScreenH - 47 - kBottomSafeHeight - 16, kScreenW - 28, 47);
    [nextButton setTitle:@"Start" forState:UIControlStateNormal];
    [nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    nextButton.backgroundColor = kBlueColor_0053FF;
    nextButton.layer.cornerRadius = nextButton.height / 2.0;
    [nextButton addTarget:self action:@selector(handleNextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    self.nextButton = nextButton;
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
