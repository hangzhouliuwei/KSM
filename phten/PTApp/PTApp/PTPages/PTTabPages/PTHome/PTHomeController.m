//
//  PTHomeController.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/25.
//

#import "PTHomeController.h"
#import "PTHomeViewModel.h"
#import "PTHomeNavView.h"
#import "PTHomeIetenNcModel.h"
#import "PTHomeRepayModel.h"

#import "PTHomeBannerModel.h"
#import "PTHomeLargeEcardModel.h"
#import "PTHomeBigCardCell.h"
#import "PTHomeTipCell.h"

#import "PTHomeBrandCell.h"
#import "PTHomeRidingLanternCell.h"
#import "PTRidingLanternModel.h"

#import "PTHomeSmallCardCell.h"
#import "PTHomeSmallCardModel.h"
#import "PTHomeBannerCell.h"
#import "PTHomeBannerModel.h"
#import "PTHomeRepayCell.h"
#import "PTHomeProductListCell.h"
#import "PTHomeProductModel.h"
#import "PTWebViewController.h"
#import "PTAuthPermissionAlertView.h"

#import <CoreLocation/CoreLocation.h>
#import "PTAuthentRouterManager.h"
#import "PTAuthenticationController.h"
#import "WMDragView.h"
#import "PTHomePopView.h"
@interface PTHomeController ()<QMUITableViewDataSource,QMUITableViewDelegate,PTHomeViewModelProtocol>
@property(nonatomic, strong) PTHomeNavView *navBarView;
@property(nonatomic, strong) PTHomeViewModel *viewModel;
@property(nonatomic, strong) QMUITableView *homeTableView;
@property (nonatomic, assign) BOOL isBlock;
@property (nonatomic, strong) WMDragView *dragView;
@property(nonatomic, copy) NSString *kefuJumpUrl;

@end

@implementation PTHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.hidden = YES;
    self.view.backgroundColor = PTUIColorFromHex(0xF5F9FF);
    [self getHomeData];
    [self createSubUI];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"hiddenDargView" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSDictionary *dic = x.object;
        if ([dic[@"hidden"] intValue] == 1) {
            self.dragView.hidden = YES;
        }else{
            self.dragView.hidden = NO;
        }
    }];
    
    [[[NSNotificationCenter defaultCenter ] rac_addObserverForName:@"jumpApp" object:nil] subscribeNext:^(NSNotification * _Nullable x){
        NSDictionary *dic = x.object;
        NSString *productId = [NSString  stringWithFormat:@"%@",dic[@"p"]];
        [self applyClickProductId:productId];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (TOP_WINDOW) {
            [self.dragView setFrame: CGRectMake(SCREEN_WIDTH - 34, kStatusBarHeight + 10, 30, 30)];
            [TOP_WINDOW addSubview:self.dragView];
        }
    });
    [self.viewModel sendGetHomePop];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getHomeData];
}

- (void)getHomeData
{
    WEAKSELF
    [self.viewModel getHomeIndexfinish:^(BOOL isShowNav,BOOL isShowMember,PTHomeIetenNcModel *ietenNcModel) {
        STRONGSELF
        [strongSelf updataUIisShowNav:isShowNav isShowMember:isShowMember ncModel:ietenNcModel];
        
    } failture:^{
        
    }];
}

- (void)createSubUI
{
    [self.view addSubview:self.navBarView];
    [self.view addSubview:self.homeTableView];
}

-(void)updataUIisShowNav:(BOOL)isShowNav isShowMember:(BOOL)isShowMember ncModel:(PTHomeIetenNcModel*)ncModel
{
//    isShowNav = YES;
    self.navBarView.hidden = !isShowNav;
    if(isShowNav){
        [self.navBarView updataShowMember:isShowMember];
    }
    
    CGFloat homeTableViewyY = isShowNav ? (self.navBarView.y + self.navBarView.height) : kStatusBarHeight;
    self.homeTableView.y = homeTableViewyY;
    self.homeTableView.height = kScreenHeight - homeTableViewyY - kTabBarHeight;
    [self.homeTableView reloadData];
    
    self.kefuJumpUrl = ncModel.kitenchiNc;
    if (![PTNotNull(ncModel.intentantNc) br_isBlankString]) {
        self.dragView.hidden = NO;
        [self.dragView.imageView sd_setImageWithURL:[NSURL URLWithString:ncModel.intentantNc] placeholderImage:[UIImage imageNamed:@"PT_home_kefu"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.dragView.imageView.frame = self.dragView.bounds;
            self.dragView.mj_x = kScreenWidth - 60;
//            [TOP_WINDOW bringSubviewToFront:self.dragView];
        }];;
    }else{
        self.dragView.hidden = YES;
    }
}

#pragma mark -
- (void)router:(NSString *)url
{
    [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:url];
}
- (void)updatePopWithIconURL:(NSString *)url jumpURL:(NSString *)jumpUrl
{
//    url = @"http://fcredit-ios-test-2023.oss-ap-southeast-6.aliyuncs.com/icon/okrupeephone.png?OSSAccessKeyId=LTAI5tHbos4eWs9iGBuZest7&Expires=1914132872&Signature=JUs9RXfMEASUD%2BU7TpfMxl13cSk%3D";
    if (![PTNotNull(url) br_isBlankString]) {
        PTHomePopView *pop = [[PTHomePopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        WEAKSELF
        pop.clickBlock = ^{
            if ([PTNotNull(jumpUrl) br_isBlankString]) {
                return;
            }
            [weakSelf router:jumpUrl];
        };
        [pop updatePopWithIconURL:url];
        [pop show];
    }
}
#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.homeDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"homeCellId";
    UITableViewCell *baseCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    if(indexPath.row > self.viewModel.homeDataArray.count){
        return baseCell;
    }
    WEAKSELF
    PTHomeBaseModel *model = [self.viewModel.homeDataArray objectAtIndex:indexPath.row];
    if([model.cellType isEqualToString:@"AAAXTEN"]){//大卡牌
        NSString *cellId = model.cellType;
        PTHomeBigCardCell *bigCardCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!bigCardCell){
            bigCardCell = [[PTHomeBigCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        PTHomeLargeEcardModel *bigCardModel = (PTHomeLargeEcardModel*)model;
        [bigCardCell configModel:[bigCardModel.gutengoyleNc firstObject]];
        bigCardCell.applyClickBloack = ^(NSString *str) {
            STRONGSELF
            [strongSelf applyClickProductId:str];
        };
        return bigCardCell;
    }
    
    if ([model.cellType isEqualToString:@"AAABBB"]) {//新客提示组件
        NSString *cellId = model.cellType;
        PTHomeTipCell *tipCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!tipCell){
            tipCell = [[PTHomeTipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        return tipCell;
    }
    
    if([model.cellType isEqualToString:@"AAACCC"]){//底部名牌
        
        NSString *cellId = model.cellType;
        PTHomeBrandCell *brandCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!brandCell){
            brandCell = [[PTHomeBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        WEAKSELF
        brandCell.privacyClickBloack = ^{
            STRONGSELF
            NSString *webUrl = [NSString stringWithFormat:@"%@%@",PTWebbaseUrl,PTPrivacy];
            [strongSelf jumpWebViewUrl:webUrl];
        };
        
        return brandCell;
    }
    
    if([model.cellType isEqualToString:@"AAAWTEN"]){//跑马灯
        NSString *cellId = model.cellType;
        PTHomeRidingLanternCell *lanternCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!lanternCell){
            lanternCell = [[PTHomeRidingLanternCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [lanternCell configModel:(PTRidingLanternModel*)model];
        return lanternCell;
    }
    
    if([model.cellType isEqualToString:@"AAAYTEN"]){
        NSString *cellId = model.cellType;
        PTHomeSmallCardCell *smallCardCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!smallCardCell){
            smallCardCell = [[PTHomeSmallCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        PTHomeSmallCardModel *smallCardModel = (PTHomeSmallCardModel*)model;
        [smallCardCell configModel:[smallCardModel.gutengoyleNc firstObject]];
        smallCardCell.applyClickBloack = ^(NSString *str) {//小卡牌
            STRONGSELF
            [strongSelf applyClickProductId:str];
        };
        return smallCardCell;
    }
    
    if([model.cellType isEqualToString:@"AAAVTEN"]){//banner
        NSString *cellId = model.cellType;
        PTHomeBannerCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!bannerCell){
            bannerCell = [[PTHomeBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        WEAKSELF
        bannerCell.bannerClickBloack = ^(NSString *str) {
            STRONGSELF
            [strongSelf jumpWebViewUrl:str];
        };
        [bannerCell configModel:(PTHomeBannerModel*) model];
        return bannerCell;
    }
    
    if([model.cellType isEqualToString:@"REPAY_NOTICE"]){//还款
        NSString *cellId = model.cellType;
        PTHomeRepayCell *repayCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!repayCell){
            repayCell = [[PTHomeRepayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        PTHomeRepayRealModel *repayModel = (PTHomeRepayRealModel*) model;
        [repayCell configUIWithModel:repayModel];
        repayCell.repayBlock = ^(void) {
             STRONGSELF
             [strongSelf router:repayModel.retenloomNc];
        };
        return repayCell;
    }
    if([model.cellType isEqualToString:@"AAAZTEN"]){//贷超列表
        NSString *cellId = model.cellType;
        PTHomeProductListCell *productListCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!productListCell){
            productListCell = [[PTHomeProductListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [productListCell configModel:(PTHomeProductListModel*) model];
         productListCell.applyClickBloack = ^(NSString *str) {
             STRONGSELF
             [strongSelf applyClickProductId:str];
        };
        return productListCell;
    }
    
    return baseCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PTHomeBaseModel *model = [self.viewModel.homeDataArray objectAtIndex:indexPath.row];
    return model.cellHigh;
}

#pragma mark - 跳转到web
- (void)jumpWebViewUrl:(NSString*)url
{
    if([PTTools isBlankString:url])return;
    PTWebViewController *webViewVC = [[PTWebViewController alloc] init];
    webViewVC.url = url;
    [self.navigationController qmui_pushViewController:webViewVC animated:YES completion:nil];
}

-(void)applyClickProductId:(NSString*)productId
{
    WEAKSELF
    if([PTTools isBlankString:productId])return;
    if(self.isBlock)return;
    if(![PTUser isLogin]){
        STRONGSELF
        [PTVCRouter jumpLoginWithSuccessBlock:^{
            [strongSelf applyClickProductId:productId];
        }];
        return;
    }
    
    if(PTUser.isaduit){
        [self.viewModel sendApplyRequest:productId];
        return;
    }
    
    [PTLocation startUpdatingLocation];
    // 检查定位权限状态
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if(authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted){
        [self showLocationPermissionAlertView];
         return;
    }else if (authorizationStatus == kCLAuthorizationStatusNotDetermined){
        [PTLocation checkLocationStatus:^(BOOL isYes) {
            STRONGSELF
            if(isYes){
                [strongSelf applyNextRequestRetengnNc:productId];
            }else{
                [strongSelf showLocationPermissionAlertView];
            }
        }];
        return;
    }
    [self.viewModel sendApplyRequest:productId];
    ///防止连续点击
    [self updateApplyClick];
}
#pragma mark 认证项流转
- (void)applyNextRequestRetengnNc:(NSString*)retengnNc
{
    [[PTAuthentRouterManager sharedPTAuthentRouterManager] applyNextRequestRetengnNc:retengnNc];
}

-(void)updateApplyClick
{
    self.isBlock = YES;
    [self performSelector:@selector(endBlock) withObject:nil afterDelay:1];
}

- (void)endBlock 
{
    self.isBlock = NO;
}


-(void)showLocationPermissionAlertView
{
    PTAuthPermissionAlertView *alertView = [[PTAuthPermissionAlertView alloc] initWithTitleStr:@"Open Service" subTitleStr:@"To be able to use our app, please turn on your device location services."];
    alertView.confirmClickBlock = ^{
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    };
    [alertView show];
}


#pragma mark - lazy

-(PTHomeViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PTHomeViewModel alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

- (PTHomeNavView *)navBarView{
    if(!_navBarView){
        _navBarView = [[PTHomeNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, PTAUTOSIZE(106.f))];
        _navBarView.backgroundColor = [UIColor clearColor];
        _navBarView.hidden = YES;
    }
    return _navBarView;
}

- (QMUITableView *)homeTableView{
    if(!_homeTableView){
        _homeTableView = [[QMUITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight) style:UITableViewStylePlain];
        _homeTableView.dataSource = self;
        _homeTableView.delegate = self;
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            _homeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _homeTableView;
}
- (WMDragView *)dragView
{
    if (!_dragView) {
        _dragView = [[WMDragView alloc] initWithFrame:CGRectMake(kScreenWidth - 20 -10, kNavBarAndStatusBarHeight + 10, 18, 18)];
        _dragView.isKeepBounds = YES;
        _dragView.backgroundColor = [UIColor clearColor];
        _dragView.freeRect = CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight - kBottomSafeHeight);
        WEAKSELF
        _dragView.clickDragViewBlock = ^(WMDragView *dragView) {
            STRONGSELF
            if ([PTNotNull(strongSelf.kefuJumpUrl) br_isBlankString]) {
                return;
            }
            [strongSelf router:strongSelf.kefuJumpUrl];
        };
    }
    return _dragView;
}
@end
