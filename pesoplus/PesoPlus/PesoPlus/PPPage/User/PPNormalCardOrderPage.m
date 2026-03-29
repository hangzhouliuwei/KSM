//
//  PPNormalCardOrderPage.m
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import "PPNormalCardOrderPage.h"
#import "PPNormalCardTabView.h"
#import "PPNormalCardRecordCell.h"
#import "MJRefresh.h"

@interface PPNormalCardOrderPage () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PPNormalCardTabView *orderTab;

@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) NSMutableArray *dataListCodeTipsListItems;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger dataConfingOtherKignpageIndex;
@property (nonatomic, assign) BOOL isLoadMore;


@end

@implementation PPNormalCardOrderPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.content.backgroundColor = BGColor;
    self.title = @"Loan Record";
}

- (void)loadView {
    [super loadView];
    [self refreshList];
    [self loadUI];
}

- (void)loadUI {
    
    _orderTab = [[PPNormalCardTabView alloc] initWithFrame:CGRectMake(0, NavBarHeight, ScreenWidth, 40)];
    [_orderTab loadTitles:@[@"Outstanding", @"Other"] selectIndex:_selectTabIndex];
    kWeakself;
    _orderTab.clickBlock = ^(NSInteger index) {
        weakSelf.selectTabIndex = index;
        [weakSelf refreshList];
    };
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _orderTab.bottom, ScreenWidth, self.view.h - _orderTab.bottom) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = UIColor.clearColor;
    _tableView.sectionHeaderHeight = 0;
    _tableView.sectionFooterHeight = 0;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.1)];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshList];
    }];

    [self.view addSubview:self.orderTab];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.emptyView];
    self.emptyView.hidden = YES;
}

- (void)refreshUI {
    [self.tableView reloadData];
    if (self.dataListCodeTipsListItems.count > 0) {
        self.emptyView.hidden = YES;
    }else {
        self.emptyView.hidden = NO;
    }
}

- (UIView*)emptyView {
    if(!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, (ScreenHeight - ScreenWidth)/2, ScreenWidth, ScreenWidth)];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200*WS, 200*WS)];
        image.centerX = ScreenWidth/2;
        image.image = ImageWithName(@"order_empty");
        [_emptyView addSubview:image];
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, image.bottom + 10, SafeWidth, 30)];
        desc.text = @"No Records";
        desc.textColor = rgba(143, 193, 255, 1);
        desc.font = Font(16);
        desc.textAlignment = NSTextAlignmentCenter;
        [_emptyView addSubview:desc];
        
        UIButton *apply = [PPKingHotConfigView normalBtn:CGRectMake(34, desc.bottom + 35, ScreenWidth - 68, 42) title:@"Apply now" font:18];
        [apply ppConfigAddViewShadow];
        [apply addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyAction)]];
        [_emptyView addSubview:apply];
    }
    return _emptyView;
}

- (void)applyAction {
    [Page switchTab:0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataListCodeTipsListItems[indexPath.row];
    NSString *url = dic[p_loanDetailUrl];
    [Route jump:url];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataListCodeTipsListItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PPNormalCardRecordCell cellHeight:self.dataListCodeTipsListItems[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"OrderCell";
    PPNormalCardRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PPNormalCardRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColor.clearColor;
    }
    NSDictionary *dic = self.dataListCodeTipsListItems[indexPath.row];
    [cell loadData:dic];
    return cell;
}


- (void)refreshList {
    self.dataConfingOtherKignpageIndex = 1;
    self.isLoadMore = NO;
    [self loadRequest];
}

- (void)loadRequest {
    _orderType = @"6";
    if (_selectTabIndex == 0) {
        _orderType = @"6";
    }else if (_selectTabIndex == 1) {
        _orderType = @"8";
    }
    
    NSDictionary *dic = @{
        p_orderType: _orderType,
        p_pageNum: @"1",
        p_pageSize: @"100"
    };
    kWeakself;
    [Http post:R_orderList params:dic success:^(Response *response) {
        if (response.success) {
            weakSelf.dataListCodeTipsListItems = response.dataDic[p_list];
            [weakSelf refreshUI];
        }
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        NSLog(@"======faild!");
    } showLoading:YES];
}


@end
