//
//  FacePageUserDefaultView.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "FacePageUserDefaultView.h"
#import "PPIconTitleButtonView.h"
#import "AAILivenessViewController.h"

@interface FacePageUserDefaultView ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableDictionary *needSaveDictData;
@property (nonatomic, strong) UIButton *nextSelectToTheItem;
@property (nonatomic, assign) BOOL isError;
@end

@implementation FacePageUserDefaultView

- (void)loadData {
    NSDictionary *dic = @{
        p_product_id: self.productId,
    };
    kWeakself;
    [Http post:R_facial params:dic success:^(Response *response) {
        if (response.success) {
            weakSelf.needSaveDictData = [NSMutableDictionary dictionaryWithDictionary:response.dataDic[p_card_two]];
            [weakSelf loadUI];
        }
        
    } failure:^(NSError *error) {
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    if (!self.canDiss) {
        return;
    }
    UINavigationController *navigationController = self.navigationController;
    if (navigationController && ![navigationController.viewControllers containsObject:self]) {
        return;
    }
    
    if (navigationController) {
        NSMutableArray *viewControllers = [navigationController.viewControllers mutableCopy];
        [viewControllers removeObject:self];
        navigationController.viewControllers = [viewControllers copy];
    }
}

- (void)saveToNextDataFaceInfo:(NSString *)value {
    if (isBlankStr(value)) {
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[p_liveness_r_id] = notNull(value);
    dic[p_product_id] = notNull(self.productId);
    dic[p_point] = [self track];
    kWeakself;
    [Http post:R_save_facial params:dic success:^(Response *response) {
        if (response.success) {
            weakSelf.canDiss = YES;
            [Route ppTextjumpToWithProdutId:weakSelf.productId];
        }else {
            [PPMiddleCenterToastView show:response.msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"======faild!");
    } showLoading:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.step = 3;
    self.title = @"Facial Recognition";
    [self loadData];
    
    _nextSelectToTheItem = [PPKingHotConfigView normalBtn:CGRectMake(34, self.view.h - SafeBottomHeight - 60, ScreenWidth - 68, 48) title:@"Start" font:24];
    [_nextSelectToTheItem setTitle:@"Try Again" forState:UIControlStateSelected];
    [self.view addSubview:_nextSelectToTheItem];
    [_nextSelectToTheItem showBottomShadow:COLORA(0, 0, 0, 0.2)];
    [_nextSelectToTheItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextAction)]];


}

- (void)loadUI {
    [self.content removeAllViews];
    self.content.backgroundColor = rgba(247, 251, 255, 1);
    CGFloat offsetY = 46;
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, offsetY, 200, 237)];
    image.image = ImageWithName(_isError ? @"face_error" : @"face_normal");
    [self.content addSubview:image];
    image.centerX = ScreenWidth/2;

    offsetY = image.bottom + 20;
    
    if (_isError) {
        PPIconTitleButtonView *wrongBtnItem = [[PPIconTitleButtonView alloc] initWithFrame:CGRectMake(25, offsetY, ScreenWidth - 50, 42) title:@"Authentication failed,please try again" color:UIColor.whiteColor font:14 icon:@"icon_tips"];
        wrongBtnItem.backgroundColor = rgba(255, 122, 122, 1);
        [wrongBtnItem showAddToRadius:21];
        [self.content addSubview:wrongBtnItem];
        
        offsetY = wrongBtnItem.bottom + 20;
    }
    UIImageView *infoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, offsetY, ScreenWidth - 50, 40)];
    infoImageView.image = ImageWithName(@"mid_desc");
    [self.content addSubview:infoImageView];
    infoImageView.centerX = ScreenWidth/2;

    offsetY = infoImageView.bottom + 20;
    
    UIImageView *infoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, infoImageView.bottom + 10, 256, 90)];
    infoImage.centerX = ScreenWidth/2;
    infoImage.image = ImageWithName(@"face_display");
    [self.content addSubview:infoImage];
    
    self.content.contentSize = CGSizeMake(ScreenWidth, infoImage.bottom + SafeBottomHeight + 70);
    
    _nextSelectToTheItem.selected = _isError;
}

- (void)nextAction {
    NSString *faceId = self.needSaveDictData[p_value];
    if (faceId.length > 0) {
        [self saveToNextDataFaceInfo:faceId];
        return;
    }
    [self configAASdk];
    [self liveFaceTimesLimit];
}

- (void)facegetError:(NSString*)Error {
    NSDictionary *dic = @{p_value:notNull(Error)};
    [Http post:R_facialError params:dic success:^(Response *response) {
    } failure:^(NSError *error) {
    }];
    
}

- (void)configAASdk {
    [AAILivenessSDK initWithMarket:AAILivenessMarketPhilippines];
    [AAILivenessSDK configResultPictureSize:800];
    AAIAdditionalConfig *additionC = [AAILivenessSDK additionalConfig];
    additionC.detectionLevel = AAIDetectionLevelEasy;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

- (void)liveFaceTimesLimit {
    NSDictionary *info = @{
        p_product_id: self.productId,
    };
    kWeakself;
    [Http post:R_facialTimes params:info success:^(Response *response) {
        if (response.success) {
            [weakSelf liveAuthRequest];
        }
    } failure:^(NSError *error) {
    } showLoading:YES];
}

- (void)liveAuthRequest {
    kWeakself;
    [Http post:R_faicalCertify params:@{} success:^(Response *response) {
        if (response.success) {
            NSString *licenseId = response.dataDic[p_license];
            [weakSelf openlicense:licenseId];
        }
    } failure:^(NSError *error) {
    } showLoading:YES];
}


- (void)uploadFaceId:(NSString*)livenessId {
    NSDictionary *dic = @{p_product_id: notNull(self.productId),
                          p_liveness_id:notNull(livenessId)};
    kWeakself;
    [Http post:R_facialUpload params:dic success:^(Response *response) {
        NSString *value = response.dataDic[p_relation_id];
        [weakSelf saveToNextDataFaceInfo:value];
    } failure:^(NSError *error) {
    }showLoading:YES];
    
}

- (void)faceAuthError {
    self.isError = YES;
    [self loadUI];
}

- (void)openlicense:(NSString*)license {
    AAILivenessSDK.additionalConfig.detectionLevel = AAIDetectionLevelEasy;
    NSString * checkResult = [AAILivenessSDK configLicenseAndCheck: license];
    if ([checkResult  isEqualToString : @"SUCCESS"]) {
        kWeakself;
        AAILivenessViewController *vc = [[AAILivenessViewController alloc] init];
        vc.prepareTimeoutInterval = 100;
        vc.detectionSuccessBlk = ^(AAILivenessViewController * _Nonnull rawVC, AAILivenessResult * _Nonnull result) {
            
            NSString *faceId = result.livenessId;
            [Page pop];
            if(faceId.length > 0){
                [weakSelf uploadFaceId:faceId];
            }else{
                [weakSelf faceAuthError];
            }
        };
        vc.detectionFailedBlk = ^(AAILivenessViewController * _Nonnull rawVC, NSDictionary * _Nonnull errorInfo) {
            [Page pop];
            [weakSelf faceAuthError];
        };
        [self.navigationController pushViewController:vc animated:NO];
    } else {
        [self faceAuthError];
    }
    
    if(![checkResult isEqualToString:@"SUCCESS"]){
        [self facegetError:checkResult];
    }
}


@end
