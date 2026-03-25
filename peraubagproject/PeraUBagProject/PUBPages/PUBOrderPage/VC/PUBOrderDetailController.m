//
//  PUBOrderDetailController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/15.
//

#import "PUBOrderDetailController.h"
#import "PUBOrderDetailViewModel.h"
#import "PUBOrederModel.h"
#import "PUBOrederDetailCell.h"

#import "PUBLoanRecordController.h"
#import "PUBLoanViewModel.h"
#import "PUBProductDetailModel.h"

@interface PUBOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) NSInteger pageNum;
@property(nonatomic, strong) UITableView *orderDetailTableView;
@property(nonatomic, strong) PUBOrderDetailViewModel *viewModel;
@property(nonatomic, strong) PUBLoanViewModel *loanViewModel;
@end

@implementation PUBOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddeNarbar];
    [self certUI];
    [self reponseDataisFist:YES];
}

- (void)certUI
{
    self.view.height = KSCREEN_HEIGHT - KTabBarHeight - KNavigationBarHeight - 60;
    self.contentView.height = KSCREEN_HEIGHT - KTabBarHeight - KNavigationBarHeight - 60;
    [self.contentView addSubview:self.orderDetailTableView];
    WEAKSELF
    self.orderDetailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONGSELF
        [strongSelf reponseDataisFist:YES];
    }];
    
    self.orderDetailTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        STRONGSELF
        [strongSelf reponseDataisFist:NO];
    }];
}



- (void)reponseDataisFist:(BOOL)isFist
{
    if(isFist){
        self.pageNum = 1;
    }else{
        self.pageNum++;
    }
    
    NSDictionary *dic = @{
                         @"hydroairplane_eg":@(self.hydroairplaneEg),
                         @"envoy_eg":@(self.pageNum),
                         @"labor_eg" :@(20)
                         };
    WEAKSELF
    [self.viewModel getOrderListView:self.view dic:dic isFist:isFist finish:^{
        STRONGSELF
        if(strongSelf.viewModel.dataArray.count == 0){
            [strongSelf showEmptyViewWithImage:[UIImage imageNamed:@"pub_Nodata"] text:@"NO records" detailText:@"" buttonTitle:@"Apply now" buttonAction:@selector(buttonAction)];
        }else{
            [strongSelf hideEmptyView];
        }
        
        [strongSelf.orderDetailTableView reloadData];
        [strongSelf.orderDetailTableView.mj_header endRefreshing];
        [strongSelf.orderDetailTableView.mj_footer endRefreshing];
    } failture:^{
        STRONGSELF
        [strongSelf.orderDetailTableView.mj_header endRefreshing];
        [strongSelf.orderDetailTableView.mj_footer endRefreshing];
    } showFoot:^(BOOL showFoot) {
        STRONGSELF
        strongSelf.orderDetailTableView.mj_footer.hidden = !showFoot;
    }];
    
}

- (void)buttonAction
{
    [self.navigationController qmui_popToRootViewControllerAnimated:NO completion:^{
        [VCManager switchTabAtIndex:0];
    }];
   
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"orderDetailCellId";
    UITableViewCell *baseCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    if(indexPath.row > self.viewModel.dataArray.count){
        return baseCell;
    }

   static NSString*cellID = @"PUBOrederDetailCellCellId";
    PUBOrederDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[PUBOrederDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell configModel:[self.viewModel.dataArray objectAtIndex:indexPath.row]];
    cell.cellBlock = ^(id  _Nonnull object) {
        PUBOrederItemModel *model = (PUBOrederItemModel*)object;
        [PUBRouteManager routeWithUrl:model.bale_eg];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PUBOrederItemModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    return model.cellHeght;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PUBOrederItemModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    [self applyRequestModel:model];
}

- (void)applyRequestModel:(PUBOrederItemModel*)model
{
    if([model.bale_eg containsString:@"http://"] || [model.bale_eg containsString:@"https://"]){
        PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
        webVC.url = NotNull(model.bale_eg);
        [self.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
        return;
    }//认证完成直接跳转web
    if(model.yyusnss_eg && model.grouse_eg.integerValue !=0){
        PUBLoanRecordController *loanRecordVC = [[PUBLoanRecordController alloc] init];
        loanRecordVC.productId = NotNull(model.grouse_eg);
        [self.navigationController qmui_pushViewController:loanRecordVC animated:YES completion:nil];
        return;
    }
    [self applyNextRequestProductId:model.grouse_eg];
}

#pragma mark - 请求下一步跳转
- (void)applyNextRequestProductId:(NSString*)productId
{
    NSDictionary *dic = @{
                          @"perikaryon_eg": NotNull(productId),
                          };
    WEAKSELF
    [self.loanViewModel getProductDetailView:self.view dic:dic finish:^(PUBProductDetailModel * _Nonnull detailModel) {
      STRONGSELF
        [strongSelf skipStepModel:detailModel];
    } failture:^{
        
    }];
}

- (void)skipStepModel:(PUBProductDetailModel*)model
{
    Config.hypokinesis_eg = NotNull(model.hexobiose_eg.checker_eg);
    if(model.specifiable_eg && ![model.specifiable_eg.excuse isEqualToString:@""]){
        [PUBRouteManager routeWitheNextPage:model.specifiable_eg.excuse productId:model.hexobiose_eg.quilting_eg];
        return;
    }
    [self productPushModel:model];
}

-(void)productPushModel:(PUBProductDetailModel*)model
{
    NSDictionary *dic = @{
                          @"order_no":NotNull(model.hexobiose_eg.checker_eg),
                          @"furnisher_eg":@"dddd",
                          @"billyboy_eg":@"houijhyus",
                         };
    [self.loanViewModel getproductPushView:self.view dic:dic finish:^(NSString * _Nonnull url) {
        [PUBRouteManager routeWitheNextPage:url productId:@""];
    } failture:^{
        
    }];
}

#pragma mark - JXPagingViewListViewDelegate
- (UIView *)listView {
    return self.view;
}

//- (UIScrollView *)listScrollView {
//    return self.tableView;
//}

//- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
//    self.scrollCallback = callback;
//}

- (void)listWillAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
    [self reponseDataisFist:YES];
}

- (void)listDidAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listWillDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

#pragma mark - lazy
- (UITableView *)orderDetailTableView{
    if(!_orderDetailTableView){
        _orderDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, self.contentView.height) style:UITableViewStylePlain];
        _orderDetailTableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        _orderDetailTableView.delegate = self;
        _orderDetailTableView.dataSource = self;
    }
    return _orderDetailTableView;
}

- (PUBOrderDetailViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PUBOrderDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (PUBLoanViewModel *)loanViewModel{
    if(!_loanViewModel){
        _loanViewModel = [[PUBLoanViewModel alloc] init];
    }
    return _loanViewModel;
}

@end
