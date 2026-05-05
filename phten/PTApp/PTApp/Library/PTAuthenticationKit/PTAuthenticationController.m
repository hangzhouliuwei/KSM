//
//  PTAuthenticationController.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import "PTAuthenticationController.h"
#import "PTAutheticationViewModel.h"
#import "PTAuthenticationModel.h"
#import "PTAuthenticationHeaderView.h"
#import "PTAuthListCell.h"
@interface PTAuthenticationController ()<UITableViewDataSource,UITableViewDelegate,PTAuthDelegate>
@property(nonatomic, strong) PTAutheticationViewModel *viewModel;
@property(nonatomic, strong) UITableView *autheticationTableView;
@property(nonatomic, strong) PTAuthenticationModel *model;
@property(nonatomic, strong) QMUIButton *saveBtn;
@end

@implementation PTAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = PTUIColorFromHex(0xF5F9FF);
    [self showtitle:@"" isLeft:YES disPlayType:PTDisplayTypeBlack];
    [self createSubUI];
    [self getAuthenticationData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getAuthenticationData];
}

-(void)createSubUI
{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_authen_back"]];
    backImage.frame = CGRectMake(0, 0, kScreenWidth, 450.f);
    [self.view addSubview:backImage];
    
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_authen_left"]];
    leftImage.frame = CGRectMake(16,kNavBarAndStatusBarHeight , 252, 102);
    [self.view addSubview:leftImage];
    
    PTAuthenticationHeaderView *header = [[PTAuthenticationHeaderView alloc] initWithFrame:CGRectMake(16, kNavBarAndStatusBarHeight+89, kScreenWidth-32, 657)];
    [self.view addSubview:header];
    
    UIImageView *coinImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_auth_money"]];
    coinImage.frame = CGRectMake(leftImage.right-24,kNavBarAndStatusBarHeight+21 , 102, 136);
    [self.view addSubview:coinImage];
    
    [header addSubview:self.autheticationTableView];
    self.autheticationTableView.y = 100;
    self.autheticationTableView.width = header.width;
    self.autheticationTableView.height = header.height;

    [self.view addSubview:self.saveBtn];
    self.saveBtn.frame = CGRectMake(0, kScreenHeight - KBottomHeight - 42 -10, 298, 42);
    self.saveBtn.centerX = kScreenWidth/2;
}
- (void)router:(NSString *)url
{
    [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:url];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
-(void)getAuthenticationData
{
    WEAKSELF
    [self.viewModel getAutheticationdeatalRetengnNc:self.retengnNc finish:^(PTAuthenticationModel * _Nonnull model) {
        STRONGSELF
        strongSelf.model = model;
        PTUserManager.sharedUser.oder = model.letenonishNc.cotenketNc;
        [strongSelf.autheticationTableView reloadData];
    } failture:^{
        
    }];
}
- (void)saveClick{
    if ([PTNotNull(self.model.hetenistopNc.retenloomNc) br_isBlankString]) {
        [self.viewModel pt_sendOrderPushRequestWithOrderId:PTUserManager.sharedUser.oder product_id:self.retengnNc];
        return;
    }
    [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:[self.model.hetenistopNc.retenloomNc br_pinProductId:self.retengnNc]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.attenesiaNc.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.model.attenesiaNc.count){
        PTAuthenticationItemModel *model = self.model.attenesiaNc[indexPath.row];
        PTAuthListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTAuthListCell.class)];
        [cell configUIWithModel:model index:indexPath.row+1];
        return cell;
    }
    
    return UITableViewCell.new;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTAuthenticationItemModel *model = [self.model.attenesiaNc objectAtIndex:indexPath.row];
    if(model.frtenllyNc){
        [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:[model.retenloomNc br_pinProductId:self.retengnNc]];
    }else{
        [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:[self.model.hetenistopNc.retenloomNc br_pinProductId:self.retengnNc]];
    }
}


#pragma mark - lazy
-(PTAutheticationViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PTAutheticationViewModel alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

-(UITableView *)autheticationTableView{
    if(!_autheticationTableView){
        _autheticationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kScreenWidth, kScreenHeight - self.navView.bottom - kSafeAreaBottomHeight - 42.f) style:UITableViewStylePlain];
        [_autheticationTableView registerClass:[PTAuthListCell class] forCellReuseIdentifier:NSStringFromClass(PTAuthListCell.class)];
        _autheticationTableView.delegate = self;
        _autheticationTableView.dataSource = self;
//        _autheticationTableView.tableHeaderView = [[PTAuthenticationHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220.f)];
        _autheticationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _autheticationTableView.backgroundColor = UIColor.clearColor;
        if (@available(iOS 11.0, *)) {
            _autheticationTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _autheticationTableView;
}
- (QMUIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setImage:[UIImage imageNamed:@"PT_auth_btn"] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}
@end
