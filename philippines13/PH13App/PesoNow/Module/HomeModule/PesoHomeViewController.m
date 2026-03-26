//
//  PesoHomeViewController.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoHomeViewController.h"

#import "HomeHeader.h"
@interface PesoHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) PesoHomeViewModel *viewModel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BOOL isBlock;
@property (nonatomic, strong) PesoDragView *dragView;
@property (nonatomic, copy) NSString *kefuUrl;

@end

@implementation PesoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hiddenBackBtn = YES;
    [self loadData];
    [self loadPopData];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"hiddenDargView" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSDictionary *dic = x.object;
        if ([dic[@"hidden"] intValue] == 1) {
            self.dragView.hidden = YES;
        }else{
            self.dragView.hidden = NO;
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)loadData{
    WEAKSELF
    [self.viewModel loadHomeData:^(id  _Nonnull model) {
        weakSelf.bgImage.hidden = NO;
        RACTuple *tuple = (RACTuple *)model;
        NSArray *dataArray = tuple.first;
        NSString *iconUrl = tuple.second;
        NSString *jumpUrl = tuple.third;
        weakSelf.dataArray = dataArray;
        weakSelf.kefuUrl = jumpUrl;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            if (br_isNotEmptyObject(iconUrl)) {
                weakSelf.dragView.hidden = NO;
                [weakSelf.dragView.imageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"home_kefu"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    weakSelf.dragView.imageView.frame = weakSelf.dragView.bounds;
                    weakSelf.dragView.mj_x = kScreenWidth - 87 - 20;
                }];;
            }else{
                weakSelf.dragView.hidden = YES;
            }
        });
    }];
}
- (void)loadPopData{
    [self.viewModel loadHomePopData:^(id  _Nonnull model) {
        RACTuple *tuple = model;
        NSString *url = tuple.first;
        NSString *jumpURL = tuple.second;
        if (br_isNotEmptyObject(url)) {
            PesoHomeOpenView *pop = [[PesoHomeOpenView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            pop.clickBlock = ^{
                if (br_isEmptyObject(jumpURL)) {
                    return;
                }
                PesoWebVC *web = [PesoWebVC new];
                web.url = jumpURL;
                [[PesoRootVCCenter sharedPesoRootVCCenter] pushToVC:web];
            };
            [pop updatePopWithIconURL:url];
            [pop show];
        }
    }];
}
- (void)createUI
{
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_home_top2"]];
    bgImage.contentMode = UIViewContentModeScaleAspectFill;
    bgImage.frame = CGRectMake(0, 0, kScreenWidth, 406);
    bgImage.hidden = YES;
    [self.view addSubview:bgImage];
    self.tableView.contentInset = UIEdgeInsetsMake(kStatusBarHeight, 0, 0, 0);
    _bgImage = bgImage;

    [self.view addSubview:self.tableView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dragView setFrame: CGRectMake(SCREEN_WIDTH - 87 -20, kStatusBarHeight + 50, 87, 87)];
            [UIApplication.sharedApplication.windows.firstObject addSubview:self.dragView];
    });
}
- (void)showLocationAlert{
    PesoHomePermissionAlert *alert = [[PesoHomePermissionAlert alloc] initWithFrame:UIScreen.mainScreen.bounds];
    alert.title = @"To be able to use our app, please turn on your device location services.";
    alert.agreeBlock = ^{
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    };
    [alert show];
}
- (void)applyAction:(NSString *)pro_id{
    if (self.isBlock) {
        return;
    }
    WEAKSELF
    if (![PesoUserCenter sharedPesoUserCenter].isLogin) {
        [[PesoRootVCCenter sharedPesoRootVCCenter] checkLogin:^{
            [weakSelf applyAction:pro_id];
        }];
        return;
    }
    [[PesoLocationCenter sharedPesoLocationCenter] startUpdatingLocation];
    // 检查定位权限状态 isaduit账号除外
    if (![PesoUserCenter sharedPesoUserCenter].isaduit) {
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        if(authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted){
            [self showLocationAlert];
            return;
        }else if (authorizationStatus == kCLAuthorizationStatusNotDetermined){
            [PesoLocationCenter.sharedPesoLocationCenter checkLocationStatus:^(BOOL isYes) {
                STRONGSELF
                if(isYes){
                    [strongSelf sendApplyRequest:pro_id];
                }else{
                    [strongSelf showLocationAlert];
                }
            }];
            return;
        }
    }
   
    [self sendApplyRequest:pro_id];
    self.isBlock = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isBlock = NO;
    });
}
- (void)sendApplyRequest:(NSString *)pro_id{
    [self.viewModel loadApplyRequest:pro_id callback:^(PesoApplyModel *model) {
        if (model.flcNthirteenc == 2) {
            //上传设备信息
            [[PesoLocationCenter sharedPesoLocationCenter] uploadDeviceInfo];
        }
        if (br_isNotEmptyObject(model.relothirteenomNc)) {
            if (![model.relothirteenomNc containsString:@"zzthirteenzv"]) {
                [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:[model.relothirteenomNc pinProductId:pro_id]];
                return;
            }
        }
        //是否跳认证详情页 0 不显示，1显示
//        if(model.detrthirteenogyrateNc){
//            [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:[@"hirteenJump://open/zzthirteenzv" pinProductId:pro_id]];
//            return;
//        }
        [self sendDetail:pro_id];
    }];
}
- (void)sendDetail:(NSString *)pro_id{
    WEAKSELF
    [self.viewModel loadProductDetailRequest:pro_id callback:^(PesoDetailModel *model) {
        [PesoUserCenter sharedPesoUserCenter].order = model.leonthirteenishNc.cokethirteentNc;
        //跳转下一步认证
        if (!br_isEmptyObject(model.heisthirteentopNc.relothirteenomNc)) {
            [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:[model.heisthirteentopNc.relothirteenomNc pinProductId:pro_id]];
            return;
        }
        [weakSelf.viewModel loadPushRequestWithOrderId: [PesoUserCenter sharedPesoUserCenter].order product_id:pro_id callback:^(NSString *url) {
            if (!br_isEmptyObject(url)) {
                [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:[url pinProductId:pro_id]];
                return;
            }
        }];
    }];
   
}
#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PesoHomeBaseModel *model = self.dataArray[indexPath.row];
    return model.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    PesoHomeBaseModel *model = self.dataArray[indexPath.row];
    if ([model.type isEqual:@"Big"]) {
        PesoHomeBigCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoHomeBigCell.class)];
        cell.applyBlock = ^(NSString *pro_id){
            [weakSelf applyAction:pro_id];
        };
        [cell configUIWithModel:model];
        return cell;
    }
    if ([model.type isEqual:@"Small"]) {
        PesoHomeSmallCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoHomeSmallCell.class)];
        cell.applyBlock = ^(NSString *pro_id){
            [weakSelf applyAction:pro_id];
        };
        [cell configUIWithModel:model];
        return cell;
    }
    if ([model.type isEqual:@"Banner"]) {
        PesoHomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoHomeBannerCell.class)];
        cell.click = ^(NSString * _Nonnull url) {
            if (!br_isNotNullOrNil(url)) {
                return;
            }
            [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:url];
        };
        [cell configUIWithModel:model];
        return cell;
    }
    if ([model.type isEqual:@"Repay"]) {
        PesoHomeRepayInfoModel *info =  (PesoHomeRepayInfoModel *)model;
        PHRepayItemModel *item = info.gugothirteenyleNc.firstObject;
        PesoHomeRepayCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoHomeRepayCell.class)];
        [cell configUIWithModel:item.frwnthirteenNc];
        cell.block = ^{
            if (!br_isNotNullOrNil(item.relothirteenomNc)) {
                return;
            }
            [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:item.relothirteenomNc];
        };
        return cell;
    }
    if ([model.type isEqual:@"list"]) {
        PesoHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoHomeListCell.class)];
        PesoHomePLItemModel *itemModel = (PesoHomePLItemModel *)model;
        cell.applyBlock = ^{
            [weakSelf applyAction:itemModel.regnthirteenNc];
        };
        [cell configUIWithModel:itemModel];
        return cell;
    }
    if ([model.type isEqual:@"Brand"]) {
        PesoHomeCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoHomeCompanyCell.class)];
        cell.block = ^{
            NSString *webUrl = [NSString stringWithFormat:@"%@%@",WebBaseUrl,Privacy];
            [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:webUrl];
        };
        return cell;
    }
    return [[UITableViewCell alloc] init];
  
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.0001;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [UIView new];
//}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        [_tableView registerClass:PesoHomeBigCell.class forCellReuseIdentifier:NSStringFromClass(PesoHomeBigCell.class)];
        [_tableView registerClass:PesoHomeSmallCell.class forCellReuseIdentifier:NSStringFromClass(PesoHomeSmallCell.class)];
        [_tableView registerClass:PesoHomeRepayCell.class forCellReuseIdentifier:NSStringFromClass(PesoHomeRepayCell.class)];
        [_tableView registerClass:PesoHomeBannerCell.class forCellReuseIdentifier:NSStringFromClass(PesoHomeBannerCell.class)];
        [_tableView registerClass:PesoHomeListCell.class forCellReuseIdentifier:NSStringFromClass(PesoHomeListCell.class)];
        [_tableView registerClass:PesoHomeCompanyCell.class forCellReuseIdentifier:NSStringFromClass(PesoHomeCompanyCell.class)];
    }
    return _tableView;
}
- (PesoHomeViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[PesoHomeViewModel alloc] init];
    }
    return _viewModel;
}
- (PesoDragView *)dragView
{
    if (!_dragView) {
        _dragView = [[PesoDragView alloc] initWithFrame:CGRectMake(kScreenWidth - 87 -10, kNavBarAndStatusBarHeight + 10, 87, 87)];
        _dragView.isKeepBounds = YES;
        _dragView.backgroundColor = [UIColor clearColor];
        _dragView.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _dragView.freeRect = CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight - kBottomSafeHeight);
        WEAKSELF
        _dragView.clickDragViewBlock = ^(PesoDragView *dragView) {
            STRONGSELF
            if (br_isEmptyObject(strongSelf.kefuUrl)) {
                return;
            }
            [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:strongSelf.kefuUrl];
        };
    }
    return _dragView;
}
@end
