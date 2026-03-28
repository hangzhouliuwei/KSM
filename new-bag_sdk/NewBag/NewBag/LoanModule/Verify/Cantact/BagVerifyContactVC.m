//
//  BagVerifyContactVC.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyContactVC.h"
#import "BagVerifyContactPresenter.h"
#import "BagVerifyContactModel.h"
#import "BagVerifyBasicCountDownView.h"
#import "BagVerifyContactCell.h"
#import "BagVerifyPickerView.h"
#import <ContactsUI/ContactsUI.h>
#import "BagVerifyWanliuView.h"
@interface BagVerifyContactVC ()<BagVerifyContactProtocol,UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate>
@property (nonatomic, strong) BagVerifyContactModel *model;
@property (nonatomic, strong) BagVerifyContactPresenter *presenter;
@property (nonatomic, strong) BagVerifyBasicCountDownView *countDownView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *nextBtn;
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, strong) BagContactItmeModel *selectModel;
@property(nonatomic, assign) NSInteger seletIndex;

@end

@implementation BagVerifyContactVC

- (void)viewDidLoad {
    self.leftTitle = @"Contact";
    [super viewDidLoad];
    self.startTime = [NSDate br_timestamp];

    [self.presenter sendGetContactRequestWithProductId:self.productId];
    [self.view addSubview:self.countDownView];
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(255.f);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.countDownView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-44);
    }];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BagTrackHandleManager trackAppEventName:@"af_cc_page_contact" withElementParam:@{}];
}
#pragma mark - nav back
- (void)backClick
{
    [self showWanliu];
}

- (void)showWanliu{
    BagVerifyWanliuView *view = [BagVerifyWanliuView createAlert];
    view.confirmBlock = ^{
        [BagTrackHandleManager trackAppEventName:@"af_cc_page_contact_exit" withElementParam:@{}];

        [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
            
        }];
    };
    [view showWithType:VerifyContactType];
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
#pragma mark - 保存信息
- (void)onNextClick{
    [BagTrackHandleManager trackAppEventName:@"af_cc_start_contact" withElementParam:@{}];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self.model.heterogenistF enumerateObjectsUsingBlock:^(BagContactItmeModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setValue:model.incessantF.antineoplastonF forKey:NotNull(model.definingF[0][@"antineoplastonF"])];
        [dic setValue:model.incessantF.guerrillaF forKey:NotNull(model.definingF[1][@"antineoplastonF"])];
        [dic setValue:@(model.incessantF.brandyballF) forKey:NotNull(model.definingF[2][@"antineoplastonF"])];
    }];
    
    NSDictionary *pointDic = @{
                                @"calcographyF": @(self.startTime.doubleValue),
                                @"biolysisF": NotNull(self.productId),
                                @"jactancyF":@"23",
                                @"hateworthyF":@(BagLocationManager.shareInstance.latitude),
                                @"apoenzymeF":@([NSDate br_timestamp].doubleValue),
                                @"clapperclawF": NotNull(NSObject.getIDFV),
                                @"reinhabitF":@(BagLocationManager.shareInstance.longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"vachelF"]= NotNull(self.productId);
    NSLog(@"lw=====>%@",dic);
    [self.presenter sendSaveContactRequestWithDic:dic product_id:self.productId];
}
#pragma mark - BagVerifyContactProtocol
- (void)updateUIWithModel:(BagVerifyContactModel *)model
{
    _model = model;
    self.countDownView.countTime = model.analectaF;
    [self.tableView reloadData];
}
- (void)jumpNextPageWithProductId:(NSString *)product_id nextUrl:(NSString *)url
{
    [[BagRouterManager shareInstance] routeWithUrl:[url br_pinProductId:product_id]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
- (void)saveContactSucceed
{
    [BagTrackHandleManager trackAppEventName:@"af_cc_success_contact" withElementParam:@{}];
}
#pragma mark - table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BagContactItmeModel *model = self.model.heterogenistF[indexPath.section];
    BagVerifyContactCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagVerifyContactCell.class)];
    WEAKSELF
    cell.relationClick = ^{
        [BagTrackHandleManager trackAppEventName:@"af_cc_click_contact_item" withElementParam:@{@"index":@(indexPath.section)}];

        BagVerifyPickerView *picker = [[BagVerifyPickerView alloc] initWithTitleArray:model.brandyballF headerTitle:model.mudslingerF];
        picker.clickBlock = ^(BagContactRelationEnumModel  *enumModel) {
            
            [BagTrackHandleManager trackAppEventName:@"af_cc_result_contact_item" withElementParam:@{@"index":@(indexPath.section),@"content":NotNull(enumModel.antineoplastonF)}];

            model.incessantF.brandyballF = enumModel.sovranF;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            weakSelf.selectModel = model;
        };
        [picker showWithAnimation];
    };
    cell.contactClick = ^{
        weakSelf.selectModel = model;
        weakSelf.seletIndex = indexPath.section;

        [BagTrackHandleManager trackAppEventName:@"af_cc_click_contact" withElementParam:@{@"index":@(indexPath.section)}];

        CNContactPickerViewController *pickerViewController = [[CNContactPickerViewController alloc] init];
        pickerViewController.delegate = self;
        pickerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:pickerViewController animated:YES completion:nil];
    };
    [cell updateUIWithModel:model];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.heterogenistF.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BagContactItmeModel *model = self.model.heterogenistF[section];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    view.backgroundColor = [UIColor qmui_colorWithHexString:@"#F4F7FA"];
    UILabel *label = [[QMUILabel alloc] qmui_initWithFont:[UIFont qmui_systemFontOfSize:17 weight:QMUIFontWeightBold italic:NO] textColor:[UIColor qmui_colorWithHexString:@"#333333"]];
    label.frame = CGRectMake(14, 0, kScreenWidth-28, 25);
    label.centerY = view.centerY;
    label.text = model.mudslingerF;
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
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
        [BagTrackHandleManager trackAppEventName:@"af_cc_result_contact" withElementParam:@{@"index":@(self.seletIndex),@"name":NotNull(name),@"phone":NotNull(phoneString)}];

        if ([NotNull(phoneString) br_isBlankString] || ([firstName br_isBlankString] && [lastName br_isBlankString]) ){
            [self showToast:@"Phone number and name cannot be empty" duration:1.5];
            return;
        }
        self.selectModel.incessantF.antineoplastonF = NotNull(name);
        self.selectModel.incessantF.guerrillaF = NotNull(phoneString);        
    }
    [self.tableView reloadData];
}
#pragma mark - getter
- (BagVerifyContactPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [BagVerifyContactPresenter new];
        _presenter.delegate= self;
    }
    return _presenter;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        [_tableView registerClass:[BagVerifyContactCell class] forCellReuseIdentifier:NSStringFromClass(BagVerifyContactCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagVerifyContactCell.class)] forCellReuseIdentifier:NSStringFromClass(BagVerifyContactCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;

        }
    }
    return _tableView;
}
- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _nextBtn.titleLabel.textColor = [UIColor whiteColor];
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#205EAC"] toColor:[UIColor qmui_colorWithHexString:@"#154685"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth - 26, 44)];
        [_nextBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, kScreenWidth - 28, 44)];
    }
    return _nextBtn;
}
- (BagVerifyBasicCountDownView *)countDownView
{
    if (!_countDownView) {
        _countDownView = [BagVerifyBasicCountDownView createView];
        WEAKSELF
        _countDownView.countDownEndBlock = ^{
            [weakSelf.countDownView hiddenCountDown];
            [weakSelf.countDownView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kNavBarAndStatusBarHeight + 40 + 18 + 16);
            }];
        };
        _countDownView.step = 2;
    }
    return _countDownView;
}
- (void)dealloc
{
    
}
@end
