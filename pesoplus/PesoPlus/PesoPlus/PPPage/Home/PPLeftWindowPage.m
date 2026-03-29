//
//  PPLeftWindowPage.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPLeftWindowPage.h"
#import "MJRefresh.h"
#import "PPLeftNormalCardView.h"
#import "PPRightCardDefaultView.h"
#import "PPSelfConfigCenterAlert.h"

@interface PPLeftWindowPage ()
@property (nonatomic, strong) PPLeftNormalCardView *homeView;
@property (nonatomic, strong) PPRightCardDefaultView *leningedCardViewArrIndeItems;
@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, strong) NSMutableArray *bannerData;
@property (nonatomic, strong) NSMutableArray *defaultCardDataItemViews;
@property (nonatomic, strong) NSMutableArray *lendingLittleData;
@property (nonatomic, strong) NSMutableArray *defaultCardDataItpayData;
@property (nonatomic, copy) NSDictionary *defaultCardDataItserviceData;
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, assign) BOOL isBlock;
@property (nonatomic, strong) PPSelfConfigCenterAlert *openAlert;
@property (nonatomic, copy) NSString *jumpUrl;
@end

@implementation PPLeftWindowPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.content.backgroundColor = BGColor;
    self.content.h = ScreenHeight;

    kWeakself;
    _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.content.mj_header = _refreshHeader;
    
    self.homeView = [[PPLeftNormalCardView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    [self.content addSubview:self.homeView];
    self.leningedCardViewArrIndeItems = [[PPRightCardDefaultView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    [self.content addSubview:self.leningedCardViewArrIndeItems];
    [self loadLaunchData];
    [self portgogoMark];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netRefresh:) name:@"netRefresh" object:nil];
}

- (void)netRefresh:(NSNotification *)notification {
    [self loadData];
}

- (void)portgogoMark {
    NSDictionary *dic = @{
        @"rscomraderyCiopjko": [PPHandleDevicePhoneInfo mirjhaDeviceidfv],
        @"rsdispraiseCiopjko":@"",
        @"asdfasasdgwg":@"fewfdf",
        @"ATETH":@"123123555"
    };
    
    [Http post:R_market params:dic success:^(Response *response) {
        
    } failure:^(NSError *error) {
    } showLoading:YES];
}

- (void)loadLaunchData {
    if (!User.isLogin) {
        return;
    }
    kWeakself;
    [Http get:R_openAlert params:nil success:^(Response *response) {
        if (response.success) {
            NSString *imgUrl = response.dataDic[p_imgUrl];
            weakSelf.jumpUrl = response.dataDic[p_url];
            [weakSelf openAlert:imgUrl];
        }
    } failure:^(NSError *error) {
    }];
}

- (void)openAlert:(NSString *)imgUrl {
    if (![imgUrl containsString:@"http"]) {
        return;
    }
    CGFloat alertWidth = ScreenWidth - 32*2;
    CGFloat alertHeight = alertWidth;
    
    SDAnimatedImageView *alertView = [[SDAnimatedImageView alloc] initWithFrame:CGRectMake(32, ScreenHeight - alertHeight, alertWidth, alertHeight)];
    alertView.centerX = ScreenWidth/2;
    alertView.centerY = ScreenHeight/2;
    alertView.userInteractionEnabled = YES;
    [alertView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    [alertView showAddToRadius:16];
    [alertView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sureAction)]];
    
    _openAlert = [[PPSelfConfigCenterAlert alloc] initWithPPCenterCustomView:alertView];
    [_openAlert show];
}

- (void)sureAction {
    [Route jump:self.jumpUrl];
    [_openAlert hide];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)loadData {
    kWeakself;
    [Http get:R_home params:@{} success:^(Response *response) {
        [weakSelf.content.mj_header endRefreshing];
        if (response.success) {
            weakSelf.defaultCardDataItserviceData = response.dataDic[p_icon];
            NSArray *list = response.dataDic[p_list];
            [weakSelf setupData:list];
        }
    } failure:^(NSError *error) {
        
    } showLoading:YES];
}

- (void)setupData:(NSArray *)items {
    self.bannerData  = nil;
    self.defaultCardDataItemViews  = nil;
    self.defaultCardDataItpayData  = nil;
    self.lendingLittleData  = nil;
    self.itemList  = nil;
    for (NSDictionary *dic in items) {
        NSString *type = dic[p_type];
        if ([type isEqualToString:p_BANNER]) {
            self.bannerData = dic[p_item];
        }
        if ([type isEqualToString:p_LARGE_CARD]) {
            self.defaultCardDataItemViews = dic[p_item];
        }
        if ([type isEqualToString:p_REPAY]) {
            self.defaultCardDataItpayData = dic[p_item];
        }
        if ([type isEqualToString:p_SMALL_CARD]) {
            self.lendingLittleData = dic[p_item];
        }
        if ([type isEqualToString:p_PRODUCT_LIST]) {
            self.itemList = dic[p_item];
        }
    }
    [self createUI];
}

- (void)createUI {
    if (self.defaultCardDataItemViews.count > 0) {
        self.leningedCardViewArrIndeItems.hidden = YES;
        self.homeView.hidden = NO;
        [self.homeView refreshBanner:self.bannerData card:self.defaultCardDataItemViews];
        [self.content fitView:self.homeView];
    }else if (self.lendingLittleData.count > 0){
        self.homeView.hidden = YES;
        self.leningedCardViewArrIndeItems.hidden = NO;
        [self.leningedCardViewArrIndeItems refreshBanner:self.bannerData card:self.lendingLittleData payData:self.defaultCardDataItpayData items:self.itemList];
        [self.content fitView:self.leningedCardViewArrIndeItems];
    }
    User.suspendDic = [NSMutableDictionary dictionaryWithDictionary:self.defaultCardDataItserviceData];
    [User ppConfigshowSuspend];
}

@end
