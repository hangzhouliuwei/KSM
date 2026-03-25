//
//  XTFirstVC.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTFirstVC.h"
#import "XTFirstViewModel.h"
#import "XTCellModel.h"
#import "XTCell.h"
#import "XTAssistiveView.h"
#import "XTIndexModel.h"
#import "XTIconModel.h"
#import "XTBannerModel.h"
#import "XTCardModel.h"
#import "XTRepayModel.h"
#import "XTLanternModel.h"
#import "XTProductModel.h"
#import "XTBigCell.h"
#import "XTSmallCell.h"
#import "XTSpaceCell.h"
#import "XTProductCell.h"
#import "XTLocationManger.h"
#import "XTRequestCenter.h"
#import "XTDetailApi.h"
#import "XTPopUpView.h"
#import <YFPopView/YFPopView.h>


@interface XTFirstVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) XTFirstViewModel *viewModel;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray <XTCellModel *>*listArr;

@end

@implementation XTFirstVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self goFirst];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.xt_bkBtn.hidden = YES;
    UIImageView *iconImg = [UIImageView xt_img:@"xt_login_icon" tag:0];
    [self.xt_navView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.xt_navView.mas_left).offset(20);
        make.centerY.equalTo(self.xt_bkBtn);
    }];
    
    UILabel *appNameLab = [UILabel xt_lab:CGRectZero text:XT_App_Name font:XT_Font_SD(16) textColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft tag:0];
    [self.xt_navView addSubview:appNameLab];
    [appNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).offset(10);
        make.centerY.equalTo(self.xt_bkBtn);
    }];
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.viewModel xt_popUpSuccess:^(NSString * _Nonnull imgUrl, NSString * _Nonnull url, NSString * _Nonnull buttonText) {
        @strongify(self)
        if(![NSString xt_isEmpty:url]) {
            [self xt_popImg:imgUrl url:url text:buttonText];
        }
    } failure:^{
        
    }];
    
    
}

- (void)xt_popImg:(NSString *)img url:(NSString *)url text:(NSString *)text {
    XTPopUpView *view = [[XTPopUpView alloc] initImg:img url:url text:text];
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:view];
    popView.animationStyle = YFPopViewAnimationStyleFade;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    __weak YFPopView *weakView = popView;
    view.closeBlock = ^{
        [weakView removeSelf];
    };
}

- (void)goFirst{
    [self.viewModel getFirstSuccess:^{
        [self.tableView.mj_header endRefreshing];
        [self creatCellModel];
    } failure:^{
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)creatCellModel {
    if(self.viewModel.indexModel.iconModel){
        [[XTAssistiveView xt_share] xt_showIcon:self.viewModel.indexModel.iconModel.intasixntNc url:self.viewModel.indexModel.iconModel.kichsixiNc];
    }
    [self.listArr removeAllObjects];
    
    @weakify(self)
    ///大卡位 新客
    if(self.viewModel.indexModel.big){
        XTCellModel *model = [XTCellModel xt_cellClassName:@"XTBigCell" height:420 model:self.viewModel.indexModel.big];
        if([model.indexCell isKindOfClass:[XTBigCell class]]) {
            ((XTBigCell *)model.indexCell).nextBlock = ^{
                @strongify(self)
                [self checkApply:self.viewModel.indexModel.big.regnsixNc];
            };
        }
        [self.listArr addObject:model];
        
        model = [XTCellModel xt_cellClassName:@"XTSpaceCell" height:10 model:nil];
        [self.listArr addObject:model];
        
        model = [XTCellModel xt_cellClassName:@"XTBannerCell" height:115 model:self.viewModel.indexModel.bannerArr];
        [self.listArr addObject:model];
        
        model = [XTCellModel xt_cellClassName:@"XTSpaceCell" height:4 model:nil];
        [self.listArr addObject:model];
        
        model = [XTCellModel xt_cellClassName:@"XTFirstFootCell" height:102 model:nil];
        [self.listArr addObject:model];
        
        model = [XTCellModel xt_cellClassName:@"XTSpaceCell" height:10 model:nil];
        [self.listArr addObject:model];
    }
    else{
        float height = 128 + 182 + 6;
        if(self.viewModel.indexModel.lanternArr.count > 0){
            height += 28 + 12;
        }
        if(self.viewModel.indexModel.bannerArr.count > 0){
            height += 115 + 12;
        }
        XTCellModel *model = [XTCellModel xt_cellClassName:@"XTSmallCell" height:height model:self.viewModel.indexModel];
        if([model.indexCell isKindOfClass:[XTSmallCell class]]) {
            ((XTSmallCell *)model.indexCell).nextBlock = ^{
                @strongify(self)
                [self checkApply:self.viewModel.indexModel.small.regnsixNc];
            };
        }
        [self.listArr addObject:model];
        
        if(self.viewModel.indexModel.noticeModel) {
            [self.listArr addObject:[XTCellModel xt_cellClassName:@"XTSpaceCell" height:12 model:nil]];
            [self.listArr addObject:[XTCellModel xt_cellClassName:@"XTNoticeCell" height:67 model:self.viewModel.indexModel.noticeModel]];
        }
        
        [self.listArr addObject:[XTCellModel xt_cellClassName:@"XTSpaceCell" height:12 model:nil]];
        
        for(XTProductModel *item in self.viewModel.indexModel.productArr) {
            XTCellModel *product = [XTCellModel xt_cellClassName:@"XTProductCell" height:113 model:item];
            if([product.indexCell isKindOfClass:[XTProductCell class]]) {
                ((XTProductCell *)product.indexCell).nextBlock = ^{
                    @strongify(self)
                    [self checkApply:item.regnsixNc];
                };
            }
            [self.listArr addObject:product];
            [self.listArr addObject:[XTCellModel xt_cellClassName:@"XTSpaceCell" height:12 model:nil]];
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTCellModel *model = self.listArr[indexPath.row];
    return model.indexCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XTCellModel *model = self.listArr[indexPath.row];
    return model.height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
#pragma mark 检测
- (void)checkApply:(NSString *)productId{
    if([NSString xt_isEmpty:productId]){
        return;
    }
    @weakify(self)
    if(![XTUserManger xt_isLogin]){
        [XTUtility xt_login:^{
            @strongify(self)
            [self checkApply:productId];
        }];
        return;
    }
    [self goApply:productId];
}

- (void)checkLBS:(XTBlock)block isList:(BOOL)isList{
    if(isList){
        if(block){
            block();
        }
        return;
    }
    @weakify(self)
    if(![[XTLocationManger xt_share] xt_canLocation]) {
        UIAlertController *altVC = [UIAlertController alertControllerWithTitle:@"Tips" message:@"To be able to use our app, please turn on your device location services." preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [altVC addAction:cancelAction];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }];
        [altVC addAction:sureAction];
        [self xt_presentViewController:altVC animated:YES completion:nil modalPresentationStyle:UIModalPresentationFullScreen];
        return;
    }
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    [[XTRequestCenter xt_share] xt_location:^(BOOL success) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        if(success) {
            if(block){
                block();
            }
        }
    }];
}

- (void)goApply:(NSString *)productId {
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_apply:productId success:^(NSInteger uploadType, NSString * _Nonnull url, BOOL isList) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        
//#warning 删除
//        [[XTRoute xt_share] goVerifyList:productId];
//        return;
        
        if(uploadType == 2) {
            [[XTRequestCenter xt_share] xt_device];
        }
        if([NSString xt_isValidateUrl:url]){
            [self checkLBS:^{
                [[XTRoute xt_share] goHtml:url success:nil];
            } isList:isList];
            return;
        }
//        if(isList) {
//            [[XTRoute xt_share] goVerifyList:productId];
//            return;
//        }
        [self checkLBS:^{
            @strongify(self)
            [self goDetail:productId];
        } isList:isList];
        
        
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

- (void)goDetail:(NSString *)productId {
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_detail:productId success:^(NSString * _Nonnull code, NSString * _Nonnull orderId) {
        @strongify(self)
        if(![NSString xt_isEmpty:code]) {
            [XTUtility xt_atHideProgress:self.view];
            [[XTRoute xt_share] goVerifyItem:code productId:productId orderId:orderId success:nil];
        }
        else {
            [self.viewModel xt_push:orderId success:^(NSString *str) {
                @strongify(self)
                [XTUtility xt_atHideProgress:self.view];
                [[XTRoute xt_share] goHtml:str success:nil];
            } failure:^{
                @strongify(self)
                [XTUtility xt_atHideProgress:self.view];
            }];
        }
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

- (XTFirstViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [[XTFirstViewModel alloc] init];
    }
    return _viewModel;
}

- (NSMutableArray<XTCellModel *> *)listArr {
    if(!_listArr) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

#pragma mark 列表
- (UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.xt_navView.frame), self.view.width, self.view.height - (CGRectGetMaxY(self.xt_navView.frame)) - XT_Tabbar_Height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = 50;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//如果cell不能铺满屏幕，下面的分割线没有
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        @weakify(self)
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self goFirst];
        }];
        _tableView = tableView;
    }
    return _tableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
