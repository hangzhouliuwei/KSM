//
//  BagOrderListVC.m
//  NewBag
//
//  Created by Jacky on 2024/4/1.
//

#import "BagOrderListVC.h"
#import "BagOrderCell.h"
#import "BagOrderPresenter.h"
#import "BagOrderModel.h"
#import "BagOrderNodataView.h"
#import "BagLoanVC.h"
#import "BagHomePresenter.h"
@interface BagOrderListVC ()<UITableViewDelegate,UITableViewDataSource,BagOrderProtocol,BagHomePresenterProtocol>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BagOrderPresenter *presenter;
@property (nonatomic, strong) BagHomePresenter *homePresenter;

@property (nonatomic, copy) NSArray <BagOrderListModel *>*dataArray;
@property (nonatomic, strong) BagOrderNodataView *nodataView;
@end

@implementation BagOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#F0F4F7"];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
//    [self.presenter sendGetOrderRequestFirstPage:YES];
    WEAKSELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONGSELF
        [strongSelf.presenter sendGetOrderRequestFirstPage:YES tag:strongSelf.tag];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        STRONGSELF
        [strongSelf.presenter sendGetOrderRequestFirstPage:NO tag:strongSelf.tag];
    }];
    [self.view addSubview:self.nodataView];
    self.nodataView.hidden = YES;
    [self.nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    [self.nodataView layoutIfNeeded];
   
}

#pragma mark - BagOrderProtocol
-(void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)hiddenFooter:(BOOL)hidden
{
    [self.tableView.mj_footer endRefreshing];
    self.tableView.mj_footer.hidden = hidden;
}
- (void)updateUIWithDataArray:(NSArray<BagOrderListModel *> *)array
{
    self.dataArray = array;
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    if (self.dataArray.count == 0) {
        self.nodataView.hidden = NO;
    }
}
#pragma mark - BagHomePresenterProtocol
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
#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BagOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagOrderCell.class)];
    if (self.dataArray.count > indexPath.row) {
        BagOrderListModel *model = self.dataArray[indexPath.row];
        cell.refundBtnClickBlock = ^{
            [[BagRouterManager shareInstance] routeWithUrl:model.stypticalF];
        };
        [cell updateUIWithModel:model];
    }
   
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BagOrderListModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BagOrderListModel *model = self.dataArray[indexPath.row];
    [self applyRequestModel:model];
}
- (void)applyRequestModel:(BagOrderListModel*)model
{
    if([model.stypticalF containsString:@"http://"] || [model.stypticalF containsString:@"https://"]){
        BagWebViewController *webVC = [[BagWebViewController alloc] init];
        webVC.url = NotNull(model.stypticalF);
        [self.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
        return;
    }//认证完成直接跳转web
    if(model.iberiaF && model.biolysisF.integerValue !=0){
        BagLoanVC *loanRecordVC = [[BagLoanVC alloc] init];
        loanRecordVC.productId = NotNull(model.biolysisF);
        [self.navigationController qmui_pushViewController:loanRecordVC animated:YES completion:nil];
        return;
    }
    [self.homePresenter sendGetProductDetailRequestWithProductId:model.stypticalF];
}
#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView
{
    return self.view;
}
- (void)listWillAppear
{
    [self.presenter sendGetOrderRequestFirstPage:YES tag:self.tag];
}
#pragma mark - getter

- (BagOrderPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [[BagOrderPresenter alloc]init];
        _presenter.delegate = self;
    }
    return _presenter;
}
- (BagHomePresenter *)homePresenter
{
    if (!_homePresenter) {
        _homePresenter = [[BagHomePresenter alloc]init];
        _homePresenter.delegate = self;
    }
    return _homePresenter;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#F0F4F7"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagOrderCell.class)] forCellReuseIdentifier:NSStringFromClass(BagOrderCell.class)];
    }
    return _tableView;
}
- (BagOrderNodataView *)nodataView
{
    if (!_nodataView) {
        _nodataView = [BagOrderNodataView createView];
        _nodataView.applyBlock = ^{
            [[BagRouterManager shareInstance] setSelectedIndex:0 viewController:nil];
        };
    }
    return _nodataView;;
}
@end
