//
//  PUBBasicViewController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/29.
//

#import "PUBBasicViewController.h"
#import "PUBBasicViewModel.h"
#import "PUBBasicModel.h"
#import "PUBBasicCountDownView.h"

#import "PUBBasicEnumCell.h"
#import "PUBSingleView.h"
#import "PUBBasicSectionHeaderView.h"
#import "PUBBasicTxtCell.h"

#import "PUBBasicDayCell.h"
#import "PUBBirthdayView.h"
#import "PUBWanLiuView.h"
#import "PUBLoanViewModel.h"

@interface PUBBasicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) PUBBasicViewModel *viewModel;
@property(nonatomic, strong) PUBBasicModel *basicModel;
@property(nonatomic, strong) PUBBasicCountDownView *downView;
@property(nonatomic, strong) UIImageView *nextTopImageView;
@property(nonatomic, strong) QMUIButton *nextBtn;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UITableView *basicTableView;
@property(nonatomic, strong) PUBWanLiuView *wanLiuView;
@property(nonatomic, strong) PUBLoanViewModel *loanViewModel;
@property(nonatomic, copy) NSString *startTime;
@end

@implementation PUBBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.navBar.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    [self.navBar showtitle:@"Basic" isLeft:YES];
    [self creatUI];
    [self reponseData];
    self.startTime = [PUBTools getTime];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PUBTrackHandleManager trackAppEventName:@"af_pub_page_basic" withElementParam:@{}];
}

- (void)creatUI
{
    self.contentView.height = KSCREEN_HEIGHT - self.navBar.bottom;
    [self.contentView addSubview:self.downView];
    [self.contentView addSubview:self.nextTopImageView];
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.nextBtn];
    [self.backView addSubview:self.basicTableView];
}

-(void)reponseData
{
    NSDictionary *dic = @{
                         @"perikaryon_eg":NotNull(self.productId),
                         @"autodestruction_eg":@"stauistill"
                         };
    WEAKSELF
    [self.viewModel getbasicInfoView:self.view dic:dic finish:^(PUBBasicModel * _Nonnull basicModel) {
       STRONGSELF
        strongSelf.basicModel = basicModel;
        [strongSelf updataCountDown:strongSelf.basicModel.sdlkfjl_eg];
        [strongSelf.basicTableView reloadData];
    } failture:^{
    
    }];
    
}

- (void)backBtnClick:(UIButton *)btn
{   
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self.wanLiuView show:BasicType];
}

///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self.wanLiuView show:BasicType];
    return NO;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.basicModel.draffy_eg.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PUBBasicItmeModel *itmeModel = [self.basicModel.draffy_eg objectAtIndex:section];
    if(itmeModel.more && !itmeModel.isHidde){
        return 0;
    }
    return itmeModel.somesuch_eg.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PUBBasicItmeModel *itmeModel = [self.basicModel.draffy_eg objectAtIndex:indexPath.section];
    static NSString *cellId = @"basicCellId";
    UITableViewCell *baseCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    if(indexPath.row > itmeModel.somesuch_eg.count){
        return baseCell;
    }
    WEAKSELF
    PUBBasicSomesuchEgModel *model = [itmeModel.somesuch_eg objectAtIndex:indexPath.row];
    if([model.cellType isEqualToString:@"enum"])
    {
        NSString*cellID = [NSString stringWithFormat:@"%zd+%zd",indexPath.section, indexPath.row];
        PUBBasicEnumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[PUBBasicEnumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell configModel:model];
        cell.clickBlock = ^{
            STRONGSELF
            [strongSelf tarckClickTagString:model.paramorphism_eg];
            [strongSelf.view endEditing:YES];
            PUBSingleView *singLeView = [[PUBSingleView alloc] initWithData:model.horrific_eg title:model.neanderthaloid_eg];
            [singLeView show];
            singLeView.confirmBlock = ^(id  _Nonnull object) {
                PUBBasicHorrificEgModel *horrificEgModel = (PUBBasicHorrificEgModel*)object;
                model.oerlikon_eg = [NSString stringWithFormat:@"%ld",horrificEgModel.vibronic_eg];
                [strongSelf.basicTableView reloadData];
                [strongSelf nextSelection:indexPath];
                [strongSelf tarckSelectResultTagString:model.paramorphism_eg contentString:model.oerlikon_eg];
            };
        };
        return cell;
    }
    
    if([model.cellType isEqualToString:@"txt"])
    {
        NSString*cellID = [NSString stringWithFormat:@"%zd+%zd",indexPath.section, indexPath.row];
        PUBBasicTxtCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[PUBBasicTxtCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        if([model.neanderthaloid_eg isEqualToString:@"Email"]){
            [cell configModel:model index:indexPath tableView:self.basicTableView topY:self.nextTopImageView.bottom];
        }else{
           [cell configModel:model];
        }
        cell.textBlock = ^(NSString * _Nonnull str) {
            STRONGSELF
            model.oerlikon_eg = NotNull(str);
            [strongSelf tarckSelectResultTagString:model.paramorphism_eg contentString:model.oerlikon_eg];
        };
        cell.textBeginBlock = ^{
            STRONGSELF
            [strongSelf tarckClickTagString:model.paramorphism_eg];
        };
        return cell;
    }
    
    if([model.cellType isEqualToString:@"day"])
    {
        
        NSString*cellID = [NSString stringWithFormat:@"%zd+%zd",indexPath.section, indexPath.row];
        PUBBasicDayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[PUBBasicDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell configModel:model];
        cell.clickBlock = ^{
            STRONGSELF
            [strongSelf.view endEditing:YES];
            [strongSelf tarckClickTagString:model.paramorphism_eg];
            PUBBirthdayView *birthdayView = [[PUBBirthdayView alloc] init];
            [birthdayView show];
            [birthdayView loadUITitle:model.neanderthaloid_eg];
            birthdayView.confirmBlock = ^(id  _Nonnull object) {
                model.oerlikon_eg = [NSString stringWithFormat:@"%@",object];
                [strongSelf.basicTableView reloadData];
                [strongSelf nextSelection:indexPath];
                [strongSelf tarckSelectResultTagString:model.paramorphism_eg contentString:model.oerlikon_eg];
            };
        };
        return cell;
        
    }
        
    
    return baseCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.basicModel.draffy_eg.count < indexPath.section){
        return 0;
    }
    PUBBasicItmeModel *itmeModel = [self.basicModel.draffy_eg objectAtIndex:indexPath.section];
    if(itmeModel.somesuch_eg.count < indexPath.row){
        return 0;
    }
    PUBBasicSomesuchEgModel *model = [itmeModel.somesuch_eg objectAtIndex:indexPath.row];
    return model.cellHight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    PUBBasicItmeModel *itmeModel = [self.basicModel.draffy_eg objectAtIndex:section];

    return itmeModel.more ? 40.f : 32.f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PUBBasicItmeModel *itmeModel = [self.basicModel.draffy_eg objectAtIndex:section];
    PUBBasicSectionHeaderView *sectionHeaderView = [[PUBBasicSectionHeaderView alloc] initWithTitle:itmeModel.neanderthaloid_eg Subtitle:itmeModel.sub_title more:itmeModel.more isHidde:itmeModel.isHidde];
    WEAKSELF
    sectionHeaderView.clicMoreBlock = ^(BOOL value) {
        STRONGSELF
        itmeModel.isHidde = value;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        [strongSelf tarckSelectClickIsUp:value];
    };
    return sectionHeaderView;
}

- (void)nextSelection: (NSIndexPath *)indexPath {
    if(self.basicModel.draffy_eg.count < indexPath.section)return;
    
    PUBBasicItmeModel *itmeModel = [self.basicModel.draffy_eg objectAtIndex:indexPath.section];
    if(itmeModel.somesuch_eg.count > indexPath.row + 1){
        PUBBasicSomesuchEgModel *model = [itmeModel.somesuch_eg objectAtIndex:indexPath.row + 1];
        if(![PUBTools isBlankString: model.oerlikon_eg]){
            return;
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UITableViewCell *cell = [self.basicTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]];

        if ([cell isKindOfClass:[PUBBasicEnumCell class]]) {
            PUBBasicEnumCell *tCell = (PUBBasicEnumCell *)cell;
            [tCell clickAction];
        }
        if([cell isKindOfClass:[PUBBasicDayCell class]]){
            PUBBasicDayCell *dayCell = (PUBBasicDayCell *)cell;
            [dayCell clickAction];
        }
        WEAKSELF
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            STRONGSELF
            [strongSelf.basicTableView setContentOffset:CGPointMake(strongSelf.basicTableView.contentOffset.x, strongSelf.basicTableView.contentOffset.y + cell.frame.size.height)];
        });
    });

}


#pragma mark - 用户点击埋点
- (void)tarckClickTagString:(NSString*)tagStr
{
    [PUBTrackHandleManager trackAppEventName:@"af_pub_click_basic_item" withElementParam:@{@"tag": tagStr}];
}

#pragma mark - 用户选择结果埋点
- (void)tarckSelectResultTagString:(NSString*)TagStr contentString:(NSString*)contentStr
{
    [PUBTrackHandleManager trackAppEventName:@"af_pub_result_basic_item" withElementParam:@{@"tag": TagStr,
                       @"content": contentStr}];
}

#pragma mark - 用户认证选项折叠埋点
- (void)tarckSelectClickIsUp:(BOOL)isUp
{
   
  [PUBTrackHandleManager trackAppEventName:isUp ? @"af_pub_click_basic_more": @"af_pub_click_basic_hide" withElementParam:@{}];
    
}

#pragma mark - 更新倒计时
- (void)updataCountDown:(NSInteger)countDown
{
    
    if(countDown > 0){
        self.downView.countTime = countDown;
        self.downView.hidden = NO;
        self.downView.height = 76.f;
        self.nextTopImageView.Y = self.downView.bottom + 8.f;
        self.backView.y = self.nextTopImageView.bottom + 8.f;
        self.backView.height = KSCREEN_HEIGHT - self.nextTopImageView.bottom - 8.f;
        self.basicTableView.height =  self.backView.height - self.nextBtn.height -  KSafeAreaBottomHeight - self.navBar.bottom;
        return;
    }
    
    self.downView.countTime = 0;
    self.downView.hidden = YES;
    self.downView.height = 0;
    self.nextTopImageView.Y = 8.f;
    self.backView.y = self.nextTopImageView.bottom + 8.f;
    self.backView.height = KSCREEN_HEIGHT - self.nextTopImageView.bottom - 8.f;
    self.basicTableView.height = self.backView.height - self.nextBtn.height - KSafeAreaBottomHeight - self.navBar.bottom;
    
}

-(void)nexBtnCkick
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (PUBBasicItmeModel *itmeModel in self.basicModel.draffy_eg) {
        for (PUBBasicSomesuchEgModel *obj in itmeModel.somesuch_eg) {
            if(obj.stare_eg.integerValue == 0){
                if([PUBTools isBlankString:obj.oerlikon_eg]){
                    [PUBTools showToast:NotNull(obj.outbound_eg)];
                    return;
                }else{
                    [dic setValue:obj.oerlikon_eg forKey:obj.paramorphism_eg];
                    continue;
                }
            }else{
                [dic setValue:NotNull(obj.oerlikon_eg) forKey:obj.paramorphism_eg];
                 continue;
            }
        }
        
    }
    NSDictionary *pointDic = @{
                                @"testudinal_eg": @(self.startTime.doubleValue),
                                @"grouse_eg": NotNull(self.productId),
                                @"classer_eg":@"22",
                                @"neuroleptic_eg":@(PUBLocation.latitude),
                                @"milligramme_eg":@([PUBTools getTime].doubleValue),
                                @"infortune_eg": NotNull(NSObject.getIDFV),
                                @"nonrecurring_eg":@(PUBLocation.longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"perikaryon_eg"]= NotNull(self.productId);
    [self nexBtnCkickRequestDic:dic];
}

- (void)nexBtnCkickRequestDic:(NSDictionary*)dic
{
    [PUBTrackHandleManager trackAppEventName:@"af_pub_start_basic" withElementParam:@{}];
    WEAKSELF
    [self.viewModel getSaveBasicInfoView:self.view dic:dic finish:^(NSDictionary * _Nonnull dic) {
        STRONGSELF
        [PUBTrackHandleManager trackAppEventName:@"af_pub_success_basic" withElementParam:@{}];
        if(User.is_aduit){
            [strongSelf removeViewController];
            return;
        }
        NSString *nextStr = [NSString stringWithFormat:@"%@",dic[@"nonparticipant_eg"][@"excuse"]];
        if(![PUBTools isBlankString:nextStr]){
            [PUBRouteManager routeWitheNextPage:nextStr productId:NotNull(strongSelf.productId)];
            [strongSelf removeViewController];
            return;
        }
        [strongSelf productPush];
    } failture:^{
        
    }];
}

-(void)productPush
{
    NSDictionary *dic = @{
                          @"order_no":NotNull(Config.hypokinesis_eg),
                          @"furnisher_eg":@"dddd",
                          @"billyboy_eg":@"houijhyus",
                         };
    WEAKSELF
    [self.loanViewModel getproductPushView:self.view dic:dic finish:^(NSString * _Nonnull url) {
        STRONGSELF
        [PUBRouteManager routeWitheNextPage:url productId:@""];
        [strongSelf removeViewController];
    } failture:^{
        
    }];
}

- (void)removeViewController
{
    NSMutableArray *VCArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [VCArr removeObject:self];
    self.navigationController.viewControllers =VCArr;
}

#pragma mark - lazy
- (PUBBasicViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PUBBasicViewModel alloc] init];
    }
    return _viewModel;
}

- (PUBBasicCountDownView *)downView{
    if(!_downView){
        _downView = [[PUBBasicCountDownView alloc] initWithFrame:CGRectMake(20.f, 16.f, KSCREEN_WIDTH - 40.f, 76.f)];
        _downView.hidden = YES;
        WEAKSELF
        _downView.countDownEndBlock = ^{
          STRONGSELF
            [strongSelf updataCountDown:0];
        };
    }
    return _downView;
}

- (UIImageView *)nextTopImageView{
    if(!_nextTopImageView){
        _nextTopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_baisc_next"]];
        _nextTopImageView.frame = CGRectMake(32.f, self.downView.bottom + 8, KSCREEN_WIDTH - 52.f , 58.f);
        _nextTopImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _nextTopImageView;
}

- (QMUIButton *)nextBtn{
    if(!_nextBtn){
        _nextBtn = [QMUIButton buttonWithType:UIButtonTypeSystem];
        [_nextBtn addTarget:self action:@selector(nexBtnCkick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.frame = CGRectMake(32.f,self.contentView.height - KSafeAreaBottomHeight - 48.f, KSCREEN_WIDTH - 64.f, 48.f);
        _nextBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"] ;
        _nextBtn.cornerRadius = 24.f;
        _nextBtn.titleLabel.font = FONT(20.f);
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#13062A"] forState:UIControlStateNormal];
    }
    return _nextBtn;
}

- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc] qmui_initWithSize:CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT - self.nextTopImageView.bottom + 8.f)];
        _backView.frame = CGRectMake(0, self.nextTopImageView.bottom + 8.f, KSCREEN_WIDTH, KSCREEN_HEIGHT - self.nextTopImageView.bottom + 8.f);
        [_backView showTopRarius: 24.f];
        _backView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
    }
    return _backView;
}

- (UITableView *)basicTableView{
    if(!_basicTableView){
        _basicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, self.backView.height - self.nextBtn.height - 136.f) style:UITableViewStyleGrouped];
        _basicTableView.delegate = self;
        _basicTableView.dataSource = self;
        _basicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _basicTableView.showsVerticalScrollIndicator = NO;
        _basicTableView.sectionFooterHeight = 0;
        _basicTableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        //_basicTableView.backgroundColor = [UIColor yellowColor];
    }
    
    return _basicTableView;
}

- (PUBWanLiuView *)wanLiuView{
    if(!_wanLiuView){
        _wanLiuView = [[PUBWanLiuView alloc] init];
        WEAKSELF
        _wanLiuView.confirmBlock = ^{
            STRONGSELF
            [PUBTrackHandleManager trackAppEventName:@"af_pub_page_basic_exit" withElementParam:@{}];
            [strongSelf.wanLiuView hide];
            [strongSelf.navigationController qmui_popViewControllerAnimated:YES completion:nil];
        };
    }
    return _wanLiuView;
}

-(PUBLoanViewModel *)loanViewModel{
    if(!_loanViewModel){
        _loanViewModel = [[PUBLoanViewModel alloc] init];
    }
    return _loanViewModel;
}

@end
