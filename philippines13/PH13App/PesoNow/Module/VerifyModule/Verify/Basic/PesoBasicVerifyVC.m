//
//  PesoBasicVerifyVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/12.
//

#import "PesoBasicVerifyVC.h"
#import "PesoBasicViewModel.h"
#import "PesoBasicModel.h"
#import "PesoBasicEnumCell.h"
#import "PesoBasicInputCell.h"
#import "PesoBasicSectionHeader.h"
#import "PesoEnumPicker.h"
#import <BRDatePickerView.h>
#import "PesoHomeViewModel.h"
#import "PesoVerifyStepView.h"
#import "PesoVerifyWanliuView.h"
@interface PesoBasicVerifyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PesoBasicViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PesoVerifyStepView *stepView;
@property (nonatomic, strong) QMUIButton *saveBtn;
@property (nonatomic, strong) PesoBasicModel *model;

@end

@implementation PesoBasicVerifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel loadBasicRequestWithProduct_id:self.productId callback:^(PesoBasicModel *model) {
        self.model = model;
        [self.tableView reloadData];
        self.stepView.hidden = NO;
        self.stepView.countTime = model.paeothirteengrapherNc;
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self bringNavToFront];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    alert.step = 1;
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
    
    UIImageView *titleImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"basic_title"]];
    titleImage.contentMode = UIViewContentModeScaleAspectFit;
    titleImage.frame = CGRectMake(0, kNavBarAndStatusBarHeight - 20, 103, 35);
    titleImage.centerX = kScreenWidth/2;
    [backImage addSubview:titleImage];
    WEAKSELF
    _stepView = [[PesoVerifyStepView alloc] initWithFrame:CGRectMake(0, titleImage.bottom-5, kScreenWidth, kScreenWidth/375*142)];
    _stepView.endBlock = ^{
        weakSelf.stepView.height = 0;
        weakSelf.stepView.hidden = YES;
        weakSelf.tableView.frame = CGRectMake(0, weakSelf.stepView.bottom+20, kScreenWidth, kScreenHeight - kBottomSafeHeight - 50 - 20 - weakSelf.stepView.bottom-20);
    };
    _stepView.backgroundColor = [UIColor clearColor];
    _stepView.hidden = YES;
    [self.view addSubview:_stepView];
    _stepView.step = 1;
    
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
    for (PesoBasicItmeModel *itmeModel in self.model.ovrfthirteenraughtNc) {
        for (PesoBasicRowModel *obj in itmeModel.xaththirteenosisNc) {
            //是否可选
            if(obj.tapathirteenxNc.integerValue == 0){
                if(br_isEmptyObject(obj.darythirteenmanNc)){
                    NSString *str = @"Please Select";
                    if ([obj.cellType isEqual:@"enum"]) {
                        str = [NSString stringWithFormat:@"Please Select %@",obj.fldgthirteeneNc];
                    }else if([obj.cellType isEqual:@"txt"]){
                        str = [NSString stringWithFormat:@"Please Input %@",obj.fldgthirteeneNc];
                    }
                    [PesoUtil showToast:str];
                    return;
                }else{
                    [dic setValue:NotNil(obj.darythirteenmanNc) forKey:NotNil(obj.imeathirteensurabilityNc)];
                    continue;
                }
            }else{
                [dic setValue:NotNil(obj.darythirteenmanNc) forKey:NotNil(obj.imeathirteensurabilityNc)];
                 continue;
            }
        }
    }
    dic[@"point"] = [self getaSomeApiParam:self.productId sceneType:@"22"];
    dic[@"lietthirteenusNc"]= NotNil(self.productId);
    NSLog(@"dic=>>>>>>%@",dic);
    WEAKSELF
    [self.viewModel loadSaveBasicRequest:dic product_id:self.productId callback:^(NSString * _Nonnull url) {
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
- (void)goNextSelectAction: (NSIndexPath *)indexPath {
    if (self.model.ovrfthirteenraughtNc.count < indexPath.section) {
        return;
    }
    PesoBasicItmeModel *model = self.model.ovrfthirteenraughtNc[indexPath.section];
    if(model.xaththirteenosisNc.count > indexPath.row + 1){
        PesoBasicRowModel *rowmodel = [model.xaththirteenosisNc objectAtIndex:indexPath.row + 1];
        if (br_isNotEmptyObject(rowmodel.darythirteenmanNc)) {
            return;
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]];
        
        if ([cell isKindOfClass:[PesoBasicEnumCell class]]) {
            PesoBasicEnumCell *enumCell = (PesoBasicEnumCell *)cell;
            [enumCell click];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, self.tableView.contentOffset.y + cell.frame.size.height)];
        });
    });
    
}
#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.model.ovrfthirteenraughtNc.count > section) {
        PesoBasicItmeModel *model = self.model.ovrfthirteenraughtNc[section];
        if (model.more && !model.isSelected) {
            return 0;
        }
        return model.xaththirteenosisNc.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.ovrfthirteenraughtNc.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PesoBasicItmeModel *model = self.model.ovrfthirteenraughtNc[section];

    PesoBasicSectionHeader *header = [[PesoBasicSectionHeader alloc] initWithFrame:CGRectZero];
    header.click = ^(BOOL isYes) {
        model.isSelected = isYes;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [header updateUIWithTitle:model.fldgthirteeneNc Subtitle:model.sub_title more:model.more isSelected:model.isSelected];
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    PesoBasicItmeModel *model = self.model.ovrfthirteenraughtNc[indexPath.section];
    PesoBasicRowModel *rowModel = model.xaththirteenosisNc[indexPath.row];
    if ([rowModel.cellType isEqual:@"enum"] || [rowModel.cellType isEqual:@"day"]) {
        PesoBasicEnumCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoBasicEnumCell.class)];
        [cell configUIWithModel:rowModel];
        cell.clickBlock = ^{
            if ([rowModel.cellType isEqual:@"enum"]) {
                if([QMUIHelper isKeyboardVisible]){
                    [weakSelf.view endEditing:YES];
                }
                PesoEnumPicker *picker = [[PesoEnumPicker alloc] initWithTitleArray:rowModel.tubothirteendrillNc headerTitle:rowModel.fldgthirteeneNc];
                picker.clickBlock = ^(PesoBasicEnumModel *model) {
                    rowModel.darythirteenmanNc = @(model.itlithirteenanizeNc).stringValue;
                    [weakSelf.tableView reloadData];
                    //默认去展示下一条 cell 的 picker
                    [weakSelf goNextSelectAction:indexPath];
                };
                [picker showWithAnimation];
            }else{
                if([QMUIHelper isKeyboardVisible]){
                    [weakSelf.view endEditing:YES];
                }
                // 1.创建日期选择器
                BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
                // 2.设置属性
                datePickerView.pickerMode = BRDatePickerModeYMD;
                datePickerView.title = rowModel.fldgthirteeneNc;
                datePickerView.selectDate = [NSDate date];
                datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
                datePickerView.maxDate = [NSDate br_setYear:2034 month:3 day:12];
                datePickerView.isAutoSelect = NO;
                datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                    STRONGSELF
                    NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld",selectDate.br_day,selectDate.br_month,selectDate.br_year];
                    rowModel.darythirteenmanNc = date;
                    [strongSelf.tableView reloadData];
                    [strongSelf goNextSelectAction:indexPath];
                };
                // 设置自定义样式
                BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
                customStyle.pickerColor = [UIColor whiteColor];
                customStyle.titleBarColor = [UIColor qmui_colorWithHexString:@"#E5FFCB"];
                
                customStyle.pickerTextColor = [UIColor br_colorWithRGB:0x000000];
                customStyle.separatorColor = [UIColor br_colorWithRGB:0x000000];
                customStyle.selectRowTextColor = [UIColor qmui_colorWithHexString:@"#262626"];
                customStyle.selectRowColor = [UIColor whiteColor];
                customStyle.separatorColor = [UIColor clearColor];
                customStyle.language = @"en";
                customStyle.titleTextFont = [UIFont qmui_mediumSystemFontOfSize:17];
                customStyle.cancelTextFont = [UIFont systemFontOfSize:15];
                customStyle.doneTextFont = [UIFont systemFontOfSize:15];
                customStyle.cancelTextColor =  UIColorHex(0x616C5F);
                customStyle.doneTextColor = UIColorHex(0x0A7635);
                customStyle.doneBtnTitle = @"Confirm";

                customStyle.titleTextColor = UIColorHex(0x0B2C04);
                datePickerView.pickerStyle = customStyle;
                [datePickerView show];
            }
        };
        return cell;

    }
    if ([rowModel.cellType isEqual:@"txt"]) {
        PesoBasicInputCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoBasicInputCell.class)];
        cell.textBlock = ^(NSString * _Nonnull str) {
            rowModel.darythirteenmanNc = NotNil(str);
        };
        [cell configUI:rowModel index:indexPath tableView:tableView Y:self.saveBtn.bottom];
        return cell;
    }
    return [UITableViewCell new];
}

- (PesoBasicViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [PesoBasicViewModel new];
    }
    return _viewModel;
}
#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _stepView.bottom, kScreenWidth, kScreenHeight - kBottomSafeHeight - 50 - 20 - _stepView.bottom) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.layer.cornerRadius = 15;
        _tableView.layer.masksToBounds = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PesoBasicEnumCell class] forCellReuseIdentifier:NSStringFromClass(PesoBasicEnumCell.class)];
        [_tableView registerClass:[PesoBasicInputCell class] forCellReuseIdentifier:NSStringFromClass(PesoBasicInputCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}

- (void)dealloc
{
    
}

@end
