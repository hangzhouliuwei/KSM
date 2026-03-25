//
//  PUBLoanViewController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/18.
//

#import "PUBLoanViewController.h"
#import "ViewController.h"
#import "PUBLoanViewModel.h"
#import "PUBLoanBaseModel.h"

#import "PUBLoanBannerModel.h"
#import "PUBLoanBannerCell.h"
#import "PUBLoanBrandCell.h"
#import "PUBLoanBgCardModel.h"

#import "PUBLoanBgCardCell.h"
#import "PUBLoanSMCardCell.h"
#import "PUBLanMarketItemCell.h"
#import "PUBLoanMarketModel.h"

#import "PUBAuthPermissionAlert.h"
#import "PUBLoanApplyModel.h"
#import "PUBProductDetailModel.h"
#import "PUBLoanRecordController.h"

#import "PUBUnbuildEgModel.h"
#import "PUBHomePopModel.h"
#import "PUBHomePopView.h"
#import "PUBLoanOverdueCell.h"

#import "PUBLoanOverdueModel.h"

@interface PUBLoanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) PUBLoanViewModel *viewModel;
@property(nonatomic, strong) UITableView *loanTableView;
@property(nonatomic, strong) UIImageView *loginImage;
@property(nonatomic, strong) PUBDragView *dragView;
@end

@implementation PUBLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddeNarbar];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.height = KSCREEN_HEIGHT - KTabBarHeight;
    [self creatUI];
    [self reponseData];
    [self getPopView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reponseData];
    VCManager.dragView.hidden = NO;
    [PUBTrackHandleManager trackAppEventName:@"af_pub_page_home" withElementParam:@{}];
    
}

- (void)creatUI
{
    UIImageView *topBcakImage = [[UIImageView alloc] initWithImage:ImageWithName(@"pub_loan_topback")];
    [self.contentView addSubview:topBcakImage];
    [topBcakImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(328.f * WScale);
    }];
    
    self.loginImage = [[UIImageView alloc] initWithImage:ImageWithName(@"pub_login_iocn")];
    [self.contentView addSubview:self.loginImage];
    [self.loginImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(20 + [PUBTools getStatusBarHight]);
        make.size.mas_offset(CGSizeMake(134.f, 38.f));
    }];
    
    [self.contentView addSubview:self.loanTableView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([UIApplication sharedApplication].keyWindow) {
            [self.dragView setFrame: CGRectMake(SCREEN_WIDTH - 61, 70, 56, 52)];
            [[UIApplication sharedApplication].keyWindow addSubview:self.dragView];
        }
    });
//    self.loanTableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
//        [self reponseData];
//    }];
}


/// 获取弹框
- (void)getPopView
{
    WEAKSELF
    [self.viewModel getPopUpfinish:^(PUBHomePopModel * _Nonnull popModel) {
        STRONGSELF
        if([PUBTools isBlankString:popModel.sequestrum_eg])return;
        PUBHomePopView *pop = [[PUBHomePopView alloc]init];
        pop.cancelBlock = ^{
            if([PUBTools isBlankString:popModel.lobsterman_eg])return;
            PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
            webVC.url = popModel.lobsterman_eg;
            [strongSelf.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
        };
        [pop show:popModel];
        
    } failture:^{
        
    }];
    
}

- (void)reponseData
{
    WEAKSELF
    [self.viewModel getHomeView:self.contentView finish:^{
        STRONGSELF
        [strongSelf.loanTableView reloadData];
        [strongSelf.loanTableView.mj_header endRefreshing];
        if([PUBTools isBlankString:strongSelf.viewModel.unbuildEgModel.recuperate_eg] && ![User isLogin])return;
        [strongSelf.dragView.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strongSelf.viewModel.unbuildEgModel.recuperate_eg]] placeholderImage:[UIImage imageNamed:@"pub_customer_icon"] options:SDWebImageQueryDataWhenInMemory completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(!image)return;
            strongSelf.dragView.imageView.frame = weakSelf.dragView.bounds;
            strongSelf.dragView.x = KSCREEN_WIDTH - 61.f;
            if ([UIApplication sharedApplication].keyWindow) {
                [[UIApplication sharedApplication].keyWindow bringSubviewToFront:strongSelf.dragView];
            }
        }];
    } failture:^{
        
        STRONGSELF
        [strongSelf.loanTableView.mj_header endRefreshing];
    }];
}

#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"loanCellId";
    UITableViewCell *baseCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    if(indexPath.row > self.viewModel.dataArray.count){
        return baseCell;
    }
    WEAKSELF
    PUBLoanBaseModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    if([model.cellId isEqualToString:@"bannerCellId"]){//banner
        NSString *cellId = [NSString stringWithFormat:@"%@",model.cellId];
        PUBLoanBannerCell  *bannerCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!bannerCell){
            bannerCell = [[PUBLoanBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [bannerCell configModel:(PUBLoanBannerModel*)model];
        bannerCell.bannerClickBlock = ^(PUBLoanBannerItemModel *itemModel) {
            STRONGSELF
            if([PUBTools isBlankString:itemModel.lobsterman_eg])return;
            PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
            webVC.url = itemModel.lobsterman_eg;
            [strongSelf.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
        };
        return bannerCell;
    }
    
    if([model.cellId isEqualToString:@"bgCardCellId"]){//大卡位
        NSString *cellId = [NSString stringWithFormat:@"%@",model.cellId];
        PUBLoanBgCardCell  *bgCardCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!bgCardCell){
            bgCardCell = [[PUBLoanBgCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [bgCardCell configModel:(PUBLoanBgCardItemModel*)model];
        bgCardCell.applyBtnClickBlock = ^(NSString * _Nonnull str) {
            STRONGSELF
            [strongSelf applyClickProductId:str];
        };
        bgCardCell.privacyClickBlock = ^{
            STRONGSELF
            [strongSelf privacyClick];
        };
        return bgCardCell;
        
    }
    
    if([model.cellId isEqualToString:@"SamllCardCellId"]){//小卡位
        NSString *cellId = [NSString stringWithFormat:@"%@",model.cellId];
        PUBLoanSMCardCell  *SMCardCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!SMCardCell){
            SMCardCell = [[PUBLoanSMCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [SMCardCell configModel:(PUBLoanBgCardItemModel*)model];
        SMCardCell.applyBtnClickBlock = ^(NSString * _Nonnull str) {
            STRONGSELF
            [strongSelf applyClickProductId:str];
        };
        SMCardCell.privacyClickBlock = ^{
            STRONGSELF
            [strongSelf privacyClick];
        };
        return SMCardCell;
    }
    
    if([model.cellId isEqualToString:@"markItemId"]){//贷超列表
        NSString *cellId = [NSString stringWithFormat:@"%@",model.cellId];
        PUBLanMarketItemCell  *marketItemCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!marketItemCell){
            marketItemCell = [[PUBLanMarketItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [marketItemCell configModel:(PUBLoanMarketItemModel*)model];
        marketItemCell.applyBtnClickBlock = ^(NSString * _Nonnull str) {
            STRONGSELF
            [strongSelf applyClickProductId:str];
        };
        return marketItemCell;
    }
    
    if([model.cellId isEqualToString:@"overdueCellId"]){
        NSString *cellId = [NSString stringWithFormat:@"%@",model.cellId];
        PUBLoanOverdueCell  *overdueCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!overdueCell){
            overdueCell = [[PUBLoanOverdueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        overdueCell.overdueClickBlock = ^(NSString * _Nonnull str) {
            STRONGSELF
            if([PUBTools isBlankString:str])return;
            PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
            webVC.url = str;
            [strongSelf.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
        };
        
        [overdueCell configModel:(PUBLoanOverdueItmeModel*)model];
        
        return overdueCell;
    }
    
    if([model.cellId isEqualToString:@"brandCellId"]){//默认宣传位
        NSString *cellId = [NSString stringWithFormat:@"%@",model.cellId];
        PUBLoanBrandCell  *brandCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!brandCell){
            brandCell = [[PUBLoanBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        return brandCell;
    }
    
    
    return baseCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PUBLoanBaseModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    return model.cellHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 申请点击
/// 申请点击
/// - Parameter productId: 产品ID
-(void)applyClickProductId:(NSString*)productId
{
    WEAKSELF
    if([PUBTools isBlankString:productId])return;
    if(![User isLogin]){
        [PUBTools checkLogin:^(NSInteger uid) {
            STRONGSELF
            if(uid != 0){
              [strongSelf applyClickProductId:productId];
            }
        }];
        return;
    }
    if(User.is_aduit){
      [self applyRequestProductId:productId];
        return;
    }
    
   
    [PUBLocation startLocation];
    [PUBLocation checkLocationStatus:^(BOOL value) {
        STRONGSELF
        if(!value){
        PUBAuthPermissionAlert *altertView = [[PUBAuthPermissionAlert alloc] initWith:@"ic_location_logo" textStr:@"To be able to use our app, please turn on your device location services." btnText:@"ok"];
               altertView.confirmBlock = ^{
                   NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                   if ([[UIApplication sharedApplication] canOpenURL:url]) {
                       [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                   }
               };
               [altertView show];
            return;
        }
        [strongSelf applyRequestProductId:productId];
    }];
    
}

- (void)applyRequestProductId:(NSString*)productId
{
    [PUBTrackHandleManager trackAppEventName:@"af_pub_click_admittance" withElementParam:@{ @"productId":NotNull(productId),}];
    NSDictionary *dic = @{
                          @"perikaryon_eg":NotNull(productId),
                          @"rushee_eg":@"cakestand"
                         };
    WEAKSELF
    [self.viewModel getApplyView:self.view dic:dic finish:^(PUBLoanApplyModel * _Nonnull model) {
        STRONGSELF
        if(model.stalactite_eg == 2){
            [strongSelf.viewModel getUploadDevice];
        }
        if([model.lobsterman_eg containsString:@"http://"] || [model.lobsterman_eg containsString:@"https://"]){
            PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
            webVC.url = NotNull(model.lobsterman_eg);
            [strongSelf.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
            return;
        }//认证完成直接跳转web
    
        if([model.lobsterman_eg containsString:@"openapp://"]){
            if(![model.lobsterman_eg containsString:@"legesmw?perikaryon_eg"]){
                [PUBRouteManager routeWithUrl:model.lobsterman_eg];
                return;
            }
        }
        
        if(model.yyusnss_eg){
            PUBLoanRecordController *loanRecordVC = [[PUBLoanRecordController alloc] init];
            loanRecordVC.productId = NotNull(productId);
            [strongSelf.navigationController qmui_pushViewController:loanRecordVC animated:YES completion:nil];
            return;
        }
        
        [strongSelf applyNextRequestProductId:productId];
    } failture:^{
        
    }];
}

#pragma mark - 请求下一步跳转
- (void)applyNextRequestProductId:(NSString*)productId
{
    NSDictionary *dic = @{
                          @"perikaryon_eg": NotNull(productId),
                          };
    WEAKSELF
    [self.viewModel getProductDetailView:self.view dic:dic finish:^(PUBProductDetailModel * _Nonnull detailModel) {
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
    [self.viewModel getproductPushView:self.view dic:dic finish:^(NSString * _Nonnull url) {
        [PUBRouteManager routeWitheNextPage:url productId:@""];
    } failture:^{
        
    }];
}

#pragma mark - 协议点击
/// 协议按钮点击
- (void)privacyClick
{
    PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
    webVC.url =  STR_FORMAT(@"%@%@", HttPPUBRequest.h5Url,privacyAgreement);;
    webVC.h5Title = @"Privacy Agreement";
    [self.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
}

#pragma mark - lazy
- (PUBLoanViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PUBLoanViewModel alloc] init];
    }
    return _viewModel;
}

- (UITableView *)loanTableView{
    if(!_loanTableView){
        _loanTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [PUBTools getStatusBarHight] + 62.f, KSCREEN_WIDTH,  self.contentView.height - [PUBTools getStatusBarHight] - 62.f) style:UITableViewStylePlain];
        _loanTableView.delegate = self;
        _loanTableView.dataSource = self;
        _loanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _loanTableView.backgroundColor = [UIColor clearColor];
    }
    return _loanTableView;
}

- (PUBDragView *)dragView{
    if(!_dragView){
        _dragView = [[PUBDragView alloc] initWithFrame:CGRectMake(90.f, 100.f, 60.f, 60.f)];
        _dragView.isKeepBounds = YES;
        VCManager.dragView = _dragView;
        WEAKSELF
        _dragView.clickDragViewBlock = ^(PUBDragView * _Nonnull dragView) {
            STRONGSELF
            if([PUBTools isBlankString:strongSelf.viewModel.unbuildEgModel.belat_eg])return;
            PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
            webVC.url = strongSelf.viewModel.unbuildEgModel.belat_eg;
            [strongSelf.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
        };
    }
    return _dragView;
}

@end
