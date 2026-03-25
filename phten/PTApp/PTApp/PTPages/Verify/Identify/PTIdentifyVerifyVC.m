//
//  PTIdentifyVerifyVC.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTIdentifyVerifyVC.h"
#import "PTIdentifyVerifyPresenter.h"
#import "PTVerifyCountDownView.h"
#import "PTVerifyEnumCell.h"
#import "PTVerifyTextInputCell.h"
#import "PTIdentifyVerifySingleSelectCell.h"
#import "PTIdentifyModel.h"
#import "PTBasicVerifyModel.h"
#import "BRDatePickerView.h"
#import "PTIdentifyVerifyHeaderView.h"
#import "PTIdentifyVerifySelectCardVC.h"
#import "UIViewController+PTPhoto.h"
#import "PTVerifyPickerView.h"
#import "PTVerifyPleaseLeftView.h"
#import "HXPhotoPicker.h"
@interface PTIdentifyVerifyVC ()<UITableViewDelegate,UITableViewDataSource,PTIdentifyVerifyProtocol>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) PTIdentifyVerifyHeaderView *headerView;

@property (nonatomic, strong) PTVerifyCountDownView *countDownView;
@property (nonatomic, strong) PTIdentifyVerifyPresenter *presenter;
@property (nonatomic, strong) PTIdentifyModel *model;
@property (nonatomic, strong) PTIdentifyDetailModel *datalModel;

@end

@implementation PTIdentifyVerifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showtitle:@"ldentification" isLeft:NO disPlayType:PTDisplayTypeBlack];
    [self.presenter pt_sendGetIdentifyRequestWithProductId:self.productId];
    [self setupUI];
    self.view.backgroundColor = PTUIColorFromHex(0xF5F9FF);
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
    view.step = 3;
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
#pragma makrk - PTIdentifyVerifyProtocol
- (void)updateUIWithModel:(PTIdentifyModel *)model
{
    _model = model;
    _datalModel = model.catensabNc;
    self.countDownView.countTime = model.pateneographerNc;
    self.countDownView.hidden = NO;
    self.tableView.tableHeaderView = self.headerView;
    if ([model.catensabNc.retenloomNc br_isBlankString]) {
        [self.headerView selectCardAction];
    }else{
        __block NSString *name = @"";
        [model.catensabNc.tutenbodrillNc enumerateObjectsUsingBlock:^(PTIdentifyListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.catensabNc.detencaleNc == obj.cetenNc) {
                name = obj.rotenanizeNc;
            }
        }];
        [self.headerView updateIDcardImageUrl:model.catensabNc.retenloomNc bankName:name];
    }
    self.saveBtn.hidden = self.datalModel.xatenthosisNc.count > 0 ? NO : YES;
    [self.tableView reloadData];
}
//上传图片后更新 UI
- (void)updateUIWithIdentifyDetailModel:(PTIdentifyDetailModel *)model
{
    self.datalModel = model;
    [self.headerView updateIDcardImage:model.idCardImage];
    self.tableView.tableHeaderView = self.headerView;
    self.saveBtn.hidden = NO;
    [self.tableView reloadData];
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
        make.height.mas_equalTo((kScreenWidth-32)/343*222.f);
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
    WEAKSELF
    self.headerView.selectTypeBlock = ^{
        
        PTVerifyPickerView *picker = [[PTVerifyPickerView alloc] initWithTitleArray:weakSelf.model.catensabNc.tutenbodrillNc headerTitle:@"Select An ID Type"];
        picker.clickBlock = ^(PTIdentifyListModel *model) {
            [weakSelf.headerView updateModel:model];
        };
        [picker showWithAnimation];
    };
    self.headerView.uploadClickBlock = ^{
        STRONGSELF
        if(strongSelf.headerView.selectIdCardNo == 0){
            [strongSelf showToast:@"please select a id type" duration:1.5];
            return;
        }
        PTVerifyPickerView *picker = [[PTVerifyPickerView alloc] initWithTitleArray:@[@"Photo",@"Camera"] headerTitle:@"Select Upload Method"];
        [picker showWithAnimation];
        picker.clickBlock = ^(NSString *model) {
            NSString *seleStr = (NSString*)model;
            if([seleStr isEqualToString:@"Photo"]){
                HXPhotoManager *manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
                manager.configuration.openCamera = NO;
                manager.configuration.type = HXConfigurationTypeWXChat;
                manager.configuration.cameraCellShowPreview = NO;
                manager.configuration.photoMaxNum = 1;
                manager.configuration.photoCanEdit = NO;
                manager.configuration.videoCanEdit = NO;
                manager.configuration.photoListBottomView = ^(HXPhotoBottomView *bottomView) {

                };
                manager.configuration.previewBottomView = ^(HXPhotoPreviewBottomView *bottomView) {

                };
                manager.configuration.allowPreviewDirectLoadOriginalImage = YES;
                [weakSelf hx_presentSelectPhotoControllerWithManager:manager didDone:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL isOriginal, UIViewController *viewController, HXPhotoManager *manager) {
                    
                    HXPhotoModel *model = photoList[0];
                    [[PHImageManager defaultManager] requestImageForAsset:model.asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage *resultImage, NSDictionary *info) {
                            
                        UIImage *photo = resultImage;
                        [strongSelf.presenter pt_uploadImageRequestWithDic:@{@"light":@(strongSelf.headerView.selectIdCardNo)} image:photo];
                        }];

                } cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
                }];
//                [strongSelf showPhotoLibraryCanEdit:NO photo:^(UIImage *photo) {
//                    if (photo) {
//                        [strongSelf.presenter pt_uploadImageRequestWithDic:@{@"light":@(strongSelf.headerView.selectIdCardNo)} image:photo data:<#(nonnull NSData *)#>];
//                    }
//                }];
            }else{
                [strongSelf showCameraCanEdit:NO photo:^(UIImage *photo) {
                    if (photo) {
                        [strongSelf.presenter pt_uploadImageRequestWithDic:@{@"light":@(strongSelf.headerView.selectIdCardNo)} image:photo];;
                    }
                }];
            }
        } ;
    };
}
#pragma marl - PTIdentifyVerifyProtocol
- (void)router:(NSString *)url
{
    [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:url];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
- (void)saveIdentifySucceed
{
    
}
#pragma mark - action
/**保存数据**/
- (void)onNextClick{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (PTBasicRowModel *obj in self.datalModel.xatenthosisNc) {
        //是否可选
        if(obj.tatenpaxNc.integerValue == 0){
            if([PTNotNull(obj.datenrymanNc) br_isBlankString]){              
                [self showToast:[NSString stringWithFormat:@"Please complete %@", PTNotNull(obj.orteninarilyNc)] duration:2];
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
    NSDictionary *pointDic = @{
                                @"detenamatoryNc": @(self.startTime.doubleValue),
                                @"mutenniumNc": PTNotNull(self.productId),
                                @"hytenrarthrosisNc":@"24",
                                @"botenomofoNc":PTNotNull([PTLocationManger sharedPTLocationManger].latitude),
                                @"untenulyNc":@([NSDate br_timestamp].doubleValue),
                                @"catencotomyNc": PTNotNull([PTDeviceInfo idfv]),
                                @"untenevoutNc":PTNotNull([PTLocationManger sharedPTLocationManger].longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"litenetusNc"]= PTNotNull(self.productId);
    dic[@"seteniabstractNc"] = PTNotNull(self.datalModel.patenalympicsNc ? : self.datalModel.datenrymanNc);
//开始请求
    [self.presenter pt_sendSaveIdentifyRequestWithDic:dic product_id:self.productId];
    [self.presenter pt_sendUploadDeviceRequest];
}


#pragma mark - table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTBasicRowModel *model = [self.datalModel.xatenthosisNc objectAtIndex:indexPath.row];

    WEAKSELF
    if([model.cellType isEqualToString:@"txt"]){
        PTVerifyTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTVerifyTextInputCell.class)];
        [cell configUI:model index:indexPath tableView:self.tableView Y:0];
        cell.textBlock = ^(NSString * _Nonnull str) {
            STRONGSELF
            model.datenrymanNc = PTNotNull(str);
        };
        cell.textBeginBlock = ^{
            STRONGSELF
        };
        return cell;
    }
    if([model.cellType isEqualToString:@"day"]){
        PTVerifyEnumCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTVerifyEnumCell.class)];
        [cell configUIWithModel:model];
        cell.clickBlock = ^{
            STRONGSELF
            [strongSelf.view endEditing:YES];
            // 1.创建日期选择器
            BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
            // 2.设置属性
            datePickerView.pickerMode = BRDatePickerModeYMD;
            datePickerView.title = model.fltendgeNc;
            datePickerView.selectDate = [NSDate date];
            datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
            datePickerView.maxDate = [NSDate br_setYear:2023 month:12 day:31];
            datePickerView.isAutoSelect = NO;
            datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld",selectDate.br_day,selectDate.br_month,selectDate.br_year];
                model.datenrymanNc = date;
                [self.tableView reloadData];
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
        return cell;
    }
    if([model.cellType isEqualToString:@"option"]){
        PTIdentifyVerifySingleSelectCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTIdentifyVerifySingleSelectCell.class)];
//        STRONGSELF
//        cell.selectBlock = ^(NSString * _Nonnull str) {
//            [strongSelf tarckSelectResultTagString:model.taxidermyF contentString:str];
//        };
        [cell configUIWithModel:model];
        return cell;
    }
    return [[UITableViewCell alloc] init];
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalModel.xatenthosisNc.count;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.f;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//    view.backgroundColor = [UIColor qmui_colorWithHexString:@"#ffffff"];
//    return view;
//}
 - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
#pragma mark -
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PTVerifyTextInputCell class] forCellReuseIdentifier:NSStringFromClass(PTVerifyTextInputCell.class)];
        [_tableView registerClass:[PTVerifyEnumCell class] forCellReuseIdentifier:NSStringFromClass(PTVerifyEnumCell.class)];
        [_tableView registerClass:[PTIdentifyVerifySingleSelectCell class] forCellReuseIdentifier:NSStringFromClass(PTIdentifyVerifySingleSelectCell.class)];
        
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (PTIdentifyVerifyHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[PTIdentifyVerifyHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 351+16)];
       
    }
    return _headerView;
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
        _countDownView.step = 3;
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
- (PTIdentifyVerifyPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [PTIdentifyVerifyPresenter new];
        _presenter.delegate = self;
    }
    return _presenter;
}
@end
