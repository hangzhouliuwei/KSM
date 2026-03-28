//
//  BagVerifyBasicVC.m
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import "BagVerifyBasicVC.h"
#import "BagVerifyBasicPresenter.h"
#import "BagVerifyBasicCountDownView.h"
#import "BagVerifyBasicEnumCell.h"
#import "BagVerifyInputTableViewCell.h"
#import "BagVerifyDateCell.h"
#import "BagVerifyBasicModel.h"
#import "BagVerifyBasicSectionHeader.h"
#import "BagVerifyPickerView.h"
#import <BRPickerView.h>
#import "BagVerifyWanliuView.h"
@interface BagVerifyBasicVC ()<BagVerifyBasicProtocol,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) BagVerifyBasicPresenter *presenter;
@property (nonatomic, strong) BagVerifyBasicCountDownView *countDownView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) BagVerifyBasicModel *model;
@property(nonatomic, copy) NSString *startTime;

@end

@implementation BagVerifyBasicVC

- (void)viewDidLoad {
    self.leftTitle = @"Basic";
    [super viewDidLoad];
    self.startTime = [NSDate br_timestamp];
    [self.presenter sendGetBasicRequestWithProduct_id:self.productId];
    [self.view  addSubview:self.countDownView];
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
    [BagTrackHandleManager trackAppEventName:@"af_cc_page_basic" withElementParam:@{}];

}
#pragma mark - nav back
- (void)backClick
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self showWanliu];
}

- (void)showWanliu{
    BagVerifyWanliuView *view = [BagVerifyWanliuView createAlert];
    view.confirmBlock = ^{
        [BagTrackHandleManager trackAppEventName:@"af_cc_page_basic_exit" withElementParam:@{}];
        [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
            
        }];
    };
    [view showWithType:VerifyBasicType];
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
    [BagTrackHandleManager trackAppEventName:@"af_cc_start_basic" withElementParam:@{}];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (BagBasicItmeModel *itmeModel in self.model.heterogenistF) {
        for (BagBasicRowModel *obj in itmeModel.railageF) {
            if(obj.escarpmentF.integerValue == 0){
                if([obj.lorrieF br_isBlankString]){
                    NSString *str = @"Please Select";
                    if ([obj.javaneseF isEqual:@"enum"]) {
                        str = [NSString stringWithFormat:@"Please Select %@",obj.mudslingerF];
                    }else if([obj.javaneseF isEqual:@"txt"]){
                        str = [NSString stringWithFormat:@"Please Input %@",obj.mudslingerF];
                    }
                    [self showToast:str duration:1.5];
                    [BagTrackHandleManager trackAppEventName:@"af_cc_basic_start_err" withElementParam:@{@"tag":NotNull(obj.taxidermyF)}];
                    return;
                }else{
                    [dic setValue:obj.lorrieF forKey:obj.taxidermyF];
                    continue;
                }
            }else{
                [dic setValue:obj.lorrieF forKey:obj.taxidermyF];
                 continue;
            }
        }
    }
    NSDictionary *pointDic = @{
                                @"calcographyF": @(self.startTime.doubleValue),
                                @"biolysisF": NotNull(self.productId),
                                @"jactancyF":@"22",
                                @"hateworthyF":@(BagLocationManager.shareInstance.latitude),
                                @"apoenzymeF":@([NSDate br_timestamp].doubleValue),
                                @"clapperclawF": NotNull(NSObject.getIDFV),
                                @"reinhabitF":@(BagLocationManager.shareInstance.longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"vachelF"]= NotNull(self.productId);
    [self.presenter sendSaveBasicRequest:dic.copy product_id:self.productId];
}
#pragma mark - BagVerifyBasicProtocol
- (void)updateUIWithModel:(BagVerifyBasicModel *)model
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
- (void)removeViewController { 
    NSMutableArray *VCArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [VCArr removeObject:self];
    self.navigationController.viewControllers =VCArr;
}
- (void)saveBasicSucceed
{
    [BagTrackHandleManager trackAppEventName:@"af_cc_success_basic" withElementParam:@{}];
}

#pragma mark - 去下一个选项
- (void)goNextSelectAction: (NSIndexPath *)indexPath {
    if (self.model.heterogenistF.count < indexPath.section) {
        return;
    }
    BagBasicItmeModel *itmeModel = [self.model.heterogenistF objectAtIndex:indexPath.section];
    if(itmeModel.railageF.count > indexPath.row + 1){
        BagBasicRowModel *model = [itmeModel.railageF objectAtIndex:indexPath.row + 1];
        if (![model.lorrieF br_isBlankString]) {
            return;
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]];
        
        if ([cell isKindOfClass:[BagVerifyBasicEnumCell class]]) {
            BagVerifyBasicEnumCell *tCell = (BagVerifyBasicEnumCell *)cell;
            [tCell click];
        }
        if([cell isKindOfClass:[BagVerifyDateCell class]]){
            BagVerifyDateCell *dayCell = (BagVerifyDateCell *)cell;
            [dayCell click];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, self.tableView.contentOffset.y + cell.frame.size.height)];
        });
    });
    
}
#pragma mark -table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BagBasicItmeModel *model = self.model.heterogenistF[indexPath.section];
    BagBasicRowModel *rowModel = model.railageF[indexPath.row];
    WEAKSELF
    //枚举 picker
    if ([rowModel.cellType isEqual:@"enum"]) {
        BagVerifyBasicEnumCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagVerifyBasicEnumCell.class)];
        cell.clickBlock = ^{
            STRONGSELF
            if([QMUIHelper isKeyboardVisible]){
                [strongSelf.view endEditing:YES];
            }
            [strongSelf tarckClickTagString:rowModel.taxidermyF];
            
            BagVerifyPickerView *picker = [[BagVerifyPickerView alloc] initWithTitleArray:rowModel.maquisF headerTitle:rowModel.mudslingerF];
            picker.clickBlock = ^(BagBasicEnumModel * _Nonnull model) {
                rowModel.lorrieF = @(model.nortriptylineF).stringValue;
                [weakSelf.tableView reloadData];
                //默认去展示下一条 cell 的 picker
                [weakSelf goNextSelectAction:indexPath];
                [strongSelf tarckSelectResultTagString:rowModel.taxidermyF contentString:rowModel.lorrieF];
            };
            [picker showWithAnimation];
        };
        [cell updateUIWithModel:rowModel];
        return cell;
    }
    //文本
    if ([rowModel.cellType isEqual:@"txt"]) {
        BagVerifyInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagVerifyInputTableViewCell.class)];
        cell.textBlock = ^(NSString * _Nonnull str) {
            STRONGSELF
            rowModel.lorrieF = NotNull(str);
            [strongSelf tarckSelectResultTagString:rowModel.taxidermyF contentString:rowModel.lorrieF];
        };
        cell.textBeginBlock = ^{
            STRONGSELF
            [strongSelf tarckClickTagString:rowModel.taxidermyF];
        };
        if([rowModel.taxidermyF isEqualToString:@"email"]){
            [cell updateUIWithModel:rowModel index:indexPath tableView:self.tableView topY:self.nextBtn.bottom];
        }else{
            [cell updateUIWithModel:rowModel];
        }
        return cell;
    }
    //日期选择
    if ([rowModel.cellType isEqual:@"day"]) {
        BagVerifyDateCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagVerifyDateCell.class)];
        cell.clickBlock = ^{
            if([QMUIHelper isKeyboardVisible]){
                [self.view endEditing:YES];
            }
            [self tarckClickTagString:rowModel.taxidermyF];
            // 1.创建日期选择器
            BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
            // 2.设置属性
            datePickerView.pickerMode = BRDatePickerModeYMD;
            datePickerView.title = rowModel.mudslingerF;
            datePickerView.selectDate = [NSDate date];
            datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
            datePickerView.maxDate = [NSDate br_setYear:2034 month:3 day:12];
            datePickerView.isAutoSelect = NO;
            datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld",selectDate.br_day,selectDate.br_month,selectDate.br_year];
                rowModel.lorrieF = date;
                [self.tableView reloadData];
                [self goNextSelectAction:indexPath];
                NSLog(@"选择的值：%@", selectValue);
                [self tarckSelectResultTagString:rowModel.taxidermyF contentString:rowModel.lorrieF];
            };
            // 设置自定义样式
            BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
            customStyle.pickerColor = [UIColor whiteColor];
            customStyle.titleBarColor = [UIColor qmui_colorWithHexString:@"#1E59A2"];
            
            customStyle.pickerTextColor = [UIColor br_colorWithRGB:0x1B1622];
            customStyle.separatorColor = [UIColor br_colorWithRGB:0x1B1622];
            customStyle.selectRowTextColor = [UIColor qmui_colorWithHexString:@"#0EB479"];
            customStyle.separatorColor = [UIColor clearColor];
            customStyle.language = @"en";
            customStyle.titleTextFont = [UIFont boldSystemFontOfSize:16];
            customStyle.cancelTextFont = [UIFont boldSystemFontOfSize:16];
            customStyle.doneTextFont = [UIFont boldSystemFontOfSize:16];
            customStyle.cancelTextColor = customStyle.doneTextColor = customStyle.titleTextColor = [UIColor whiteColor];
            datePickerView.pickerStyle = customStyle;
            
            // 3.显示
            [datePickerView show];
        };
        [cell updateUIWithModel:rowModel];
        return cell;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _model.heterogenistF.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BagBasicItmeModel *model = self.model.heterogenistF[section];
    BagVerifyBasicSectionHeader *header = [BagVerifyBasicSectionHeader createView];
    header.clickMore = ^(BOOL value) {
        model.isSelected = value;
        [BagTrackHandleManager trackAppEventName:value ? @"af_cc_click_basic_more": @"af_cc_click_basic_hide" withElementParam:@{}];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [header updateUIWithTitle:model.mudslingerF Subtitle:model.sub_title more:model.more isSelected:model.isSelected];
    
    return header;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.model.heterogenistF.count > section) {
        BagBasicItmeModel *model = self.model.heterogenistF[section];
        if (model.more && !model.isSelected) {
            return 0;
        }
        return model.railageF.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.model.heterogenistF.count > indexPath.section) {
        BagBasicItmeModel *model = self.model.heterogenistF[indexPath.section];
        if (model.railageF.count > indexPath.row) {
            BagBasicRowModel *rowModel = model.railageF[indexPath.row];
            return rowModel.cellHight;
        }
    }
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - 用户点击埋点
- (void)tarckClickTagString:(NSString*)tagStr
{
    [BagTrackHandleManager trackAppEventName:@"af_cc_click_basic_item" withElementParam:@{@"tag": tagStr}];
}

#pragma mark - 用户选择结果埋点
- (void)tarckSelectResultTagString:(NSString*)TagStr contentString:(NSString*)contentStr
{
    [BagTrackHandleManager trackAppEventName:@"af_cc_result_basic_item" withElementParam:@{@"tag": TagStr,
                       @"content": contentStr}];
}

#pragma mark - 用户认证选项折叠埋点
- (void)tarckSelectClickIsUp:(BOOL)isUp
{
   
  [BagTrackHandleManager trackAppEventName:isUp ? @"af_cc_click_basic_more": @"af_cc_click_basic_hide" withElementParam:@{}];
    
}
#pragma mark - getter
- (BagVerifyBasicPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [BagVerifyBasicPresenter new];
        _presenter.delegate = self;
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
//        [_tableView registerClass:[BagVerifyBasicEnumCell class] forCellReuseIdentifier:NSStringFromClass(BagVerifyBasicEnumCell.class)];
//        [_tableView registerClass:[BagVerifyInputTableViewCell class] forCellReuseIdentifier:NSStringFromClass(BagVerifyInputTableViewCell.class)];
//        [_tableView registerClass:[BagVerifyDateCell class] forCellReuseIdentifier:NSStringFromClass(BagVerifyDateCell.class)];
        
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagVerifyBasicEnumCell.class)] forCellReuseIdentifier:NSStringFromClass(BagVerifyBasicEnumCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagVerifyInputTableViewCell.class)] forCellReuseIdentifier:NSStringFromClass(BagVerifyInputTableViewCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagVerifyDateCell.class)] forCellReuseIdentifier:NSStringFromClass(BagVerifyDateCell.class)];
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
        _countDownView.step = 1;
    }
    return _countDownView;
}
- (void)dealloc
{
    
}
@end
