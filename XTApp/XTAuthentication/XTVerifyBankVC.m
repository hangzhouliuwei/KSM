//
//  XTVerifyBankVC.m
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import "XTVerifyBankVC.h"
#import "XTSetAltView.h"
#import <YFPopView/YFPopView.h>
#import "XTVerifyViewModel.h"
#import "XTLocationManger.h"
#import "XTSegView.h"
#import "XTWalletView.h"
#import "XTBankView.h"
#import "XTBankModel.h"
#import "XTNoteModel.h"
#import "XTBankItemModel.h"
#import "XTSelectView.h"
#import "XTBankAltView.h"

@interface XTVerifyBankVC ()

@property(nonatomic,strong) XTVerifyViewModel *viewModel;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,copy) NSString *startTime;
@property(nonatomic,strong) UIButton *submitBtn;
@property(nonatomic,strong) NSArray <NSDictionary *>*segList;
@property(nonatomic,strong) XTWalletView *walletView;
@property(nonatomic,strong) XTBankView *bankView;

@end

@implementation XTVerifyBankVC

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
    self.xt_title = @"Withdrawal account";
    self.xt_title_color = [UIColor whiteColor];
    self.view.backgroundColor = XT_RGB(0xF2F5FA, 1.0f);
    @weakify(self)
    [self.viewModel xt_card:self.productId success:^{
        @strongify(self)
        [self xt_UI];
    } failure:^{
        
    }];
}

-(void)xt_UI {
    UIView *topView = [UIView xt_frame:CGRectMake(0, CGRectGetMaxY(self.xt_navView.frame), self.view.width, 2) color:XT_RGB(0x0BB559, 1.0f)];
    [self.view addSubview:topView];
    UIImageView *topBGImg = [UIImageView xt_img:@"xt_verify_bank_top_bg" tag:0];
    [self.view addSubview:topBGImg];
    [topBGImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(topView.mas_bottom);
    }];
    
    UILabel *titLab = [UILabel xt_lab:CGRectZero text:@"You can use E-wallet / bank account / over the counter to repay the bills." font:XT_Font(14) textColor:XT_RGB(0x333333, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    titLab.numberOfLines = 0;
    [self.view addSubview:titLab];
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(14);
        make.right.equalTo(self.view.mas_right).offset(-14);
        make.top.equalTo(topBGImg.mas_bottom).offset(20);
    }];
    NSInteger index = 0;
    if(![NSString xt_isEmpty:self.viewModel.bankModel.bankModel.xt_channel]){
        index = 1;
        self.walletView.hidden = !self.walletView.hidden;
        self.bankView.hidden = !self.bankView.hidden;
    }
    
    XTSegView *segView = [[XTSegView alloc] initArr:self.segList font:XT_Font_SD(15) selectFont:XT_Font_SD(15) color:XT_RGB(0x01A652, 1.0f) selectColor:[UIColor whiteColor] bgColor:[UIColor whiteColor] selectBgColor:XT_RGB(0x0BB559, 1.0f) select:index];
    segView.layer.borderColor = XT_RGB(0x0BB559, 1.0f).CGColor;
    segView.layer.borderWidth = 1;
    [self.view addSubview:segView];
    [segView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(14);
        make.right.equalTo(self.view.mas_right).offset(-14);
        make.top.equalTo(titLab.mas_bottom).offset(12);
    }];
    @weakify(self)
    segView.block = ^(NSInteger index) {
        @strongify(self)
        self.walletView.hidden = !self.walletView.hidden;
        self.bankView.hidden = !self.bankView.hidden;
    };
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-XT_Bottom_Height-20);
        make.height.equalTo(@48);
    }];
    
    [self.view addSubview:self.walletView];
    [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(-20);
        make.top.equalTo(segView.mas_bottom).offset(20);
    }];
    
    [self.view addSubview:self.bankView];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(-20);
        make.top.equalTo(segView.mas_bottom).offset(20);
    }];
}

-(void)xt_back {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    XTSetAltView *altView = [[XTSetAltView alloc] initWithAlt:@"Are you sure you want to\n leave?"];
    altView.center = self.view.center;
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:altView];
    popView.animationStyle = YFPopViewAnimationStyleFade;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    __weak YFPopView *weakView = popView;
    @weakify(self)
    altView.sureBlock = ^{
        [weakView removeSelf];
        weakView.didDismiss = ^(YFPopView *popView) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        };
    };
    altView.cancelBlock = ^{
        [weakView removeSelf];
    };
}

-(void)select:(NSArray *)arr tit:tit value:(NSString *)value block:(XTDicBlock)block{
    XTSelectView *view = [[XTSelectView alloc] initTit:tit arr:arr];
    [view xt_value:value];
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:view];
    __weak YFPopView *weakView = popView;
    popView.animationStyle = YFPopViewAnimationStyleBottomToTop;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    view.closeBlock = ^{
        [weakView removeSelf];
    };
    view.sureBlock = ^(NSDictionary *dic) {
        if(block){
            block(dic);
        }
    };
}

-(void)goCheck {
    NSInteger type;
    NSString *tit;
    NSString *name;
    NSString *value;
    NSString *accText;
    if(!self.walletView.hidden) {
        if(!self.walletView.indexModel){
            [XTUtility xt_showTips:@"Please Select E-Wallet" view:self.view];
            return;
        }
        if([NSString xt_isEmpty:self.walletView.textField.text]){
            [XTUtility xt_showTips:@"Please Enter E-wallet Account" view:self.view];
            return;
        }
        type = 2;
        tit = @"Channel";
        name = self.walletView.indexModel.xt_name;
        value = self.walletView.indexModel.xt_type;
        accText = self.walletView.textField.text;
    }
    else {
        if([NSString xt_isEmpty:self.bankView.value]) {
            [XTUtility xt_showTips:@"Please Select Bank" view:self.view];
            return;
        }
        if([NSString xt_isEmpty:self.bankView.accountTextField.text]) {
            [XTUtility xt_showTips:@"Please Enter Bank Account" view:self.view];
            return;
        }
        type = 1;
        tit = @"Bank";
        name = self.bankView.name;
        value = self.bankView.value;
        accText = self.bankView.accountTextField.text;
    }
    
    XTBankAltView *view = [[XTBankAltView alloc] initTit:tit name:name account:accText];
    view.center = self.view.center;
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:view];
    __weak YFPopView *weakView = popView;
    popView.animationStyle = YFPopViewAnimationStyleFade;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    view.cancelBlock = ^{
        [weakView removeSelf];
    };
    @weakify(self)
    view.submitBlock = ^{
        @strongify(self)
        [self goSubmit:@{
            @"ceNcsix":[NSString stringWithFormat:@"%ld",type],
            @"blthsixelyNc":XT_Object_To_Stirng(value),
            @"ovrcsixutNc":XT_Object_To_Stirng(accText),
        }];
    };
}

-(void)goSubmit:(NSDictionary *)parameter {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameter];
    [dic setObject:XT_Object_To_Stirng(self.productId) forKey:@"lietsixusNc"];
    [dic setObject:@{
        @"deamsixatoryNc":XT_Object_To_Stirng(self.startTime),
        @"munisixumNc":XT_Object_To_Stirng(self.productId),
        @"hyrasixrthrosisNc":@"26",
        @"boomsixofoNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_latitude),
        @"unulsixyNc":XT_Object_To_Stirng([[XTUtility xt_share] xt_nowTimeStamp]),
        @"cacosixtomyNc":XT_Object_To_Stirng([XTDevice xt_share].xt_idfv),
        @"unevsixoutNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_longitude),
    } forKey:@"point"];
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_card_next:dic success:^(NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [self goNext:str];
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

- (void)goNext:(NSString *)str{
    @weakify(self)
//    if([XTUserManger xt_share].xt_user.xt_is_aduit) {
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
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
        _viewModel = [XTVerifyViewModel new];
    }
    return _viewModel;
}

- (UIButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [UIButton xt_btn:@"Next" font:XT_Font_B(20) textColor:[UIColor whiteColor] cornerRadius:24 tag:0];
        _submitBtn.backgroundColor = XT_RGB(0x02CC56, 1.0f);
        @weakify(self)
        _submitBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [self goCheck];
            return [RACSignal empty];
        }];
    }
    return _submitBtn;
}

- (NSArray<NSDictionary *> *)segList {
    if(!_segList) {
        _segList = @[
            @{
                @"value":@"2",
                @"name":@"E-Wallet",
            },
            @{
                @"value":@"1",
                @"name":@"Bank",
            }
        ];
    }
    return _segList;
}

- (XTWalletView *)walletView {
    if(!_walletView) {
        _walletView = [[XTWalletView alloc] init];
        _walletView.model = self.viewModel.bankModel.walletModel;
    }
    return _walletView;
}

- (XTBankView *)bankView {
    if(!_bankView) {
        _bankView = [[XTBankView alloc] init];
        _bankView.model = self.viewModel.bankModel.bankModel;
        _bankView.hidden = YES;
        @weakify(self)
        _bankView.block = ^(XTDicBlock block) {
            @strongify(self)
            [self select:self.viewModel.bankModel.bankModel.note tit:@"Select Bank" value:self.bankView.value block:block];
        };
    }
    return _bankView;
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
