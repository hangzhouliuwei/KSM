//
//  OrderListViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/25.
//

#import "PLPOrderListViewController.h"
#import "JXCategoryView.h"
#import "OrderListViewCell.h"
#import "PLPWebViewController.h"
#import "PLPLoginRegistViewController.h"
#import "PLPBaseNavigationController.h"
@interface PLPOrderListViewController ()<UITableViewDelegate,UITableViewDataSource,JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
//@property(nonatomic)NSInteger index;
@end

@implementation PLPOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Loan Record";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kBlackColor_333333};
    [self.baseImageView removeFromSuperview];
    [self plpGenerateSubview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelNotification:) name:kOrderChangeIndexNotification object:nil];
}
-(void)handelNotification:(NSNotification *)notification
{
    NSInteger index = [notification.object integerValue];
    [self.myCategoryView selectItemAtIndex:index];
}
-(void)requestDataWithTableView:(PLPBaseTableView *)tableView
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"hafbtwelveackNc"] = tableView.type;
    params[@"leittwelveimismNc"] = [NSString stringWithFormat:@"%ld",tableView.pageIndex];
    params[@"catotwelvenizationNc"] = @"20";
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveco/list" paramsInfo:params successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        [tableView.mj_header endRefreshing];
        [tableView.mj_footer endRefreshing];
        if (tableView.pageIndex == 1) {
            [tableView.dataList removeAllObjects];
        }
        for (NSDictionary *dic in responseObject[@"viustwelveNc"][@"xathtwelveosisNc"]) {
            OrderListModel *model = [OrderListModel yy_modelWithDictionary:dic];
            if ([model.maantwelveNc isReal]) {
                model.cellHeight = 202 + 14;
            }else
            {
                model.cellHeight = 143 + 14;
            }
            [tableView.dataList addObject:model];
        }
        [tableView reloadData];
        NSInteger ineftwelveeasibleNc = [responseObject[@"viustwelveNc"][@"ineftwelveeasibleNc"] integerValue];
        if (tableView.pageIndex >= ineftwelveeasibleNc) {
            tableView.mj_footer.hidden = true;
        }else
        {
            tableView.mj_footer.hidden = false;
        }
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(void)plpGenerateSubview
{
    [self.view addSubview:self.myCategoryView];
    [self.view addSubview:self.listContainerView];
}
-(void)jumpWithModel:(OrderListModel *)model
{
    if ([model.aplitwelvecableNc hasPrefix:@"http://"] || [model.aplitwelvecableNc hasPrefix:@"https://"]) {
        PLPWebViewController *vc = [PLPWebViewController new];
        vc.url = model.aplitwelvecableNc;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        if ([model.aplitwelvecableNc containsString:@"openapp://"]) {
            NSArray *nameArray = @[
                @{@"title":@"zztwelvezy",@"sel":@"jumpToSetting:"},
                @{@"title":@"zztwelvezz",@"sel":@"jumpToHome:"},
                @{@"title":@"zztwelvezx",@"sel":@"jumpToLogin:"},
                @{@"title":@"zztwelvezw",@"sel":@"jumpToOrderList:"},
                @{@"title":@"zztwelvezv",@"sel":@"jumpToProductDetail:"},
            ];
            for (NSDictionary *dic in nameArray) {
                NSString *name = dic[@"title"];
                NSString *method = dic[@"sel"];
                SEL sel = NSSelectorFromString(method);
                if ([model.aplitwelvecableNc containsString:name]) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    if ([model.aplitwelvecableNc containsString:@"?"]) {
                        NSArray *params = [model.aplitwelvecableNc componentsSeparatedByString:@"?"];
                        if(params.count > 0){
                            NSString *str1 = params[1];
                            NSArray * temp = [str1 componentsSeparatedByString:@"="];
                            if(temp.count>0){
                                NSString *idStr = [NSString stringWithFormat:@"%@",temp[1]];
                                [dic setValue:@([idStr integerValue]) forKey:temp[0]];
                            }
                        }
                        if ([self respondsToSelector:sel]) {
                            [self performSelector:sel withObject:dic afterDelay:0];
                        }
                    }else
                    {
                        if ([self respondsToSelector:sel]) {
                            [self performSelector:sel withObject:nil afterDelay:0];
                        }
                    }
                }
            }
        }
    }
}

-(void)jumpToSetting:(NSDictionary *)info
{
    
}

-(void)jumpToHome:(NSDictionary *)info
{
    self.tabBarController.selectedIndex = 0;
}
-(void)jumpToLogin:(NSDictionary *)info
{
    [kMMKV setBool:false forKey:kIsLoginKey];
    [kMMKV setString:@"" forKey:kSessionIDKey];
    [kMMKV setString:@"" forKey:kPhoneKey];
    [kMMKV setBool:false forKey:kReviewKey];
    [kMMKV setString:@"" forKey:kTokenKey];
    [kMMKV setString:@"" forKey:kNameKey];
    [kMMKV setString:@"" forKey:kUserIdKey];
    PLPLoginRegistViewController *vc = [PLPLoginRegistViewController new];
    PLPBaseNavigationController *navC = [[PLPBaseNavigationController alloc] initWithRootViewController:vc];
    [PLPCommondTools resetKeyWindowRootViewController:navC];
}
-(void)jumpToOrderList:(NSDictionary *)info
{
    
}

-(void)jumpToProductDetail:(NSDictionary *)info
{
    
}






#pragma mark -UITableViewDataSource
-(UITableViewCell *)tableView:(PLPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    OrderListModel *model = tableView.dataList[indexPath.row];
    cell.model = model;
    kWeakSelf
    cell.tapBlk = ^{
        [weakSelf jumpWithModel:model];
    };
    return cell;
}
-(NSInteger)tableView:(PLPBaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableView.dataList.count;
}
-(CGFloat)tableView:(PLPBaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = tableView.dataList[indexPath.row];
    return model.cellHeight;
}
-(void)tableView:(PLPBaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = tableView.dataList[indexPath.row];
    PLPWebViewController *vc = [[PLPWebViewController alloc] init];
    vc.url = model.aplitwelvecableNc;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.myCategoryView.titles.count;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    PLPBaseTableView *tableView = [[PLPBaseTableView alloc]initWithFrame:self.listContainerView.bounds style:UITableViewStylePlain];
    [tableView registerClass:[OrderListViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 100 + index;
    tableView.applyButtonBlk = ^{
        self.navigationController.tabBarController.selectedIndex = 0;
    };
    tableView.tableFooterView = [UIView new];
    tableView.pageIndex = 1;
    NSString *type = @"";
    if (index == 0) {
        type = @"7";
    }else if (index == 1) {
        type = @"4";
    }else if (index == 2) {
        type = @"6";
    }else if (index == 3) {
        type = @"5";
    }
    tableView.type = type;
    tableView.tag = 100 + index;
    tableView.backgroundColor = [UIColor clearColor];
    kWeakSelf
    __weak PLPBaseTableView *weakTableView = tableView;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakTableView.pageIndex = 1;
        [weakSelf requestDataWithTableView:tableView];
    }];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakTableView.pageIndex ++;
        [weakSelf requestDataWithTableView:tableView];
    }];
    tableView.mj_footer = footer;
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [self requestDataWithTableView:tableView];
    return tableView;
}
- (JXCategoryTitleView *)myCategoryView {
    if (!_myCategoryView) {
        _myCategoryView = [[JXCategoryTitleView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenW, 50)];
        _myCategoryView.delegate = self;
        _myCategoryView.titleFont = [UIFont boldSystemFontOfSize:18];
        _myCategoryView.titleSelectedColor = [UIColor blackColor];
        _myCategoryView.titleColor = [UIColor grayColor];
        _myCategoryView.titleColorGradientEnabled = YES;
        _myCategoryView.averageCellSpacingEnabled = YES;
        _myCategoryView.selectedAnimationEnabled = YES;
        _myCategoryView.titles = @[@"Borrowing",@"Order",@"Not fnished",@"Repaid"];
        JXCategoryIndicatorLineView *lineView = [JXCategoryIndicatorLineView new];
        lineView.indicatorWidth = 20;
        lineView.indicatorColor = kBlueColor_0053FF;
        _myCategoryView.indicators = @[lineView];
        _myCategoryView.listContainer = self.listContainerView;
    }
    return _myCategoryView;
}
- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
        _listContainerView.frame = CGRectMake(0, _myCategoryView.bottom, kScreenW, kScreenH - _myCategoryView.bottom - kBottomHeight);
    }
    return _listContainerView;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
