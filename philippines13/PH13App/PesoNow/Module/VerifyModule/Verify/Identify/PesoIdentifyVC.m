//
//  PesoIdentifyVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoIdentifyVC.h"
#import "PesoVerifyStepView.h"
#import "PesoIdentifyModel.h"
#import "PesoIdentifyHeaderView.h"
#import "PesoIdentifySingleCell.h"
#import "PesoIdentifyViewModel.h"
#import "PesoVerifyWanliuView.h"

#import "PesoBasicEnumCell.h"
#import "PesoBasicInputCell.h"
#import "PesoEnumPicker.h"
#import "PesoBasicModel.h"
#import "PesoHomeViewModel.h"

#import "BRDatePickerView.h"
#import "UIViewController+PTPhoto.h"
#import "HXPhotoPicker.h"
@interface PesoIdentifyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PesoVerifyStepView *stepView;
@property (nonatomic, strong) QMUIButton *saveBtn;
@property (nonatomic, strong) PesoIdentifyHeaderView *headerView;

@property (nonatomic, strong) PesoIdentifyModel *model;
@property (nonatomic, strong) PesoIdentifyDetailModel *datalModel;
@property (nonatomic, strong) PesoIdentifyViewModel *viewModel;
@end

@implementation PesoIdentifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF
    [self.viewModel loadGetIdentifyRequestWithProductId:self.productId callback:^(PesoIdentifyModel*  _Nonnull model) {
        weakSelf.model = model;
        weakSelf.datalModel = model.casathirteenbNc;
        weakSelf.stepView.hidden = NO;
        weakSelf.stepView.countTime = model.paeothirteengrapherNc;
        weakSelf.tableView.tableHeaderView = weakSelf.headerView;
        if (br_isEmptyObject(model.casathirteenbNc.relothirteenomNc)) {
            [weakSelf.headerView clickCardType];
        }else{
            __block NSString *name = @"";
            [model.casathirteenbNc.tubothirteendrillNc enumerateObjectsUsingBlock:^(PesoIdentifyListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model.casathirteenbNc.decathirteenleNc == obj.ceNcthirteen) {
                    name = obj.roanthirteenizeNc;
                }
            }];
            [self.headerView updateIDcardImageUrl:model.casathirteenbNc.relothirteenomNc bankName:name];
        }
        self.saveBtn.hidden = self.datalModel.xaththirteenosisNc.count > 0 ? NO : YES;
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
    alert.step = 3;
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
    
    UIImageView *titleImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"identify_title"]];
    titleImage.contentMode = UIViewContentModeScaleAspectFit;
    titleImage.frame = CGRectMake(0, kNavBarAndStatusBarHeight - 20, 269, 34);
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
    _stepView.step = 3;
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
    for (PesoBasicRowModel *obj in self.datalModel.xaththirteenosisNc) {
        //是否可选
        if(obj.tapathirteenxNc.integerValue == 0){
            if(br_isEmptyObject(obj.darythirteenmanNc)){
                [PesoUtil showToast:[NSString stringWithFormat:@"Please complete %@", NotNil(obj.orinthirteenarilyNc)]];
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
    dic[@"point"] = [self getaSomeApiParam:self.productId sceneType:@"24"];
    dic[@"lietthirteenusNc"]= NotNil(self.productId);
    dic[@"seiathirteenbstractNc"] = NotNil(self.datalModel.paalthirteenympicsNc ? : self.datalModel.darythirteenmanNc);
//开始请求
    [[PesoLocationCenter sharedPesoLocationCenter] uploadDeviceInfo];
    WEAKSELF
    [self.viewModel loadSaveIdentifyRequestWithDic:dic product_id:self.productId callback:^(NSString *url) {
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
                [self routerUrl:[url pinProductId:self.productId]];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalModel.xaththirteenosisNc.count;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PesoBasicRowModel *model = [self.datalModel.xaththirteenosisNc objectAtIndex:indexPath.row];

    WEAKSELF
    if([model.cellType isEqualToString:@"txt"]){
        PesoBasicInputCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoBasicInputCell.class)];
        [cell configUI:model index:indexPath tableView:self.tableView Y:0];
        cell.textBlock = ^(NSString * _Nonnull str) {
            
            model.darythirteenmanNc = NotNil(str);
        };
        cell.textBeginBlock = ^{
            
        };
        return cell;
    }
    if([model.cellType isEqualToString:@"day"]){
        PesoBasicEnumCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoBasicEnumCell.class)];
        [cell configUIWithModel:model];
        cell.clickBlock = ^{
            STRONGSELF
            [strongSelf.view endEditing:YES];
            // 1.创建日期选择器
            BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
            // 2.设置属性
            datePickerView.pickerMode = BRDatePickerModeYMD;
            datePickerView.title = model.fldgthirteeneNc;
            datePickerView.selectDate = [NSDate date];
            datePickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
            datePickerView.maxDate = [NSDate br_setYear:2023 month:12 day:31];
            datePickerView.isAutoSelect = NO;
            datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld",selectDate.br_day,selectDate.br_month,selectDate.br_year];
                model.darythirteenmanNc = date;
                [self.tableView reloadData];
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
        };
        return cell;
    }
    if([model.cellType isEqualToString:@"option"]){
        PesoIdentifySingleCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoIdentifySingleCell.class)];
        [cell configUIWithModel:model];
        return cell;
    }
    return [[UITableViewCell alloc] init];
   
}
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
        [_tableView registerClass:[PesoIdentifySingleCell class] forCellReuseIdentifier:NSStringFromClass(PesoIdentifySingleCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (PesoIdentifyHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[PesoIdentifyHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 346)];
        WEAKSELF
        _headerView.selectTypeBlock = ^{
            
            PesoEnumPicker *picker = [[PesoEnumPicker alloc] initWithTitleArray:weakSelf.model.casathirteenbNc.tubothirteendrillNc headerTitle:@"Select An ID Type"];
            picker.clickBlock = ^(PesoIdentifyListModel *model) {
                [weakSelf.headerView updateModel:model];
            };
            [picker showWithAnimation];
        };
        _headerView.uploadClickBlock = ^{
            STRONGSELF
            if(strongSelf.headerView.selectIdCardNo == 0){
                [PesoUtil showToast:@"please select a id type"];
                return;
            }
            PesoEnumPicker *picker = [[PesoEnumPicker alloc] initWithTitleArray:@[@"Photo",@"Camera"] headerTitle:@"Select Upload Method"];
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
                            if (resultImage) {
                                NSNumber *key = info[@"PHImageResultIsDegradedKey"];
                                if (key.boolValue == NO) {
                                    UIImage *photo = resultImage;
                                    [strongSelf.viewModel loadUploadImageRequestWithDic:@{@"light":@(strongSelf.headerView.selectIdCardNo)} image:photo callback:^(PesoIdentifyDetailModel *model) {
                                        weakSelf.datalModel = model;
                                        [weakSelf.headerView updateIDcardImage:model.idCardImage];
                                        weakSelf.tableView.tableHeaderView = weakSelf.headerView;
                                        weakSelf.saveBtn.hidden = NO;
                                        [weakSelf.tableView reloadData];
                                    }];
                                }
                            }
                        }];
                    } cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
                    }];
                }else{
                    [strongSelf showCameraCanEdit:NO photo:^(UIImage *photo) {
                        if (photo) {
                            [strongSelf.viewModel loadUploadImageRequestWithDic:@{@"light":@(strongSelf.headerView.selectIdCardNo)} image:photo callback:^(PesoIdentifyDetailModel  *model) {
                                weakSelf.datalModel = model;
                                [weakSelf.headerView updateIDcardImage:model.idCardImage];
                                weakSelf.tableView.tableHeaderView = weakSelf.headerView;
                                weakSelf.saveBtn.hidden = NO;
                                [weakSelf.tableView reloadData];
                            }];
                        }
                    }];
                }
            } ;
        };
       
    }
    return _headerView;
}
- (PesoIdentifyViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [PesoIdentifyViewModel new];
    }
    return _viewModel;
}
@end
