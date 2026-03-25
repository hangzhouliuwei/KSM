//
//  PesoMeViewController.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoMeViewController.h"
#import "PesoMineHeader.h"
#import "PesoMineVM.h"
#import "PesoMineModel.h"
#import "PesoMineListCell.h"
#import "PesoMineRepayCell.h"
#import "PesoHomeBaseModel.h"
#import "PesoSettingVC.h"
#import "PesoOrderViewController.h"
@interface PesoMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PesoMineHeader *header;
@property (nonatomic, strong) PesoMineVM *viewModel;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation PesoMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WEAKSELF
    [self.viewModel loadMineAPI:^(NSArray *data) {
        weakSelf.dataArray = data;
        [weakSelf.tableView reloadData];
    }];
    [self.header updateUI];
}
- (void)createUI
{
    [super createUI];
    self.view.backgroundColor = ColorFromHex(0xF8F8F8);
    UIImageView *backImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_bg"]];
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    backImage.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/375*243);
    backImage.userInteractionEnabled = YES;
    [self.view addSubview:backImage];
    
    self.tableView.contentInset = UIEdgeInsetsMake(140, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    QMUIButton *setBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(kScreenWidth-30-15, kStatusBarHeight+15, 30, 30);
    [setBtn setImage:[UIImage imageNamed:@"ic_setup"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(goSet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setBtn];
}
- (void)goSet{
    PesoSettingVC *set = [PesoSettingVC new];
    [self.navigationController qmui_pushViewController:set animated:YES completion:^{
        
    }];
}
#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = UIColor.clearColor;
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row > self.dataArray.count) return [UITableViewCell new];
    PesoHomeBaseModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if([model.type isEqualToString:@"list"]){
        PesoMineListCell  *itmeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoMineListCell.class)];
        [itmeCell configUIWithModel:model];
        [itmeCell setIndex:indexPath.row isLast:indexPath.row == self.dataArray.count -1];
        return itmeCell;
    }
    else if ([model.type isEqualToString:@"repay"]){
        PesoMineRepayModel *repayModel = (PesoMineRepayModel*)model;
        PesoMineRepayCell  *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoMineRepayCell.class)];
        [cell configUIWithModel:repayModel];
        return cell;
    }
    return UITableViewCell.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PesoHomeBaseModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return model.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PesoHomeBaseModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if([model.type isEqualToString:@"list"]){
        PesoMineItemModel *itmeModel = (PesoMineItemModel*)model;
        [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:itmeModel.relothirteenomNc];
    }
    else if ([model.type isEqualToString:@"repay"]){
        PesoMineRepayModel *itmeModel = (PesoMineRepayModel*)model;
        [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:itmeModel.relothirteenomNc];
    }
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight - kStatusBarHeight - kTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.header;
        [_tableView registerClass:PesoMineListCell.class forCellReuseIdentifier:NSStringFromClass(PesoMineListCell.class)];
        [_tableView registerClass:PesoMineRepayCell.class forCellReuseIdentifier:NSStringFromClass(PesoMineRepayCell.class)];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
- (PesoMineVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [PesoMineVM new];
    }
    return _viewModel;
}
- (PesoMineHeader *)header
{
    if (!_header) {
        _header = [[PesoMineHeader alloc] initWithFrame:CGRectMake(0, 15, kScreenWidth, 185)];
        WEAKSELF
        _header.borrowClickBlock = ^{
            PesoOrderViewController *vc = [PesoOrderViewController new];
            vc.selectIndex = 0;
            [weakSelf.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        };
        _header.orderClickBlock = ^{
            PesoOrderViewController *vc = [PesoOrderViewController new];
            vc.selectIndex = 1;
            [weakSelf.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        };
    }
    return _header;
}
@end
