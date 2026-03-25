//
//  PTContactVerifyVC.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTContactVerifyVC.h"
#import "PTVerifyCountDownView.h"
#import "PTContactVerifyPresenter.h"
#import "PTContactVerifyModel.h"
#import "PTContactVerifyCell.h"
#import "PTVerifyPickerView.h"
#import <ContactsUI/ContactsUI.h>
#import "PTVerifyPleaseLeftView.h"
@interface PTContactVerifyVC ()<PTContactVerifyProtocol,UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) PTVerifyCountDownView *countDownView;
@property (nonatomic, strong) PTContactVerifyPresenter *presenter;
@property (nonatomic, strong) PTContactVerifyModel *model;
@property(nonatomic, strong) PTContactItmeModel *selectModel;
@property(nonatomic, assign) NSInteger seletIndex;
@end

@implementation PTContactVerifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showtitle:@"Contact" isLeft:NO disPlayType:PTDisplayTypeBlack];
    [self.presenter sendGetContactRequest:self.productId];
    [self setupUI];
    // Do any additional setup after loading the view.
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
    view.step = 2;
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
- (void)setupUI
{
    self.view.backgroundColor = PTUIColorFromHex(0xF5F9FF);
    [self.view addSubview:self.countDownView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.saveBtn];
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight+20);
        make.height.mas_equalTo((kScreenWidth-32)/343*236.f);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countDownView.mas_bottom);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-44);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}
#pragma mark - protocol
-(void)updateUIWithModel:(PTContactVerifyModel *)model
{
    _model = model;
    _countDownView.countTime = model.pateneographerNc;
    _countDownView.hidden = NO;
    [self.tableView reloadData];
}
- (void)router:(NSString *)url
{
    [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:url];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
- (void)saveContactSucceed
{
    
}
#pragma makr - action
- (void)onNextClick{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self.model.ovtenrfraughtNc enumerateObjectsUsingBlock:^(PTContactItmeModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setValue:PTNotNull(model.kotenNc.uptenornNc) forKey:PTNotNull(model.intenhoationNc[0][@"uptenornNc"])];
        [dic setValue:PTNotNull(model.kotenNc.hatenlowNc) forKey:PTNotNull(model.intenhoationNc[1][@"uptenornNc"])];
        [dic setValue:@(model.kotenNc.betendieNc) forKey:PTNotNull(model.intenhoationNc[2][@"uptenornNc"])];
    }];
    
    NSDictionary *pointDic = @{
                                @"detenamatoryNc": @(self.startTime.doubleValue),
                                @"mutenniumNc": PTNotNull(self.productId),
                                @"hytenrarthrosisNc":@"23",
                                @"botenomofoNc":PTNotNull([PTLocationManger sharedPTLocationManger].latitude),
                                @"untenulyNc":@([NSDate br_timestamp].doubleValue),
                                @"catencotomyNc": PTNotNull([PTDeviceInfo idfv]),
                                @"untenevoutNc":PTNotNull([PTLocationManger sharedPTLocationManger].longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"litenetusNc"]= PTNotNull(self.productId);
    NSLog(@"=====>%@",dic);
    [self.presenter sendSaveContactRequest:dic product_id:self.productId];
}

#pragma mark - table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PTContactItmeModel *model = self.model.ovtenrfraughtNc[indexPath.section];
    PTContactVerifyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTContactVerifyCell.class)];
    WEAKSELF
    cell.relationClick = ^{

        PTVerifyPickerView *picker = [[PTVerifyPickerView alloc] initWithTitleArray:model.betendieNc headerTitle:model.fltendgeNc];
        picker.clickBlock = ^(PTContactRelationEnumModel  *enumModel) {
            

            model.kotenNc.betendieNc = enumModel.detenmphasizeNc;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            weakSelf.selectModel = model;
        };
        [picker showWithAnimation];
    };
    cell.contactClick = ^{
        weakSelf.selectModel = model;
        weakSelf.seletIndex = indexPath.section;
//
//        [BagTrackHandleManager trackAppEventName:@"af_cc_click_contact" withElementParam:@{@"index":@(indexPath.section)}];

        CNContactPickerViewController *pickerViewController = [[CNContactPickerViewController alloc] init];
        pickerViewController.delegate = self;
        pickerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:pickerViewController animated:YES completion:nil];
    };
    [cell configUIWithModel:model];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.ovtenrfraughtNc.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 16;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view= [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = PTUIColorFromHex(0xF5F9FF);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 209;
}
#pragma mark - delegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSString *firstName = contact.givenName;
    NSString *lastName = contact.familyName;
    NSString *name = [NSString string];
    if (firstName != nil && firstName.length > 0) {
        name = firstName;
    } else {
        name = lastName;
    }
    for (CNLabeledValue *phone in contact.phoneNumbers) {
        CNPhoneNumber *phoneNumber = phone.value;
        NSString *phoneString = phoneNumber.stringValue;

        NSLog(@"Name: %@ %@", firstName, lastName);
        NSLog(@"Phone: %@", phoneString);

        if ([PTNotNull(phoneString) br_isBlankString] || ([firstName br_isBlankString] && [lastName br_isBlankString]) ){
            [self showToast:@"Phone number and name cannot be empty" duration:1.5];
            return;
        }
        self.selectModel.kotenNc.uptenornNc = PTNotNull(name);
        self.selectModel.kotenNc.hatenlowNc = PTNotNull(phoneString);
    }
    [self.tableView reloadData];
}
#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PTContactVerifyCell class] forCellReuseIdentifier:NSStringFromClass(PTContactVerifyCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _saveBtn.titleLabel.textColor = [UIColor whiteColor];
        [_saveBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
//        [_saveBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#cdf76e"] toColor:[UIColor qmui_colorWithHexString:@"#154685"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth - 26, 44)];
        _saveBtn.backgroundColor = PTUIColorFromHex(0xcdf76e);
        [_saveBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(22, 22) viewRect:CGRectMake(0, 0, kScreenWidth - 28, 44)];
    }
    return _saveBtn;
}
- (PTVerifyCountDownView *)countDownView
{
    if (!_countDownView) {
        _countDownView = [[PTVerifyCountDownView alloc] initWithFrame:CGRectZero];
        _countDownView.step = 2;
        _countDownView.hidden = YES;
        WEAKSELF
        _countDownView.endBlock = ^{
            [weakSelf.countDownView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(80);
            }];
            [UIView animateWithDuration:0.3 animations:^{
                [weakSelf.view layoutIfNeeded];
            }];
            [weakSelf.countDownView hiddenStep];
        };
    }
    return _countDownView;
}
- (PTContactVerifyPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [PTContactVerifyPresenter new];
        _presenter.delegate = self;
    }
    return _presenter;
}
@end
