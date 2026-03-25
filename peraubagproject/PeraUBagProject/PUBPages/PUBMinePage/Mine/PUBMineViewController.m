//
//  PUBMineViewController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/18.
//

#import "PUBMineViewController.h"
#import "PUBMineItemTableViewCell.h"
#import "PUBMineHeaderView.h"
#import "PUBMineViewModel.h"
#import "PUBMineModel.h"
#import "PUBMineRepaymentCell.h"
#import "PUBMineItemTitleCell.h"
#import "PUBSettingViewController.h"
@interface PUBMineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PUBMineViewModel *viewModel;
@property (nonatomic, strong) PUBMineHeaderView *headerView;
@property (nonatomic, strong) PUBMineModel *model;
@property (nonatomic, assign) BOOL overdue;
@end

@implementation PUBMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddeNarbar];
    [self setupUI];
    _overdue = NO;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.tableHeaderView = self.headerView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reponseData];
}
- (void)setupUI{
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
    //self.tableView.contentInset = UIEdgeInsetsMake(-64+KStatusBarHeight, 0, 0, 0);
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.mas_equalTo(KStatusBarHeight);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)reponseData
{
    WEAKSELF
    [self.viewModel getDataSuccess:^(PUBMineModel * _Nonnull data) {
        weakSelf.model = data;
        weakSelf.overdue = weakSelf.model.owly_eg ? YES : NO;
        [weakSelf.headerView updateUIWithUsername:PUBUserManager.sharedUser.username];
        [weakSelf.tableView reloadData];
    } fail:^{
        
    }];
}

- (void)backBtnClick:(UIButton *)btn
{}
#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.model.cockateel_eg.count > 0) {
        if (self.overdue == YES) {
            if (indexPath.row <2) {
                return;
            }
            PUBMineListItemModel *model = self.model.cockateel_eg[indexPath.row - 2];
            PUBBaseWebController *web = [[PUBBaseWebController alloc] init];
            web.url = model.lobsterman_eg;
            [self.navigationController qmui_pushViewController:web animated:YES completion:nil];
        }else{
            if (indexPath.row <1) {
                return;
            }
            PUBMineListItemModel *model = self.model.cockateel_eg[indexPath.row - 1];
            PUBBaseWebController *web = [[PUBBaseWebController alloc] init];
            web.url = model.lobsterman_eg;
            [self.navigationController qmui_pushViewController:web animated:YES completion:nil];
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( self.overdue == YES) {
        if (indexPath.row == 0) {
            PUBMineRepaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PUBMineRepaymentCell.class)];
            [cell updateUIWithProductName:self.model.owly_eg.mitteleuropean_eg logo:self.model.owly_eg.unbuild_eg amount:self.model.owly_eg.moot_eg repay_date:self.model.owly_eg.ovalbumin_eg];
            WEAKSELF
            cell.goRepayBlock = ^{
                STRONGSELF
                if([PUBTools isBlankString:self.model.owly_eg.lobsterman_eg])return;
                PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
                webVC.url = self.model.owly_eg.lobsterman_eg;
                [strongSelf.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
            };
            return cell;
        }
        if (indexPath.row == 1) {
            PUBMineItemTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PUBMineItemTitleCell.class)];
           
            return cell;
        }
        PUBMineItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PUBMineItemTableViewCell.class)];
        if (self.model.cockateel_eg.count > 0) {
            PUBMineListItemModel *model = self.model.cockateel_eg[indexPath.row-2];
            [cell updateUIWIthTitle:model.neanderthaloid_eg iconUrl:model.unbuild_eg];
        }
        return cell;
    }else{
        if (indexPath.row == 0) {
            PUBMineItemTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PUBMineItemTitleCell.class)];
            return cell;
        }
        PUBMineItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PUBMineItemTableViewCell.class)];
        if (self.model.cockateel_eg.count > 0) {
            PUBMineListItemModel *model = self.model.cockateel_eg[indexPath.row-1];
            [cell updateUIWIthTitle:model.neanderthaloid_eg iconUrl:model.unbuild_eg];
        }
        return cell;
    }
    return nil;
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.overdue) {
        return self.model.cockateel_eg.count + 2;
    }
    return self.model.cockateel_eg.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.overdue) {
        if (indexPath.row == 0) {
            return 193+22;
        }
        if (indexPath.row == 1) {
            return 42.f;
        }
        return 84.0f;
    }else{
      
        if (indexPath.row == 0) {
            return 42.f;
        }
        return 84.0f;
    }
    return 0;
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [PUBTools getStatusBarHight], KSCREEN_WIDTH,  self.contentView.height - [PUBTools getStatusBarHight]) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PUBMineItemTableViewCell.class) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass(PUBMineItemTableViewCell.class)];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PUBMineRepaymentCell.class) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass(PUBMineRepaymentCell.class)];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PUBMineItemTitleCell.class) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass(PUBMineItemTitleCell.class)];
        
    }
    return _tableView;
}
- (PUBMineViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[PUBMineViewModel alloc] init];
    }
    return _viewModel;
}
- (PUBMineHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [PUBMineHeaderView createHeader];
        WEAKSELF
        _headerView.goSetBlock = ^{
            PUBSettingViewController *set = [PUBSettingViewController new];
            [weakSelf.navigationController pushViewController:set animated:YES];
        };
    }
    return _headerView;
}
@end
