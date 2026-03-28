//
//  BagVerifyIdentifyVC.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyIdentifyVC.h"
#import "BagVerifyBasicCountDownView.h"
#import "BagVerifyIdentifyPresenter.h"
#import "BagVerifyWanliuView.h"
#import "BagIdentifyModel.h"
#import "BagIdentifyHeaderView.h"
#import "BagIdentifyTxtCell.h"
#import "BagIdentifyDateCell.h"
#import "BagIdentifySingleSelectCell.h"
#import "BagVerifyPickerView.h"
#import "BagVerifyBasicModel.h"
#import <BRDatePickerView.h>
@interface BagVerifyIdentifyVC ()<BagVerifyIdentifyProtocol,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BagVerifyIdentifyPresenter *presenter;
@property (nonatomic, strong) BagVerifyBasicCountDownView *countDownView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, strong) BagIdentifyModel *model;
@property (nonatomic, strong) BagIdentifyDetailModel *datalModel;

@property (nonatomic, strong) BagIdentifyHeaderView *header;
@end

@implementation BagVerifyIdentifyVC

- (void)viewDidLoad {
    self.leftTitle = @"Identification";
    [super viewDidLoad];
    self.startTime = [NSDate br_timestamp];
    [self setupUI];
    [self.presenter sendGetIdentifyRequestWithProductId:self.productId];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BagTrackHandleManager trackAppEventName:@"af_cc_page_cer" withElementParam:@{}];
}
- (void)setupUI{
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
#pragma mark - action
- (void)onNextClick{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (BagBasicRowModel *obj in self.datalModel.railageF) {
        if(obj.escarpmentF.integerValue == 0){
            if([obj.lorrieF br_isBlankString]){
                
                [BagTrackHandleManager trackAppEventName:@"af_cc_cer_start_err" withElementParam:@{@"tag":NotNull(obj.taxidermyF)}];
                [self showToast:[NSString stringWithFormat:@"Please complete %@", NotNull(obj.stupidF)] duration:1.5];
                return;
            }else{
                [dic setValue:obj.lorrieF forKey:NotNull(obj.taxidermyF)];
                continue;
            }
        }else{
            [dic setValue:NotNull(obj.lorrieF) forKey:NotNull(obj.taxidermyF)];
            continue;
        }
    }
    NSDictionary *pointDic = @{
        @"calcographyF": @(self.startTime.doubleValue),
        @"biolysisF": NotNull(self.productId),
        @"jactancyF":@"24",
        @"hateworthyF":@(BagLocationManager.shareInstance.latitude),
        @"apoenzymeF":@([NSDate br_timestamp].doubleValue),
        @"clapperclawF": NotNull(NSObject.getIDFV),
        @"reinhabitF":@(BagLocationManager.shareInstance.longitude),
    };
    dic[@"point"] = pointDic;
    dic[@"vachelF"]= NotNull(self.productId);
    //在“ocr上传接口(advance ai)（第三项）”获取
    dic[@"methadonF"] = NotNull(self.datalModel.keennessF ? : self.datalModel.lorrieF);
    
    [BagTrackHandleManager trackAppEventName:@"af_cc_start_cer" withElementParam:@{}];

    [self.presenter sendSaveIdentifyRequestWithDic:dic product_id:self.productId];
    [self.presenter sendUploadDeviceRequest];
}
#pragma mark - BagVerifyIdentifyProtocol
- (void)updateUIWithModel:(BagIdentifyModel *)model
{
    _model = model;
    _datalModel = model.holeproofF;
    self.countDownView.countTime = model.analectaF;
    self.tableView.tableHeaderView = self.header;
    if ([model.holeproofF.nonvoterF br_isBlankString]) {
        [self.header selectCardAction];
    }else{
        [self.header updateIDcardImageUrl:model.holeproofF.nonvoterF];
    }
    self.nextBtn.hidden = self.datalModel.railageF.count > 0 ? NO : YES;
    [self.tableView reloadData];
}
- (void)updateUIWithIdentifyDetailModel:(BagIdentifyDetailModel *)model
{
    
    [BagTrackHandleManager trackAppEventName:@"af_cc_success_cer_img" withElementParam:@{}];
    self.datalModel = model;
    [self.header updateIDcardImage:model.idCardImage];
    self.tableView.tableHeaderView = self.header;
    self.nextBtn.hidden = NO;
    [self.tableView reloadData];
}
- (void)jumpNextPageWithProductId:(NSString *)product_id nextUrl:(NSString *)url
{
    [[BagRouterManager shareInstance] routeWithUrl:[url br_pinProductId:product_id]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
- (void)saveIdentifySucceed
{
    [BagTrackHandleManager trackAppEventName:@"af_cc_success_cer" withElementParam:@{}];
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
        [BagTrackHandleManager trackAppEventName:@"af_cc_page_cer_exit" withElementParam:@{}];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [view showWithType:VerifyIdentifictionType];
}
///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    return NO;
}
#pragma mark - table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BagBasicRowModel *model = [self.datalModel.railageF objectAtIndex:indexPath.section];

    WEAKSELF
    if([model.cellType isEqualToString:@"txt"]){
        BagIdentifyTxtCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagIdentifyTxtCell.class)];
        [cell updateUIWithModel:model];
        cell.textBlock = ^(NSString * _Nonnull str) {
            STRONGSELF
            model.lorrieF = NotNull(str);
            [strongSelf tarckSelectResultTagString:model.taxidermyF contentString:str];
        };
        cell.textBeginBlock = ^{
            STRONGSELF
            [strongSelf tarckClickTagString:model.taxidermyF];
        };
        return cell;
    }
    if([model.cellType isEqualToString:@"day"]){
        BagIdentifyDateCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagIdentifyDateCell.class)];
        [cell updateUIWithModel:model];
        cell.clickBlock = ^{
            STRONGSELF
            [strongSelf.view endEditing:YES];
            [strongSelf tarckClickTagString:model.taxidermyF];
            // 1.创建日期选择器
            BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
            // 2.设置属性
            datePickerView.pickerMode = BRDatePickerModeYMD;
            datePickerView.title = model.mudslingerF;
            datePickerView.selectDate = [NSDate date];
            datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
            datePickerView.maxDate = [NSDate br_setYear:2034 month:3 day:12];
            datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                [selectDate   br_year];
                NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld",selectDate.br_day,selectDate.br_month,selectDate.br_year];
                model.lorrieF = date;
                [self.tableView reloadData];
                [self tarckSelectResultTagString:model.taxidermyF contentString:model.lorrieF];
                NSLog(@"选择的值：%@", selectValue);
            };
            datePickerView.isAutoSelect = NO;
            // 设置自定义样式
            BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
            customStyle.pickerColor = [UIColor whiteColor];
            customStyle.titleTextColor = customStyle.cancelColor = customStyle.doneColor = [UIColor whiteColor];
            customStyle.titleBarColor = [UIColor qmui_colorWithHexString:@"#1E59A2"];
            
            customStyle.pickerTextColor = [UIColor br_colorWithRGB:0x1B1622];
            customStyle.separatorColor = [UIColor br_colorWithRGB:0x1B1622];
            customStyle.selectRowTextColor = [UIColor qmui_colorWithHexString:@"#0EB479"];
            customStyle.separatorColor = [UIColor clearColor];
            customStyle.language = @"en";
            customStyle.titleTextFont = [UIFont boldSystemFontOfSize:16];
            customStyle.cancelTextFont = [UIFont boldSystemFontOfSize:16];
            customStyle.doneTextFont = [UIFont boldSystemFontOfSize:16];
            datePickerView.pickerStyle = customStyle;
            // 3.显示
            [datePickerView show];
        };
        return cell;
    }
    if([model.cellType isEqualToString:@"option"]){
        BagIdentifySingleSelectCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagIdentifySingleSelectCell.class)];
        STRONGSELF
        cell.selectBlock = ^(NSString * _Nonnull str) {
            [strongSelf tarckSelectResultTagString:model.taxidermyF contentString:str];
        };
        [cell updateUIWithModel:model];
        return cell;
    }
    return nil;
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datalModel.railageF.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor qmui_colorWithHexString:@"#ffffff"];
    return view;
}
 - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}
#pragma mark - 用户点击埋点
- (void)tarckClickTagString:(NSString*)tagStr
{
    [BagTrackHandleManager trackAppEventName:@"af_pub_click_cer_item" withElementParam:@{@"tag": NotNull(tagStr)}];
}

#pragma mark - 用户选择结果埋点
- (void)tarckSelectResultTagString:(NSString*)tagStr contentString:(NSString*)contentStr
{
    [BagTrackHandleManager trackAppEventName:@"af_pub_result_cer_item" withElementParam:@{@"tag": NotNull(tagStr),
                       @"content": NotNull(contentStr)}];
}

#pragma mark - getter
- (BagVerifyIdentifyPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [BagVerifyIdentifyPresenter new];
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
//        [_tableView registerClass:[BagIdentifyTxtCell class] forCellReuseIdentifier:NSStringFromClass(BagIdentifyTxtCell.class)];
//        [_tableView registerClass:[BagIdentifySingleSelectCell class] forCellReuseIdentifier:NSStringFromClass(BagIdentifySingleSelectCell.class)];
//        [_tableView registerClass:[BagIdentifyDateCell class] forCellReuseIdentifier:NSStringFromClass(BagIdentifyDateCell.class)];

        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagIdentifyTxtCell.class)] forCellReuseIdentifier:NSStringFromClass(BagIdentifyTxtCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagIdentifySingleSelectCell.class)] forCellReuseIdentifier:NSStringFromClass(BagIdentifySingleSelectCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagIdentifyDateCell.class)] forCellReuseIdentifier:NSStringFromClass(BagIdentifyDateCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;

        }
    }
    return _tableView;
}
- (BagIdentifyHeaderView *)header
{
    if (!_header) {
        _header = [BagIdentifyHeaderView createView];
        WEAKSELF
        _header.selectTypeBlock = ^{
            [BagTrackHandleManager trackAppEventName:@"af_cc_click_cer_type" withElementParam:@{}];

            BagVerifyPickerView *picker = [[BagVerifyPickerView alloc] initWithTitleArray:weakSelf.model.holeproofF.maquisF headerTitle:@"Select An ID Type"];
            picker.clickBlock = ^(BagIdentifyListModel *model) {
                [weakSelf.header updateModel:model];
                [BagTrackHandleManager trackAppEventName:@"af_cc_result_cer_type" withElementParam:@{@"type:":@(model.conniptionF)}];
            };
            [picker showWithAnimation];
        };
        _header.idCardImageClickBlock = ^{
            STRONGSELF
            if(strongSelf.header.selectIdCardNo == 0){
                [strongSelf showToast:@"please select a id type" duration:1.5];
                return;
            }
            [BagTrackHandleManager trackAppEventName:@"af_cc_click_cer_img" withElementParam:@{}];
            
            BagVerifyPickerView *picker = [[BagVerifyPickerView alloc] initWithTitleArray:@[@"Photo",@"Camera"] headerTitle:@"Select Upload Method"];
            [picker showWithAnimation];
            picker.clickBlock = ^(NSString *model) {
                NSString *seleStr = (NSString*)model;
                if([seleStr isEqualToString:@"Photo"]){
                    [strongSelf showPhotoLibraryCanEdit:NO photo:^(UIImage *photo) {
                        if (photo) {
                            [BagTrackHandleManager trackAppEventName:@"af_cc_start_cer_img" withElementParam:@{}];
                            [strongSelf.presenter sendUploadImageRequestWithDic:@{@"light":@(strongSelf.header.selectIdCardNo)} image:photo];
                        }
                    }];
                }else{
                    [strongSelf showCameraCanEdit:NO photo:^(UIImage *photo) {
                        if (photo) {
                            [BagTrackHandleManager trackAppEventName:@"af_cc_start_cer_img" withElementParam:@{}];
                            [strongSelf.presenter sendUploadImageRequestWithDic:@{@"light":@(strongSelf.header.selectIdCardNo)} image:photo];
                        }
                    }];
                }
            } ;
        };
    }
    return _header;
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
        _countDownView.step = 3;
    }
    return _countDownView;
}


@end
