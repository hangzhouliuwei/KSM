//
//  PTOrderListVC.m
//  PTApp
//
//  Created by Jacky on 2024/8/28.
//

#import "PTOrderListVC.h"
#import "PTOrderPresenter.h"
#import "PTOrderNoDaraView.h"
#import "PTOrderCell.h"
#import "PTOrderModel.h"
#import "PTAuthenticationController.h"
#import "PTHomeViewModel.h"
@interface PTOrderListVC ()<UITableViewDelegate,UITableViewDataSource,PTOrderDelegate,PTHomeViewModelProtocol>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PTOrderNoDaraView *noDataView;

@property (nonatomic, strong) PTOrderPresenter *viewModel;
@property (nonatomic, strong) PTHomeViewModel *homeViewModel;

@property (nonatomic, copy) NSArray <PTOrderListModel *>*dataArray;

@end

@implementation PTOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight - 50);
    [self.view addSubview:self.tableView];
    WEAKSELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.viewModel sendGetOrderRequestFirstPage:YES tag:self.tag];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.viewModel sendGetOrderRequestFirstPage:NO tag:self.tag];
    }];
    [self.view addSubview:self.noDataView];
    self.noDataView.hidden = YES;
    self.noDataView.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight - 50);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)updateUIWithDataArray:(NSArray <PTOrderListModel *>*)array{
    self.dataArray = array;
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    if (self.dataArray.count == 0) {
        self.noDataView.hidden = NO;
    }else{
        self.noDataView.hidden = YES;
    }
}
- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)hiddenFooter:(BOOL)hidden{
    [self.tableView.mj_footer endRefreshing];
    self.tableView.mj_footer.hidden = hidden;
}

- (void)router:(NSString *)url
{
    [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:url];
}
#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView
{
    return self.view;
}
- (void)listWillAppear
{
    [self.viewModel sendGetOrderRequestFirstPage:YES tag:self.tag];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 178;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTOrderCell.class)];
    PTOrderListModel *model = self.dataArray[indexPath.row];
    cell.repayBlock = ^{
        [self router:model.aptenlicableNc];
    };
    [cell configUIWithModel:model];
    return cell;
}
- (void)applyWithModel:(PTOrderListModel*)model
{
    //认证完成直接跳转web
    if([model.aptenlicableNc containsString:@"http://"] || [model.aptenlicableNc containsString:@"https://"]){
        [self router:model.aptenlicableNc];
        return;
    }
    //跳详情
    if(model.detentrogyrateNc && model.mutenniumNc.integerValue !=0){
        PTAuthenticationController *vc = [PTAuthenticationController new];
        vc.retengnNc = model.mutenniumNc;
        [self.navigationController qmui_pushViewController:vc animated:YES completion:nil];
        return;
    }
    [self.homeViewModel sendGetProductDetailRequest:model.mutenniumNc];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTOrderListModel *model = self.dataArray[indexPath.row];

    [self applyWithModel:model];
}
- (PTOrderPresenter *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[PTOrderPresenter alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}
- (PTHomeViewModel *)homeViewModel
{
    if (!_homeViewModel) {
        _homeViewModel = [[PTHomeViewModel alloc] init];
        _homeViewModel.delegate = self;
    }
    return _homeViewModel;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[PTOrderCell class] forCellReuseIdentifier:NSStringFromClass(PTOrderCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (PTOrderNoDaraView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[PTOrderNoDaraView alloc] initWithFrame:CGRectZero];
        _noDataView.applyClick = ^{
            [[PTVCRouterManager sharedPTVCRouterManager] switchTabAtIndex:0];
        };
    }
    return _noDataView;
}

@end
