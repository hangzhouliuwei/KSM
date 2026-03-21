//
//  BagMeViewController.m
//  NewBag
//
//  Created by Jacky on 2024/3/14.
//

#import "BagMeViewController.h"
#import "BagMeListCell.h"
#import "BagMeOverdueCell.h"
#import "BagMePresenter.h"
#import "BagMeModel.h"
#import "BagMeHeaderView.h"
#import "BagMeSettingVC.h"
#import "BagOrderVC.h"
@interface BagMeViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,BagMePresenterProtocol>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BagMePresenter *presenter;
@property (nonatomic, strong) BagMeModel *model;
@property (nonatomic, assign) BOOL overdue;
@property (nonatomic, strong)  BagMeHeaderView *header;
@end

@implementation BagMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

    _overdue = NO;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;

    [self.presenter sendGetMeDetailRequest];

}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isSelf = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isSelf animated:YES];
}

- (void)goSettingAction{
    BagMeSettingVC *set = [[BagMeSettingVC alloc] initWithNibName:NSStringFromClass(BagMeSettingVC.class) bundle:[Util getBundle]];
    [self.navigationController qmui_pushViewController:set animated:YES completion:nil];
}
- (void)goOrderAction:(NSInteger)index{
    BagOrderVC *order = [[BagOrderVC alloc] init];
    order.selectIndex = index;
    [self.navigationController qmui_pushViewController:order animated:YES completion:nil];
}
#pragma mark - BagMePresenterProtocol
- (void)updateUIWithModel:(BagMeModel *)model
{
    _model = model;
    if (self.model.unqufourteenalizeNc) {
        self.overdue = YES;
    }else{
        self.overdue = NO;
    }
    [self.header updateUIWithPhone:BagUserManager.shareInstance.username];
    [self.tableView reloadData];
}
#pragma mark - tableDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (self.overdue) {
            BagMeOverdueCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagMeOverdueCell.class)];
            WEAKSELF
            cell.overdueClickBlock = ^{
                if (![weakSelf.model.unqufourteenalizeNc.relofourteenomNc br_isBlankString]) {
                    BagWebViewController *web = [BagWebViewController new];
                    web.url = weakSelf.model.unqufourteenalizeNc.relofourteenomNc;
                    [weakSelf.navigationController qmui_pushViewController:web animated:YES completion:nil];
                }
            };
            [cell updateUIWithProductName:weakSelf.model.unqufourteenalizeNc.haryfourteenNc logoUrl:weakSelf.model.unqufourteenalizeNc.ieNcfourteen amount:weakSelf.model.unqufourteenalizeNc.geerfourteenalitatNc repayDate:weakSelf.model.unqufourteenalizeNc.acepfourteentablyNc];
            return cell;
        }
    }
    BagMeListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagMeListCell.class)];
    BagMeListItemModel *model = self.model.mehafourteenemoglobinNc[indexPath.row - (self.model.unqufourteenalizeNc ? 1 : 0)];
    [cell updateUIWithTitle:model.fldgfourteeneNc iconUrl:model.ieNcfourteen];
    
    return cell;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.overdue && indexPath.row == 0) {
        return 201;
    }
    return 64;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.overdue ? 1 + self.model.mehafourteenemoglobinNc.count : self.model.mehafourteenemoglobinNc.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.overdue) {
        if (self.model.mehafourteenemoglobinNc.count > 1) {
            if (indexPath.row == 0) {
                if (![self.model.unqufourteenalizeNc.relofourteenomNc br_isBlankString]) {
                    BagWebViewController *web = [BagWebViewController new];
                    web.url = self.model.unqufourteenalizeNc.relofourteenomNc;
                    [self.navigationController qmui_pushViewController:web animated:YES completion:nil];
                }
                return;
            }
            BagMeListItemModel *model = self.model.mehafourteenemoglobinNc[indexPath.row-1];
            BagWebViewController *web = [BagWebViewController new];
            web.url = model.relofourteenomNc;
            [self.navigationController qmui_pushViewController:web animated:YES completion:nil];
        }
    }else{
        BagMeListItemModel *model = self.model.mehafourteenemoglobinNc[indexPath.row];
        BagWebViewController *web = [BagWebViewController new];
        web.url = model.relofourteenomNc;
        web.leftTitle = @"";
        [self.navigationController qmui_pushViewController:web animated:YES completion:nil];
    }
}
#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#F4F7FA"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(BagMeListCell.class) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass(BagMeListCell.class)];
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(BagMeOverdueCell.class) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass(BagMeOverdueCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagMeListCell.class)] forCellReuseIdentifier:NSStringFromClass(BagMeListCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagMeOverdueCell.class)] forCellReuseIdentifier:NSStringFromClass(BagMeOverdueCell.class)];
        BagMeHeaderView *header = [BagMeHeaderView createHeader];
        [header updateUIWithPhone:BagUserManager.shareInstance.username];
       
        _tableView.tableHeaderView = self.header;
    }
    return _tableView;
}
- (BagMePresenter *)presenter
{
    if (!_presenter) {
        _presenter = [[BagMePresenter alloc] init];
        _presenter.delegate = self;
    }
    return _presenter;
}
- (BagMeHeaderView *)header
{
    if (!_header) {
        WEAKSELF
        _header = [BagMeHeaderView createHeader];
        _header.goSettingBlock = ^{
            [weakSelf goSettingAction];
        };
        _header.goBorringOrderBlock = ^{
            [weakSelf goOrderAction:0];
        };
        _header.goAllOrderBlock = ^{
            [weakSelf goOrderAction:1];
        };
    }
    return _header;
}
@end
