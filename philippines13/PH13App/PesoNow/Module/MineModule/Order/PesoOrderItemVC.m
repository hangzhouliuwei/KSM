//
//  PesoOrderItemVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoOrderItemVC.h"
#import "PesoOrderVM.h"
#import "PesoOrderModel.h"
#import "PesoOrderNoDataView.h"
#import "PesoOrderCell.h"
#import "PesoDetailVC.h"
#import "PesoHomeViewModel.h"
#import "PesoDetailModel.h"
@interface PesoOrderItemVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PesoOrderVM *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PesoOrderNoDataView *noDataView;
@property (nonatomic, copy) NSArray <PesoOrderListModel *>*dataArray;
@end

@implementation PesoOrderItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight - 50);
    [self.view addSubview:self.tableView];
    WEAKSELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.viewModel loadGetOrderRequestFirstPage:YES tag:self.tag success:^(id model) {
            [weakSelf succeed:model];
        } fail:^{
            [weakSelf fail];
        }];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.viewModel loadGetOrderRequestFirstPage:NO tag:self.tag success:^(id model) {
            [weakSelf succeed:model];
        } fail:^{
            [weakSelf fail];
        }];
    }];
    [self.view addSubview:self.noDataView];
    self.noDataView.hidden = YES;
    self.noDataView.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight - 50);
}
- (void)succeed:(id)model{
    RACTuple *tuple = model;
    self.dataArray = tuple.first;
    [self.tableView reloadData];
    NSNumber *hiddenFooter = tuple.second;
    [self endRefresh];
    [self hiddenFooter:hiddenFooter.boolValue];
    if (self.dataArray.count == 0) {
        self.noDataView.hidden = NO;
    }else{
        self.noDataView.hidden = YES;
    }
}
- (void)fail{
    [self endRefresh];
    [self hiddenFooter:YES];
}
- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)hiddenFooter:(BOOL)hidden{
    [self.tableView.mj_footer endRefreshing];
    self.tableView.mj_footer.hidden = hidden;
}
#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView
{
    return self.view;
}
- (void)listWillAppear
{
    WEAKSELF
    [self.viewModel loadGetOrderRequestFirstPage:YES tag:self.tag success:^(id model) {
        [weakSelf succeed:model];
    } fail:^{
        [weakSelf fail];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PesoOrderListModel *model = self.dataArray[indexPath.row];
    if (br_isNotEmptyObject(model.maanthirteenNc)) {
        return 166;
    }
    return 106;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PesoOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoOrderCell.class)];
    PesoOrderListModel *model = self.dataArray[indexPath.row];
    cell.repayBlock = ^{
        [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:model.aplithirteencableNc];
    };
    [cell configUIWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PesoOrderListModel *model = self.dataArray[indexPath.row];

    [self applyWithModel:model];
}
- (void)applyWithModel:(PesoOrderListModel*)model
{
    //认证完成直接跳转web
    if([model.aplithirteencableNc containsString:@"http://"] || [model.aplithirteencableNc containsString:@"https://"]){
        [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:model.aplithirteencableNc];
        return;
    }
    //跳详情
    if(model.detrthirteenogyrateNc && model.munithirteenumNc.integerValue !=0){
        PesoDetailVC *vc = [PesoDetailVC new];
        vc.productId = model.munithirteenumNc;
        [self.navigationController qmui_pushViewController:vc animated:YES completion:nil];
        return;
    }
    [self apply: model.munithirteenumNc];
}
- (void)apply:(NSString *)pro_id{
    PesoHomeViewModel *homeVM = [PesoHomeViewModel new];
    [homeVM loadProductDetailRequest: pro_id callback:^(PesoDetailModel *detailModel) {
        [PesoUserCenter sharedPesoUserCenter].order = detailModel.leonthirteenishNc.cokethirteentNc;
        //跳转下一步认证
        if (!br_isEmptyObject(detailModel.heisthirteentopNc.relothirteenomNc)) {
            [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:[detailModel.heisthirteentopNc.relothirteenomNc pinProductId: pro_id]];
            return;
        }
        [homeVM loadPushRequestWithOrderId: [PesoUserCenter sharedPesoUserCenter].order product_id:pro_id callback:^(NSString *url) {
            if (!br_isEmptyObject(url)) {
                [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:[url pinProductId:pro_id]];
                return;
            }
        }];
    }];
}
- (PesoOrderVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [PesoOrderVM new];
    }
    return _viewModel;
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
        [_tableView registerClass:[PesoOrderCell class] forCellReuseIdentifier:NSStringFromClass(PesoOrderCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (PesoOrderNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[PesoOrderNoDataView alloc] initWithFrame:CGRectZero];
        _noDataView.applyBlock = ^{
            [[PesoRootVCCenter sharedPesoRootVCCenter] switchIndex:0];
//            [[PTVCRouterManager sharedPTVCRouterManager] switchTabAtIndex:0];
        };
    }
    return _noDataView;
}
@end
