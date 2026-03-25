//
//  PesoContactVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoContactVC.h"
#import "PesoVerifyStepView.h"
#import "PesoContactCell.h"
#import "PesoContactModel.h"
#import "PesoEnumPicker.h"
#import <ContactsUI/ContactsUI.h>
#import "PesoContactViewModel.h"
#import "PesoHomeViewModel.h"
#import "PesoVerifyWanliuView.h"
@interface PesoContactVC ()<UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PesoVerifyStepView *stepView;
@property (nonatomic, strong) QMUIButton *saveBtn;
@property (nonatomic, strong) PesoContactModel *model;
@property(nonatomic, strong) PesoContactItmeModel *selectModel;
@property(nonatomic, assign) NSInteger seletIndex;
@property (nonatomic, strong) PesoContactViewModel *viewModel;
@end

@implementation PesoContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel loadGetContactRequest:self.productId callback:^(PesoContactModel *model) {
        self.model = model;
        self.stepView.hidden = NO;
        self.stepView.countTime = model.paeothirteengrapherNc;
        [self.tableView reloadData];
    }];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self bringNavToFront];
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
    alert.step = 2;
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
    
    UIImageView *titleImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contact_title"]];
    titleImage.contentMode = UIViewContentModeScaleAspectFit;
    titleImage.frame = CGRectMake(0, kNavBarAndStatusBarHeight - 20, 162, 35);
    titleImage.centerX = kScreenWidth/2;
    [backImage addSubview:titleImage];
    WEAKSELF
    _stepView = [[PesoVerifyStepView alloc] initWithFrame:CGRectMake(0, titleImage.bottom-5, kScreenWidth, kScreenWidth/375*142)];
    _stepView.endBlock = ^{
        weakSelf.stepView.hidden = YES;
        weakSelf.stepView.height = 0;
        weakSelf.tableView.frame = CGRectMake(0, weakSelf.stepView.bottom+20, kScreenWidth, kScreenHeight - kBottomSafeHeight - 50 - 20 - weakSelf.stepView.bottom-20);
    };
    _stepView.backgroundColor = [UIColor clearColor];
    _stepView.hidden = YES;
    [self.view addSubview:_stepView];
    _stepView.step = 2;
    
    [self.view addSubview:self.tableView];
    
    QMUIButton *saveBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(30, kScreenHeight - kBottomSafeHeight - 50 - 20, kScreenWidth-60, 50);
    [saveBtn setTitle:@"Next" forState:UIControlStateNormal];
    saveBtn.backgroundColor = ColorFromHex(0xFCE815);
    saveBtn.titleLabel.font = PH_Font_B(18);
    [saveBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius = 25;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    _saveBtn= saveBtn;
}
- (void)nextAction{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self.model.ovrfthirteenraughtNc enumerateObjectsUsingBlock:^(PesoContactItmeModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setValue:NotNil(model.koNcthirteen.uporthirteennNc) forKey:NotNil(model.inhothirteenationNc[0][@"uporthirteennNc"])];
        [dic setValue:NotNil(model.koNcthirteen.halothirteenwNc) forKey:NotNil(model.inhothirteenationNc[1][@"uporthirteennNc"])];
        [dic setValue:@(model.koNcthirteen.bedithirteeneNc) forKey:NotNil(model.inhothirteenationNc[2][@"uporthirteennNc"])];
    }];
    dic[@"point"] = [self getaSomeApiParam:self.productId sceneType:@"23"];
    dic[@"lietthirteenusNc"]= NotNil(self.productId);
    NSLog(@"=====>%@",dic);
    WEAKSELF
    [self.viewModel loadSaveContactRequest:self.productId dic:dic callback:^(NSString *url){
//        if ([PesoUserCenter sharedPesoUserCenter].isaduit) {
//            [weakSelf removeViewController];
//            return;
//        }
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
}
- (void)routerUrl:(NSString *)url{
    [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:url];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
#pragma mark - table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PesoContactItmeModel *model = self.model.ovrfthirteenraughtNc[indexPath.section];
    PesoContactCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoContactCell.class)];
    WEAKSELF
    cell.relationClick = ^{

        PesoEnumPicker *picker = [[PesoEnumPicker alloc] initWithTitleArray:model.bedithirteeneNc headerTitle:model.fldgthirteeneNc];
        picker.clickBlock = ^(PesoContactRelationEnumModel  *enumModel) {
            model.koNcthirteen.bedithirteeneNc = enumModel.dempthirteenhasizeNc;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            weakSelf.selectModel = model;
        };
        [picker showWithAnimation];
    };
    cell.contactClick = ^{
        weakSelf.selectModel = model;
        weakSelf.seletIndex = indexPath.section;

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
    return self.model.ovrfthirteenraughtNc.count;
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
    view.backgroundColor = ColorFromHex(0xF8F8F8);
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

        if (br_isEmptyObject(phoneString) || (br_isEmptyObject(firstName) && br_isEmptyObject(lastName)) ){
            [PesoUtil showToast:@"Phone number and name cannot be empty"];
            return;
        }
        self.selectModel.koNcthirteen.uporthirteennNc = NotNil(name);
        self.selectModel.koNcthirteen.halothirteenwNc = NotNil(phoneString);
    }
    [self.tableView reloadData];
}
#pragma mark - getter
- (PesoContactViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [PesoContactViewModel new];
    }
    return _viewModel;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _stepView.bottom, kScreenWidth, kScreenHeight - kBottomSafeHeight - 50 - 20 - _stepView.bottom) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.layer.cornerRadius = 15;
        _tableView.layer.masksToBounds = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PesoContactCell class] forCellReuseIdentifier:NSStringFromClass(PesoContactCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}

@end
