//
//  PTBasicVerifyVC.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBasicVerifyVC.h"
#import "PTBasicVerifyPresenter.h"
#import "PTBasicVerifyModel.h"
#import "PTVerifyPickerView.h"
#import "PTVerifyEnumCell.h"
#import "PTVerifyTextInputCell.h"
#import "PTVerifySelectDateCell.h"
#import "PTBasicVerifySectionHeader.h"
#import <BRDatePickerView.h>
#import "PTVerifyCountDownView.h"
#import "PTVerifyPleaseLeftView.h"
@interface PTBasicVerifyVC ()<PTBasicVerifyProtocol,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PTBasicVerifyPresenter *presenter;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PTVerifyCountDownView *countDownView;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) PTBasicVerifyModel *model;

@end

@implementation PTBasicVerifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showtitle:@"Basic" isLeft:NO disPlayType:PTDisplayTypeBlack];

    [self.presenter pt_sendGetBasicRequestWithProduct_id:self.productId];
    [self setupUI];
    // Do any additional setup after loading the view.
}
#pragma mark - nav back
- (void)leftBtnClick
{
    [self showWanliu];
}

- (void)showWanliu{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    PTVerifyPleaseLeftView *view = [[PTVerifyPleaseLeftView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.cancelBlock = ^{
        
    };
    view.confirmBlock = ^{
        [self.navigationController qmui_popViewControllerAnimated:YES completion:^{}];
    };
    view.step = 1;
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
        make.top.mas_equalTo(kNavBarAndStatusBarHeight+14);
        make.height.mas_equalTo((kScreenWidth-32)/343*218.f);
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
#pragma mark - presenter Delegate
- (void)updateUIWithModel:(PTBasicVerifyModel *)model{
    self.model = model;
    self.countDownView.countTime = model.pateneographerNc;
    [self.tableView reloadData];
    self.countDownView.hidden = NO;
}

- (void)jumpNextPageWithProductId:(nonnull NSString *)product_id nextUrl:(nonnull NSString *)url {
    [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:[url br_pinProductId:product_id]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}


- (void)saveBasicSucceed {
    
}
#pragma mark - action
//点击下一步
- (void)onNextClick{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (PTBasicItmeModel *itmeModel in self.model.ovtenrfraughtNc) {
        for (PTBasicRowModel *obj in itmeModel.xatenthosisNc) {
            //是否可选
            if(obj.tatenpaxNc.integerValue == 0){
                if([obj.datenrymanNc br_isBlankString]){
                    NSString *str = @"Please Select";
                    if ([obj.cellType isEqual:@"enum"]) {
                        str = [NSString stringWithFormat:@"Please Select %@",obj.fltendgeNc];
                    }else if([obj.cellType isEqual:@"txt"]){
                        str = [NSString stringWithFormat:@"Please Input %@",obj.fltendgeNc];
                    }
                    [self showToast:str duration:1.5];
                    return;
                }else{
                    [dic setValue:PTNotNull(obj.datenrymanNc) forKey:PTNotNull(obj.imteneasurabilityNc)];
                    continue;
                }
            }else{
                [dic setValue:PTNotNull(obj.datenrymanNc) forKey:PTNotNull(obj.imteneasurabilityNc)];
                 continue;
            }
        }
    }
    NSDictionary *pointDic = @{
                                @"detenamatoryNc": @(self.startTime.doubleValue),
                                @"mutenniumNc": PTNotNull(self.productId),
                                @"hytenrarthrosisNc":@"22",
                                @"botenomofoNc":PTNotNull([PTLocationManger sharedPTLocationManger].latitude),
                                @"untenulyNc":@([NSDate br_timestamp].doubleValue),
                                @"catencotomyNc": PTNotNull([PTDeviceInfo idfv]),
                                @"untenevoutNc":PTNotNull([PTLocationManger sharedPTLocationManger].longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"litenetusNc"]= PTNotNull(self.productId);
    [self.presenter pt_sendSaveBasicRequest:dic product_id:self.productId];
}
- (void)goNextSelectAction: (NSIndexPath *)indexPath {
    if (self.model.ovtenrfraughtNc.count < indexPath.section) {
        return;
    }
    PTBasicItmeModel *model = self.model.ovtenrfraughtNc[indexPath.section];
    if(model.xatenthosisNc.count > indexPath.row + 1){
        PTBasicRowModel *rowmodel = [model.xatenthosisNc objectAtIndex:indexPath.row + 1];
        if (![rowmodel.datenrymanNc br_isBlankString]) {
            return;
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]];
        
        if ([cell isKindOfClass:[PTVerifyEnumCell class]]) {
            PTVerifyEnumCell *enumCell = (PTVerifyEnumCell *)cell;
            [enumCell clickAction];
        }
//        if([cell isKindOfClass:[BagVerifyDateCell class]]){
//            BagVerifyDateCell *dayCell = (BagVerifyDateCell *)cell;
//            [dayCell click];
//        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, self.tableView.contentOffset.y + cell.frame.size.height)];
        });
    });
    
}
#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.ovtenrfraughtNc.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.model.ovtenrfraughtNc.count > section) {
        PTBasicItmeModel *model = self.model.ovtenrfraughtNc[section];
        if (model.more && !model.isSelected) {
            return 0;
        }
        return model.xatenthosisNc.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 46;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PTBasicItmeModel *model = self.model.ovtenrfraughtNc[section];

    PTBasicVerifySectionHeader *header = [[PTBasicVerifySectionHeader alloc] initWithFrame:CGRectZero];
    header.click = ^(BOOL isYes) {
        model.isSelected = isYes;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [header updateUIWithTitle:model.fltendgeNc Subtitle:model.sub_title more:model.more isSelected:model.isSelected];
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    PTBasicItmeModel *model = self.model.ovtenrfraughtNc[indexPath.section];
    PTBasicRowModel *rowModel = model.xatenthosisNc[indexPath.row];
    //枚举 picker
    if ([rowModel.cellType isEqual:@"enum"] || [rowModel.cellType isEqual:@"day"]) {
        PTVerifyEnumCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTVerifyEnumCell.class)];
        cell.clickBlock = ^{
            STRONGSELF
            if([QMUIHelper isKeyboardVisible]){
                [strongSelf.view endEditing:YES];
            }
            if ([rowModel.cellType isEqual:@"enum"]) {
                PTVerifyPickerView *picker = [[PTVerifyPickerView alloc] initWithTitleArray:rowModel.tutenbodrillNc headerTitle:rowModel.fltendgeNc];
                picker.clickBlock = ^(PTBasicEnumModel *model) {
                    rowModel.datenrymanNc = @(model.ittenlianizeNc).stringValue;
                    [strongSelf.tableView reloadData];
                    //默认去展示下一条 cell 的 picker
                    [strongSelf goNextSelectAction:indexPath];
                };
                [picker showWithAnimation];
            }else{
                // 1.创建日期选择器
                BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
                // 2.设置属性
                datePickerView.pickerMode = BRDatePickerModeYMD;
                datePickerView.title = rowModel.fltendgeNc;
                datePickerView.selectDate = [NSDate date];
                datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
                datePickerView.maxDate = [NSDate br_setYear:2034 month:3 day:12];
                datePickerView.isAutoSelect = NO;
                datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                    STRONGSELF
                    NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld",selectDate.br_day,selectDate.br_month,selectDate.br_year];
                    rowModel.datenrymanNc = date;
                    [strongSelf.tableView reloadData];
                    [strongSelf goNextSelectAction:indexPath];
                };
                // 设置自定义样式
                BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
                customStyle.pickerColor = [UIColor whiteColor];
                customStyle.titleBarColor = [UIColor qmui_colorWithHexString:@"#E2FFAB"];
                
                customStyle.pickerTextColor = [UIColor br_colorWithRGB:0x000000];
                customStyle.separatorColor = [UIColor br_colorWithRGB:0x000000];
                customStyle.selectRowTextColor = [UIColor qmui_colorWithHexString:@"#000000"];
                customStyle.selectRowColor = [UIColor qmui_colorWithHexString:@"#C8FB67"];
                customStyle.separatorColor = [UIColor clearColor];
                customStyle.language = @"en";
                customStyle.titleTextFont = [UIFont boldSystemFontOfSize:16];
                customStyle.cancelTextFont = [UIFont boldSystemFontOfSize:16];
                customStyle.doneTextFont = [UIFont boldSystemFontOfSize:16];
                customStyle.cancelTextColor = customStyle.doneTextColor = customStyle.titleTextColor = [UIColor blackColor];
                datePickerView.pickerStyle = customStyle;
                [datePickerView show];
            };
        };
        [cell configUIWithModel:rowModel];
        return cell;
    }
    //文本
    if ([rowModel.cellType isEqual:@"txt"]) {
        PTVerifyTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTVerifyTextInputCell.class)];
        [cell configUI:rowModel index:indexPath tableView:tableView Y:self.saveBtn.bottom];
        WEAKSELF
        cell.textBlock = ^(NSString * _Nonnull str) {
            STRONGSELF
            rowModel.datenrymanNc = PTNotNull(str);
        };
        cell.textBeginBlock = ^{
            STRONGSELF
        };
        return cell;
    }
    if ([rowModel.cellType isEqual:@"day"]) {
        PTVerifySelectDateCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTVerifySelectDateCell.class)];
        [cell configUIWithModel:rowModel];
        return cell;
    }
 
    return [UITableViewCell new];
}
#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PTVerifyEnumCell class] forCellReuseIdentifier:NSStringFromClass(PTVerifyEnumCell.class)];
        [_tableView registerClass:[PTVerifyTextInputCell class] forCellReuseIdentifier:NSStringFromClass(PTVerifyTextInputCell.class)];
        [_tableView registerClass:[PTVerifySelectDateCell class] forCellReuseIdentifier:NSStringFromClass(PTVerifySelectDateCell.class)];
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
        _saveBtn.backgroundColor = PTUIColorFromHex(0xcdf76e);
        [_saveBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(22, 22) viewRect:CGRectMake(0, 0, kScreenWidth - 28, 44)];
    }
    return _saveBtn;
}
- (PTVerifyCountDownView *)countDownView
{
    if (!_countDownView) {
        _countDownView = [[PTVerifyCountDownView alloc] initWithFrame:CGRectZero];
        _countDownView.step = 1;
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
- (PTBasicVerifyPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [PTBasicVerifyPresenter new];
        _presenter.delegate = self;
    }
    return _presenter;
}

- (void)dealloc{
    
}

@end
