//
//  XTVerifyFaceVC.m
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import "XTVerifyFaceVC.h"
#import "XTSetAltView.h"
#import <YFPopView/YFPopView.h>
#import "XTVerifyViewModel.h"
#import "XTLocationManger.h"
#import <AAILivenessSDK/AAILivenessSDK.h>
#import <AAILivenessViewController.h>
#import "XTFaceModel.h"

@interface XTVerifyFaceVC ()

@property(nonatomic,strong) XTVerifyViewModel *viewModel;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,copy) NSString *startTime;

@property(nonatomic,strong) UILabel *alertLab;
@property(nonatomic,strong) UIButton *submitBtn;
@property(nonatomic,strong) UIButton *againBtn;

@end

@implementation XTVerifyFaceVC

- (instancetype)initWithProductId:(NSString *)productId
                          orderId:(NSString *)orderId {
    self = [super init];
    if(self) {
        self.productId = productId;
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([NSString xt_isEmpty:[XTLocationManger xt_share].xt_longitude] || [NSString xt_isEmpty:[XTLocationManger xt_share].xt_latitude]) {
        [[XTLocationManger xt_share] xt_startLocation];
    }
    self.startTime = [[XTUtility xt_share] xt_nowTimeStamp];
    self.xt_title = @"Facial Recognition";
    self.xt_title_color = [UIColor whiteColor];
    self.view.backgroundColor = XT_RGB(0xF2F5FA, 1.0f);

    [AAILivenessSDK initWithMarket:AAILivenessMarketPhilippines];
    @weakify(self)
    [self.viewModel xt_auth:self.productId success:^{
        @strongify(self)
        [self xt_UI];
    } failure:^{
        
    }];
    
}

-(void)xt_UI {
    UIView *topView = [UIView xt_frame:CGRectMake(0, CGRectGetMaxY(self.xt_navView.frame), self.view.width, 17) color:XT_RGB(0x0BB559, 1.0f)];
    [self.view addSubview:topView];
    UIImageView *topBGImg = [UIImageView xt_img:@"xt_verify_face_top_bg" tag:0];
    [self.view addSubview:topBGImg];
    [topBGImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(topView.mas_bottom);
    }];
    
    [self.view addSubview:self.alertLab];
    [self.alertLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(topBGImg.mas_bottom).offset(9);
        make.height.mas_equalTo(42);
    }];
    
    UIImageView *iconImg = [UIImageView xt_img:@"xt_verify_face_icon" tag:0];
    [self.view addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.alertLab.mas_bottom).offset(16);
    }];
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(iconImg.mas_bottom).offset(28);
        make.height.mas_equalTo(48);
    }];
    [self.view addSubview:self.againBtn];
    [self.againBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(iconImg.mas_bottom).offset(28);
        make.height.mas_equalTo(48);
    }];
    
    UIImageView *error1Img = [UIImageView xt_img:@"xt_verify_face_error_0" tag:0];
    [self.view addSubview:error1Img];
    [error1Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.submitBtn.mas_left).offset(11);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(47);
    }];
    
    UIImageView *error2Img = [UIImageView xt_img:@"xt_verify_face_error_1" tag:0];
    [self.view addSubview:error2Img];
    [error2Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(47);
    }];
    
    UIImageView *error3Img = [UIImageView xt_img:@"xt_verify_face_error_2" tag:0];
    [self.view addSubview:error3Img];
    [error3Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.submitBtn.mas_right).offset(-11);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(47);
    }];
}

//-(void)xt_back {
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//    XTSetAltView *altView = [[XTSetAltView alloc] initWithAlt:@"Are you sure you want to\n leave?"];
//    altView.center = self.view.center;
//    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:altView];
//    popView.animationStyle = YFPopViewAnimationStyleFade;
//    popView.autoRemoveEnable = YES;
//    [popView showPopViewOn:self.view];
//    __weak YFPopView *weakView = popView;
//    @weakify(self)
//    altView.sureBlock = ^{
//        [weakView removeSelf];
//        weakView.didDismiss = ^(YFPopView *popView) {
//            @strongify(self)
//            [self.navigationController popViewControllerAnimated:YES];
//        };
//    };
//    altView.cancelBlock = ^{
//        [weakView removeSelf];
//    };
//}

-(void)goCheck:(BOOL)is_again {
    if(![NSString xt_isEmpty:self.viewModel.faceModel.xt_relation_id]) {
        [self goSubmit:self.viewModel.faceModel.xt_relation_id];
        return;
    }
    [AAILivenessSDK initWithMarket:AAILivenessMarketPhilippines];
    [AAILivenessSDK configResultPictureSize:800];
    AAIAdditionalConfig *xt_additional = [AAILivenessSDK additionalConfig];
    xt_additional.detectionLevel = AAIDetectionLevelEasy;
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_limit:self.productId success:^{
        @strongify(self)
        [self.viewModel xt_licenseSuccess:^(NSString *str) {
            @strongify(self)
            [XTUtility xt_atHideProgress:self.view];
            [self goFaceUI:str again:is_again];
        } failure:^{
            @strongify(self)
            [XTUtility xt_atHideProgress:self.view];
        }];
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

-(void)goFaceUI:(NSString *)str again:(BOOL)is_again {
    @weakify(self)
    AAILivenessSDK.additionalConfig.detectionLevel = AAIDetectionLevelEasy;
    NSString *xt_status = [AAILivenessSDK configLicenseAndCheck:str];
    if([@"SUCCESS" isEqualToString:xt_status]) {
        AAILivenessViewController *vc = [[AAILivenessViewController alloc] init];
        vc.prepareTimeoutInterval = 100;
        [self.navigationController pushViewController:vc animated:YES];
        vc.detectionSuccessBlk = ^(AAILivenessViewController * _Nonnull rawVC, AAILivenessResult * _Nonnull result) {
            @strongify(self)
            NSString *xt_livenessId = result.livenessId;
            if(![NSString xt_isEmpty:xt_livenessId]) {
                [self xt_detection:xt_livenessId];
            }
            else {
                [self errorBtn];
            }
            [self.navigationController popViewControllerAnimated:YES];
        };
        vc.detectionFailedBlk = ^(AAILivenessViewController * _Nonnull rawVC, NSDictionary * _Nonnull errorInfo) {
            @strongify(self)
            [self errorBtn];
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
    else {
        [self errorBtn];
        [self.viewModel xt_auth_err:xt_status];
    }
}

-(void)errorBtn{
    self.submitBtn.hidden = YES;
    self.againBtn.hidden = NO;
    self.alertLab.text = @"Authentication failed, please try again！";
    self.alertLab.textColor = XT_RGB(0xCC0202, 1.0f);
}

-(void)xt_detection:(NSString *)xt_livenessId {
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_detectionProductId:self.productId livenessId:xt_livenessId success:^(NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [self goSubmit:str];
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

-(void)goSubmit:(NSString *)xt_relation_id{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:XT_Object_To_Stirng(self.productId) forKey:@"lietsixusNc"];
    [dic setObject:XT_Object_To_Stirng(xt_relation_id) forKey:@"alumsixinNc"];
    NSDictionary *point = @{
        @"deamsixatoryNc":XT_Object_To_Stirng(self.startTime),
        @"munisixumNc":XT_Object_To_Stirng(self.productId),
        @"hyrasixrthrosisNc":@"25",
        @"boomsixofoNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_latitude),
        @"unulsixyNc":XT_Object_To_Stirng([[XTUtility xt_share] xt_nowTimeStamp]),
        @"cacosixtomyNc":XT_Object_To_Stirng([XTDevice xt_share].xt_idfv),
        @"unevsixoutNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_longitude),
    };
    [dic setObject:point forKey:@"point"];
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_save_auth:dic success:^(NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [self goNext:str];
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

- (void)goNext:(NSString *)str{
//    if([XTUserManger xt_share].xt_user.xt_is_aduit){
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
    @weakify(self)
    if([NSString xt_isEmpty:str]) {
        [XTUtility xt_showProgress:self.view message:@"loading..."];
        [self.viewModel xt_push:self.orderId success:^(NSString *str) {
            @strongify(self)
            [XTUtility xt_atHideProgress:self.view];
            [[XTRoute xt_share] goHtml:str success:^(BOOL success) {
                @strongify(self)
                if(success){
                    [self xt_removeSelf];
                }
            }];
            
        } failure:^{
            @strongify(self)
            [XTUtility xt_atHideProgress:self.view];
        }];
        return;
    }
    [[XTRoute xt_share] goVerifyItem:str productId:self.productId orderId:self.orderId success:^(BOOL success) {
        @strongify(self)
        if(success){
            [self xt_removeSelf];
        }
    }];
}

-(void)xt_removeSelf {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [arr removeObject:self];
    self.navigationController.viewControllers = arr;
}

- (XTVerifyViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [[XTVerifyViewModel alloc] init];
    }
    return _viewModel;
}

- (UILabel *)alertLab {
    if(!_alertLab) {
        _alertLab = [UILabel xt_lab:CGRectZero text:@"To ensure it is operated by yourself, we\nneeds to verify your identity." font:XT_Font_M(15) textColor:XT_RGB(0x02CC56, 1.0f) alignment:NSTextAlignmentCenter tag:0];
        _alertLab.numberOfLines = 2;
    }
    return _alertLab;
}

- (UIButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [UIButton xt_btn:@"Start" font:XT_Font_B(20) textColor:[UIColor whiteColor] cornerRadius:24 tag:0];
        _submitBtn.backgroundColor = XT_RGB(0x02CC56, 1.0f);
        @weakify(self)
        _submitBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [self goCheck:NO];
            return [RACSignal empty];
        }];
    }
    return _submitBtn;
}
- (UIButton *)againBtn {
    if(!_againBtn) {
        _againBtn = [UIButton xt_btn:@"Try Again" font:XT_Font_B(20) textColor:XT_RGB(0x02CC56, 1.0f) cornerRadius:24 borderColor:XT_RGB(0x02CC56, 1.0f) borderWidth:1 backgroundColor:[UIColor clearColor] tag:0];
        _againBtn.hidden = YES;
        @weakify(self)
        _againBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [self goCheck:YES];
            return [RACSignal empty];
        }];
    }
    return _againBtn;
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
