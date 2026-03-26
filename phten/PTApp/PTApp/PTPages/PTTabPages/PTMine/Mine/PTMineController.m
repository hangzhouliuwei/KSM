//
//  PTMineController.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/25.
//

#import "PTMineController.h"
#import "PTMineViewModel.h"
#import "PTMineModel.h"
#import "PTHomeBaseModel.h"

#import "PTMineHeaderView.h"
#import "PTMineItemCell.h"
#import "PTMineModel.h"
#import "PTMineNcCell.h"

#import "PTMineNcModel.h"
#import "PTWebViewController.h"
#import "PTMineSettingController.h"
#import "PTOrderViewController.h"
@interface PTMineController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) PTMineViewModel *viewModel;
@property(nonatomic, strong) UITableView *mineTableView;
@property(nonatomic, strong) PTMineHeaderView *headerView;
@property(nonatomic, strong) QMUIButton *setBtn;
@property(nonatomic, copy) NSArray <PTHomeBaseModel*>*dataArray;
@end

@implementation PTMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.hidden = YES;
    self.view.backgroundColor = PTUIColorFromHex(0xF5F9FF);
    [self getMineData];
    [self createSubUI];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getMineData];
}

- (void)getMineData
{
    WEAKSELF
    [self.viewModel getMianeIndexFinish:^(NSArray<PTHomeBaseModel *> * _Nonnull dataArray, NSString * _Nonnull memberUrl) {
       STRONGSELF
        [strongSelf.headerView updataMemberStr:memberUrl];
        strongSelf.dataArray = dataArray;
        [strongSelf.mineTableView reloadData];
    } failture:^{
    
    }];
}

-(void)createSubUI
{
    [self.view addSubview:self.mineTableView];
    [self.view addSubview:self.setBtn];
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row > self.dataArray.count) return [UITableViewCell new];
    PTHomeBaseModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if([model.cellType isEqualToString:@"itemCellID"]){
        NSString *cellId = [NSString stringWithFormat:@"%@",model.cellType];
        PTMineItemCell  *itmeCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!itmeCell){
            itmeCell = [[PTMineItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [itmeCell configModel:(PTMineItemModel*)model];
        return itmeCell;
    }
    else if ([model.cellType isEqualToString:@"unCellID"]){
        NSString *cellId = [NSString stringWithFormat:@"%@",model.cellType];
        PTMineNcModel *ncModel = (PTMineNcModel*)model;
        PTMineNcCell  *enlistgCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!enlistgCell){
            enlistgCell = [[PTMineNcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        enlistgCell.repayBlock = ^{
            [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:ncModel.retenloomNc];
        };
        [enlistgCell configUIWithModel:ncModel];
        
        return enlistgCell;
    
    }
    
    return UITableViewCell.new;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTHomeBaseModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    return model.cellHigh;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PTHomeBaseModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if([model.cellType isEqualToString:@"itemCellID"]){
        PTMineItemModel *itmeModel = (PTMineItemModel*)model;
        [self jumpWebViewUrl:itmeModel.retenloomNc];
    }
    else if ([model.cellType isEqualToString:@"unCellID"]){
        PTMineNcModel *ncModel = (PTMineNcModel*)model;
        [self jumpWebViewUrl:ncModel.retenloomNc];
    }
}

- (void)setBtnClick
{
    PTMineSettingController *settingVC = [[PTMineSettingController alloc] init];
    [self.navigationController qmui_pushViewController:settingVC animated:YES completion:nil];
}

- (void)jumpWebViewUrl:(NSString*)url
{
    if([PTTools isBlankString:url])return;
    PTWebViewController *webViewVC = [[PTWebViewController alloc] init];
    webViewVC.url = url;
    [self.navigationController qmui_pushViewController:webViewVC animated:YES completion:nil];
}

#pragma mark - lazy

-(PTMineViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PTMineViewModel alloc] init];
    }
    return _viewModel;
}

- (UITableView *)mineTableView{
    if(!_mineTableView){
        _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight - kStatusBarHeight - kTabBarHeight) style:UITableViewStylePlain];
        _mineTableView.delegate = self;
        _mineTableView.dataSource = self;
        _mineTableView.backgroundColor = UIColor.clearColor;
        _mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mineTableView.tableHeaderView = self.headerView;
        [_mineTableView showRadius:8.f];
        if (@available(iOS 11.0, *)) {
            _mineTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _mineTableView;
}

- (PTMineHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[PTMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 219.f)];
        WEAKSELF
        _headerView.orderClick = ^(NSInteger index) {
            PTOrderViewController *order = [[PTOrderViewController alloc] init];
            order.selectIndex = index;
            [weakSelf.navigationController pushViewController:order animated:YES];
        };
    }
    
    return _headerView;
}

- (QMUIButton *)setBtn{
    if(!_setBtn){
        _setBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_setBtn setImage:[UIImage imageNamed:@"PT_mine_seting"] forState:UIControlStateNormal];
        _setBtn.frame = CGRectMake(kScreenWidth  - 60.f, kStatusBarHeight + 4.f, 60.f, 40.f);
        [_setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _setBtn;
}

@end
