//
//  BagHomeViewController.m
//  NewBag
//
//  Created by Jacky on 2024/3/14.
//

#import "BagHomeViewController.h"
#import "BagLoginViewController.h"
#import "BagHomePresenter.h"
#import "BagHomeWalkHorseCell.h"
#import "BagHomeBigCardTableViewCell.h"
#import "BagHomeSmallCardCell.h"
#import "BagHomeProductListCell.h"
#import "BagHomeBrandCell.h"
#import "BagHomeBannerCell.h"
#import "BagHomeModel.h"
#import "PUBDragView.h"
#import "AFNetworking.h"
#import "BagOpenLocationAlert.h"
#import "BagHomeOpenView.h"
@interface BagHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,BagHomePresenterProtocol>
@property (nonatomic, strong) BagHomePresenter *presenter;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <BagHomeModel *>*dataArray;
@property(nonatomic, strong) PUBDragView *dragView;
@property(nonatomic, copy) NSString *jumpUrl;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong)  UIImageView *topBcakImage;
@end

@implementation BagHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"dargView" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSDictionary *dic = x.object;
        if ([dic[@"hidden"] intValue] == 1) {
            self.dragView.hidden = YES;
        }else{
            self.dragView.hidden = NO;
        }
    }];
    WEAKSELF
    [RACObserve(AFNetworkReachabilityManager.sharedManager, networkReachabilityStatus) subscribeNext:^(NSNumber *x) {
        if (x.intValue == 1 || x.intValue == 2) {
            STRONGSELF
            [strongSelf.presenter sendGetHomeRequest];
        }
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NetWorkMonitor object:nil] subscribeNext:^(NSNotification * _Nullable x) {
       STRONGSELF
        [strongSelf loadVCImage];
    }];
    [self.presenter sendGetHomePop];
}
- (void)setupUI{
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#F4F7FA"];
    self.hidesBottomBarWhenPushed = NO;
    
   self.topBcakImage = [[UIImageView alloc] init];
    self.topBcakImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview: self.topBcakImage];
    [self.topBcakImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(265);
    }];
    
    _icon = [[UIImageView alloc] init];
//    _icon.layer.cornerRadius = 20.f;
//    _icon.layer.masksToBounds = YES;
  //  _icon.image = [UIImage imageNamed:@"login_logo"];
    _icon.hidden = YES;
    [self.view addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.top.mas_equalTo(56);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = appName;
    _titleLabel.hidden = YES;
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).offset(11);
        make.centerY.mas_equalTo(_icon);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    self.tableView.contentInset = UIEdgeInsetsMake(106, 0, 0, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([UIApplication sharedApplication].windows.firstObject) {
            [self.dragView setFrame: CGRectMake(SCREEN_WIDTH - 61, kStatusBarHeight+10, 56, 52)];
            [[UIApplication sharedApplication].windows.firstObject addSubview:self.dragView];
        }
    });
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.presenter sendGetHomeRequest];
    self.dragView.hidden = NO;
    [BagTrackHandleManager trackAppEventName:@"af_cc_page_home" withElementParam:@{}];

}

- (void)loadVCImage
{
    [self.topBcakImage sd_setImageWithURL:[Util loadImageUrl:@"home_bg"]];
    [_icon sd_setImageWithURL:[Util loadImageUrl:@"login_logo"]];
}

#pragma mark - 点击申请
- (void)applyClickWithProductId:(NSString *)product_id
{
    if ([product_id br_isBlankString]) {
        return;
    }
    WEAKSELF
    if (![BagUserManager shareInstance].isLogin) {
        [[BagRouterManager shareInstance] jumpLoginWithSuccessBlock:^{
            [weakSelf applyClickWithProductId:product_id];
        }];
        return;
    }
    if ([BagUserManager shareInstance].is_aduit) {
        [self.presenter sendApplyRequestWithProductId:product_id];
        return;
    }
    [[BagLocationManager shareInstance] startLocation];
    
    // 检查定位权限状态
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted) {
        // 定位权限被拒绝或受限制
        [self showCLAuthorizationView];
        return;
    }else if (authorizationStatus == kCLAuthorizationStatusNotDetermined){
        [[BagLocationManager shareInstance] checkLocationStatus:^(BOOL value) {
            if(value){
                [weakSelf.presenter sendApplyRequestWithProductId:product_id];
            }else{
                [weakSelf showCLAuthorizationView];
            }
        }];
        return;
    }
    
    [self.presenter sendApplyRequestWithProductId:product_id];
    
}

#pragma mark - 展示定位授权弹窗
- (void)showCLAuthorizationView
{
    
    BagOpenLocationAlert *alert = [BagOpenLocationAlert createView];
    alert.clickBlock = ^{
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        };
    };
    [alert show];
}

- (void)sendApplyRequestWithProductId:(NSString *)product_id{
    [BagTrackHandleManager trackAppEventName:@"af_cc_click_admittance" withElementParam:@{ @"productId":NotNull(product_id),}];
    [self.presenter sendApplyRequestWithProductId:product_id];
}
#pragma mark - BagHomePresenterProtocol
- (void)reloadUIWithDataArray:(NSArray<BagHomeModel *> *)data customerModel:(BagHomeCustomerModel *)model
{
    self.dataArray = data;
    self.jumpUrl = model.kichfourteeniNc;
    self.icon.hidden = self.titleLabel.hidden = YES;
   
    [self.tableView reloadData];
    [self.dragView.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.intafourteenntNc]] placeholderImage:[UIImage imageNamed:@"icon-kf"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(!image)return;
        self.dragView.imageView.frame = self.dragView.bounds;
        self.dragView.mj_x = kScreenWidth - 61.f;
        if ([UIApplication sharedApplication].keyWindow) {
            [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.dragView];
        }
    }];
}
- (void)updatePop:(BagHomePopModel *)model
{
    if ([NotNull(model.meulfourteenloblastomaNc) br_isBlankString]) {
        return;
    }
    BagHomeOpenView *view = [BagHomeOpenView createView];
    view.tapBlock = ^{
        if ([NotNull(model.relofourteenomNc) br_isBlankString]) {
            return;
        }
        [self jumpWeb:model.relofourteenomNc];
    };
    [view updateUIWithIconUrl:model.meulfourteenloblastomaNc];
    [view show];
}
//跳 web
- (void)jumpWeb:(NSString *)url
{
    BagWebViewController *web = [BagWebViewController new];
    web.url = url;
    [self.navigationController qmui_pushViewController:web animated:YES completion:nil];
}
- (void)jumpLoanDetailWithProductId:(NSString *)product_id
{
    [[BagRouterManager shareInstance] jumpLoanWithProId:product_id];
}
- (void)router:(NSString *)url
{
    [[BagRouterManager shareInstance] routeWithUrl:url];
}
#pragma mark - 协议点击
/// 协议按钮点击
- (void)privacyClick
{
    BagWebViewController *web = [BagWebViewController new];
    web.url = [NSString stringWithFormat:@"%@/%@",bagH5Url,bagPrivacyProtocol];
    [self.navigationController pushViewController:web animated:YES];
}
#pragma mark - table datasource&delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    BagHomeModel *model = self.dataArray[indexPath.row];
    if ([model.cellId isEqual:Home_BANNER]) {
        BagHomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagHomeBannerCell.class)];
        cell.bannerClickBlock = ^(BagHomeBannerItemModel * _Nonnull model) {
            STRONGSELF
            if([model.relofourteenomNc br_isBlankString])return;
            BagWebViewController *webVC = [[BagWebViewController alloc] init];
            webVC.url = model.relofourteenomNc;
            [strongSelf.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
        };
        [cell updateUIWithModel:(BagHomeBannerModel *)model];
        return cell;
    }
    if ([model.cellId isEqual:Home_LARGE_CARD]) {
        BagHomeBigCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagHomeBigCardTableViewCell.class)];
        cell.applyClickBlock = ^{
            [self applyClickWithProductId:((BagHomeBigCardItemModel *)model).regnfourteenNc];
        };
        [cell updateUIWithModel:(BagHomeBigCardItemModel *)model];
        if (BagUserManager.shareInstance.is_aduit) {
            self.icon.hidden = self.titleLabel.hidden = NO;
        }
        return cell;
    }
    if ([model.cellId isEqual:Home_SMALL_CARD]) {
        BagHomeSmallCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagHomeSmallCardCell.class)];
        cell.applyClickBlock = ^{
            [self applyClickWithProductId:((BagHomeSmallCardModel *)model).regnfourteenNc];
        };
        [cell updateUIWithModel:(BagHomeSmallCardModel *)model];
        self.icon.hidden = self.titleLabel.hidden = NO;
        return cell;
    }
    if ([model.cellId isEqual:@"BRAND"]) {
        BagHomeBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagHomeBrandCell.class)];
        cell.protocolClick = ^{
            [self privacyClick];
        };
        return cell;
    }
    if ([model.cellId isEqual:Home_RIDING_LANTERN]) {
        BagHomeWalkHorseCell *walkCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagHomeWalkHorseCell.class)];
        [walkCell updateUIWithModel:(BagHomeHorseModel *)model];
        return walkCell;
    }
    if ([model.cellId isEqual:Home_PRODUCT_LIST]) {
        BagHomeProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagHomeProductListCell.class)];
        cell.applyClickBlock = ^{
            [self applyClickWithProductId:((BagHomeProductListItemModel *)model).regnfourteenNc];
        };
        [cell updateUIWithModel:(BagHomeProductListItemModel *)model];
        return cell;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count > indexPath.row) {
        BagHomeModel *model = self.dataArray[indexPath.row];
        return model.cellHeight;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isSelf = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isSelf animated:YES];
}
#pragma mark - getter
- (BagHomePresenter *)presenter
{
    if (!_presenter) {
        _presenter = [[BagHomePresenter alloc] init];
        _presenter.delegate = self;
    }
    return _presenter;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagHomeBigCardTableViewCell.class)] forCellReuseIdentifier:NSStringFromClass(BagHomeBigCardTableViewCell.class)];
//        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagHomeWalkHorseCell.class)] forCellReuseIdentifier:NSStringFromClass(BagHomeWalkHorseCell.class)];
        [_tableView registerClass:[BagHomeWalkHorseCell class] forCellReuseIdentifier:NSStringFromClass(BagHomeWalkHorseCell.class)];
        [_tableView registerClass:[BagHomeBannerCell class] forCellReuseIdentifier:NSStringFromClass(BagHomeBannerCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagHomeSmallCardCell.class)] forCellReuseIdentifier:NSStringFromClass(BagHomeSmallCardCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagHomeProductListCell.class)] forCellReuseIdentifier:NSStringFromClass(BagHomeProductListCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagHomeBrandCell.class)] forCellReuseIdentifier:NSStringFromClass(BagHomeBrandCell.class)];
        
    }
    return _tableView;
}
- (PUBDragView *)dragView{
    if(!_dragView){
        _dragView = [[PUBDragView alloc] initWithFrame:CGRectMake(90.f, kStatusBarHeight+15, 60.f, 60.f)];
        _dragView.isKeepBounds = YES;
        _dragView.imageView.image = [UIImage imageNamed:@"icon-kf"];
        WEAKSELF
        _dragView.clickDragViewBlock = ^(PUBDragView * _Nonnull dragView) {
            STRONGSELF
            if ([NotNull(strongSelf.jumpUrl) br_isBlankString]) {
                return;
            }
            BagWebViewController *webVC = [[BagWebViewController alloc] init];
            webVC.url = strongSelf.jumpUrl;
            [[BagRouterManager shareInstance] pushToViewController:webVC];
        };
    }
    return _dragView;
}

@end
