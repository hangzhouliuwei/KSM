//
//  LinkmanPagePPNormalCard.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "LinkmanPagePPNormalCard.h"
#import "PPNormalCardLinkmanCell.h"
#import "PPUserTopViewTimeView.h"
#import "PPNormalCardInfoAlert.h"
#import "DayPPNormalCardAlert.h"

@interface LinkmanPagePPNormalCard ()
@property (nonatomic, strong) UIView *contactConfigHelperView;
@property (nonatomic, strong) PPUserTopViewTimeView *timeView;
@property (nonatomic, assign) NSInteger countdown;
@property (nonatomic, strong) NSMutableArray *contactConfigHelperCotnactArr;
@property (nonatomic, copy) NSArray *dataArr;

@property (nonatomic, strong) PPNormalCardInfoAlert *alert;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation LinkmanPagePPNormalCard

- (void)requestInfoData {
    NSDictionary *dic = @{
        p_product_id: self.productId,
        @"rsunderlaidCiopjko":@"blaalleynk"
    };
    kWeakself;
    [Http post:R_contact params:dic success:^(Response *response) {
        if (response.success) {
            weakSelf.dataArr = response.dataDic[p_items];
            weakSelf.countdown = [response.dataDic[p_countdown] integerValue];
            [weakSelf loadUI];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"======faild!");
    }];
}

- (id)init{
    self = [super init];
    if (self) {
        self.naviBarHidden = YES;
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    if (!self.canDiss) {
        return;
    }
    UINavigationController *navigationController = self.navigationController;
    if (navigationController && ![navigationController.viewControllers containsObject:self]) {
        return;
    }
    
    if (navigationController) {
        NSMutableArray *viewControllers = [navigationController.viewControllers mutableCopy];
        [viewControllers removeObject:self];
        navigationController.viewControllers = [viewControllers copy];
    }
}

- (void)loadHeader {
    [self.headerView removeAllViews];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SafeWidth, NavBarHeight + 64)];
    UIView *headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavBarHeight + 64)];
    headerBgView.backgroundColor = MainColor;
    [headerBgView showPPReallyRadiusBottom:16];
    
    UIImageView *headerImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NavBarHeight, ScreenWidth, 64)];
    headerImageV.image = ImageWithName(@"header_step2");
    [headerBgView addSubview:headerImageV];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, StatusBarHeight, 48, 44);
    [backBtn setImage:ImageWithName(@"page_back") forState:UIControlStateNormal];
    [headerBgView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin + 44, StatusBarHeight, SafeWidth - 44*2, 44)];
    titleView.textColor = UIColor.whiteColor;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"Contact";
    titleView.font = FontCustom(16);
    [headerBgView addSubview:titleView];
    if (self.countdown == 0) {
        self.timeView.hidden = YES;
        self.headerView.h = NavBarHeight + 64;
    }else {
        [self.headerView addSubview:self.timeView];
        self.timeView.hidden = NO;
        self.headerView.h = NavBarHeight + 64 + 40;
    }
    [self.headerView addSubview:headerBgView];
    [self.content addSubview:self.headerView];
}


- (void)loadUI {
//    self.countdown = 10;
    if (self.countdown > 0) {
        [self.timeView start:self.countdown];
    }
    [self loadHeader];

    _contactConfigHelperView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom + 10, ScreenWidth, 170*_dataArr.count)];
    _contactConfigHelperView.backgroundColor = UIColor.whiteColor;
    [self.content addSubview:_contactConfigHelperView];
    
    self.content.contentSize = CGSizeMake(ScreenWidth, self.contactConfigHelperView.bottom + SafeBottomHeight + 70);
    
    _contactConfigHelperCotnactArr = [NSMutableArray array];
    
    for (int i = 0; i < _dataArr.count; i++) {
        NSDictionary *dic = _dataArr[i];
        PPNormalCardLinkmanCell *contact = [[PPNormalCardLinkmanCell alloc] initWithFrame:CGRectMake(0, 170*i, ScreenWidth, 170) data:dic];
        contact.lever = i;
        [_contactConfigHelperView addSubview:contact];
        [_contactConfigHelperCotnactArr addObject:contact];
    }
    
    UIButton *nextBtnItem = [PPKingHotConfigView normalBtn:CGRectMake(34, self.view.h - SafeBottomHeight - 60, ScreenWidth - 68, 48) title:@"Next" font:24];
    [nextBtnItem showBottomShadow:COLORA(0, 0, 0, 0.2)];
    [nextBtnItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextAction)]];
    [self.view addSubview:nextBtnItem];
}

- (void)nextAction {
    for (int i = 0; i < _contactConfigHelperCotnactArr.count; i++) {
        PPNormalCardLinkmanCell *contact = _contactConfigHelperCotnactArr[i];
        NSString *name = contact.data[p_name];
        NSInteger relation = [contact.data[p_relation] integerValue];
        NSString *mobile = contact.data[p_mobile];
        if (name.length == 0 || mobile.length == 0 || relation < 1) {
            [PPMiddleCenterToastView show:@"Please complete information"];
            return;
        }
    }
    [self saveData];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.step = 1;
    self.content.backgroundColor = BGColor;
    [self requestInfoData];
}


- (void)saveData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{p_product_id:notNull(self.productId)}];
    for (int i = 0; i < _contactConfigHelperCotnactArr.count; i++) {
        PPNormalCardLinkmanCell *contact = _contactConfigHelperCotnactArr[i];
        NSString *name = contact.data[p_name];
        NSString *mobile = contact.data[p_mobile];
        NSArray *fieldArr = _dataArr[i][p_field];
        if (fieldArr.count == 3) {
            NSString *nameKey = fieldArr[0][p_name];
            NSString *mobileKey = fieldArr[1][p_name];
            NSString *relationKey = fieldArr[2][p_name];
            dic[notNull(nameKey)] = name;
            dic[notNull(mobileKey)] = mobile;
            dic[notNull(relationKey)] = StrFormat(@"%@", @(i + 1));
        }
    }
    dic[p_point] = [self track];
    kWeakself;
    [Http post:R_save_contact params:dic success:^(Response *response) {
        if (response.success) {
            weakSelf.canDiss = YES;
            [Route ppTextjumpToWithProdutId:weakSelf.productId];
        }else {
            [PPMiddleCenterToastView show:response.msg];
        }
    } failure:^(NSError *error) {

    } showLoading:YES];
}

- (PPUserTopViewTimeView*)timeView {
    if(!_timeView) {
        kWeakself;
        _timeView = [[PPUserTopViewTimeView alloc] initWithFrame:CGRectMake(0, NavBarHeight + 64 - 20, ScreenWidth, 60)];
        _timeView.finishBlock = ^{
            weakSelf.countdown = 0;
            [weakSelf loadHeader];
            weakSelf.contactConfigHelperView.y = weakSelf.headerView.bottom + 10;
        };
        [_timeView showPPReallyRadiusBottom:16];
        [_timeView ppConfigAddViewShadow];
    }
    return _timeView;
}



@end
