//
//  XTLoginVC.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTLoginVC.h"
#import "XTPhoneCodeApi.h"
#import "XTLoginViewModel.h"
#import "XTFirstApi.h"
#import <CRBoxInputView/CRBoxInputView.h>
#import "XTLocationManger.h"

@interface XTLoginVC ()

@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *countDown;
@property(nonatomic,copy) NSString *startTime;
@property(nonatomic,strong) UIButton *countDownBtn;
@property(nonatomic,strong) CRBoxInputView *codeInputView;
@property(nonatomic,strong) XTLoginViewModel *viewModel;

@end

@implementation XTLoginVC

- (instancetype)initPhone:(NSString *)phone countDown:(NSString *)countDown {
    self = [super init];
    if(self) {
        self.phone = XT_Object_To_Stirng(phone);
        self.countDown = XT_Object_To_Stirng(countDown);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.startTime = [[XTUtility xt_share] xt_nowTimeStamp];
    [[XTLocationManger xt_share] xt_startLocation];
    self.xt_bkBtn.hidden = YES;
    UIImageView *iconImg = [UIImageView xt_img:@"xt_login_icon" tag:0];
    [self.xt_navView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.xt_navView.mas_left).offset(20);
        make.centerY.equalTo(self.xt_bkBtn);
    }];
    
    UILabel *appNameLab = [UILabel xt_lab:CGRectZero text:XT_App_Name font:XT_Font_SD(16) textColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft tag:0];
    [self.xt_navView addSubview:appNameLab];
    [appNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).offset(10);
        make.centerY.equalTo(self.xt_bkBtn);
    }];
    
    self.xt_bkBtn.hidden = YES;
    UIImageView *bgImg = [UIImageView xt_img:@"xt_login_code_top_bg" tag:0];
    [self.view addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top);
    }];
    self.xt_navView.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.xt_navView];
    
    UIView *view = [UIView new];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 20;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(bgImg.mas_bottom).offset(-23);
        make.height.mas_equalTo(305);
    }];
    
    [view.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0xF3FF9B, 1.0f).CGColor,(__bridge id)XT_RGB(0xFFFFFF, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 0.48) size:CGSizeMake(self.view.width, 305)]];
    
    UIButton *backBtn = [UIButton new];
    [backBtn setImage:XT_Img(@"xt_login_back") forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(8);
        make.top.equalTo(view.mas_top).offset(12);
    }];
    @weakify(self)
    backBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [self xt_back];
        return [RACSignal empty];
    }];
    
    UILabel *titLab = [UILabel new];
    titLab.attributedText = [NSString xt_strs:@[@"Please",@"enter verification code"] fonts:@[XT_Font_M(31),XT_Font_M(17)] colors:@[XT_RGB(0x0BB559, 1.0f),[UIColor blackColor]]];
    [self.view addSubview:titLab];
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(27);
        make.top.equalTo(view.mas_top).offset(52);
        make.height.mas_equalTo(28);
    }];
    
    UIView *codeView = [UIView new];
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(titLab.mas_bottom).offset(20);
        make.size.mas_equalTo(self.codeInputView.size);
    }];
    [codeView addSubview:self.codeInputView];
    
    [self.view addSubview:self.countDownBtn];
    [self.countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-20);
        make.top.equalTo(codeView.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(72, 32));
    }];
    
    UILabel *subLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font(14) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
    subLab.numberOfLines = 2;
    [self.view addSubview:subLab];
    [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(20);
        make.right.equalTo(self.countDownBtn.mas_left).offset(-20);
        make.top.equalTo(codeView.mas_bottom).offset(26);
    }];
    subLab.attributedText = [NSString xt_strs:@[@"SMS verification code has been sent to\n",self.phone] fonts:@[XT_Font_M(13),XT_Font_M(13)] colors:@[[UIColor blackColor],XT_RGB(0x0BB559, 1.0f)]];
    
//    UILabel *descLab = [UILabel xt_lab:CGRectZero text:@"Get Voice Verification Code" font:XT_Font_M(10) textColor:XT_RGB(0x232323, 1.0f) alignment:NSTextAlignmentLeft tag:0];
//    [self.view addSubview:descLab];
//    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(view.mas_right).offset(-20);
//        make.top.equalTo(self.countDownBtn.mas_bottom).offset(25);
//        make.height.mas_equalTo(15);
//    }];
}

-(void)reloadCountDown:(NSString *)countDown {
    self.countDown = countDown;
    if([countDown integerValue] > 0){
        self.countDownBtn.userInteractionEnabled = NO;
        [self.countDownBtn setTitle:[NSString stringWithFormat:@"%@s",countDown] forState:UIControlStateNormal];
    }
    else {
        self.countDownBtn.userInteractionEnabled = YES;
        [self.countDownBtn setTitle:@"Resend" forState:UIControlStateNormal];
    }
}


- (void)goLogin:(NSString *)phone code:(NSString *)code {
    NSDictionary *dic = @{
        @"stwasixrdessNc":phone,//手机号
        @"firosixticNc":code,//验证码
        @"latesixscencyNc":@"duiuyiton",//干扰字段
        @"point":@{
            @"deamsixatoryNc":XT_Object_To_Stirng(self.startTime),
            @"munisixumNc":@"1",
            @"hyrasixrthrosisNc":@"21",//注册
            @"boomsixofoNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_latitude),//维度
            @"unulsixyNc":XT_Object_To_Stirng([[XTUtility xt_share] xt_nowTimeStamp]),//发起请求时间
            @"cacosixtomyNc":XT_Object_To_Stirng([XTDevice xt_share].xt_idfv),
            @"unevsixoutNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_longitude),//经度
        }
    };
    @weakify(self)
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    [self.viewModel getLogin:dic success:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        if(self.loginBlock) {
            self.loginBlock();
        }
        ///说明是弹出
        if(XT_AppDelegate.xt_nv){
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
            }];
        }
        else {
            [XT_AppDelegate xt_mainView];
        }
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [self.codeInputView clearAll];
    }];
}

- (CRBoxInputView *)codeInputView {
    if(!_codeInputView) {
        float itemH = 48.0f;
        CRBoxInputCellProperty *property = [CRBoxInputCellProperty new];
        property.cellCursorColor = XT_RGB(0x0BB559, 1.0f);
        property.cornerRadius = 1;
        property.borderWidth = 1;
        property.cellBorderColorFilled = XT_RGB(0x0BB559, 1.0f);
        property.cellBorderColorSelected = XT_RGB(0x0BB559, 1.0f);
        property.cellBorderColorNormal = XT_RGB(0x0BB559, 1.0f);
        property.cellFont = XT_Font_M(31);
        property.cellTextColor = XT_RGB(0x0BB559, 1.0f);

        NSInteger num = 6;
        NSInteger space = 5;
        
        CRBoxInputView *inputView = [[CRBoxInputView alloc] initWithCodeLength:num];
        inputView.frame = CGRectMake(0, 0, (itemH + space) * num - space, itemH);
        inputView.boxFlowLayout.itemSize = CGSizeMake(itemH, itemH);
        inputView.boxFlowLayout.minLineSpacing = space;
        inputView.customCellProperty = property;
        inputView.keyBoardType = UIKeyboardTypeNumberPad;// 不设置时，默认UIKeyboardTypeNumberPad
        [inputView loadAndPrepareViewWithBeginEdit:YES];
        @weakify(self)
        inputView.textDidChangeblock = ^(NSString * _Nullable text, BOOL isFinished) {
            @strongify(self)
            if(isFinished) {
                [self goLogin:self.phone code:text];
            }
        };
        _codeInputView = inputView;
    }
    return _codeInputView;
}

- (UIButton *)countDownBtn {
    if(!_countDownBtn) {
        _countDownBtn = [UIButton xt_btn:self.countDown font:XT_Font_M(14) textColor:[UIColor whiteColor] cornerRadius:16 tag:0];
        _countDownBtn.backgroundColor = XT_RGB(0x02CC56, 1.0f);
        @weakify(self)
        _countDownBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(self.resendBlock){
                self.resendBlock();
            }
            return [RACSignal empty];
        }];
    }
    return _countDownBtn;
}

- (XTLoginViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [[XTLoginViewModel alloc] init];
    }
    return _viewModel;
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
