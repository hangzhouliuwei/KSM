//
//  PUBPhotosController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/5.
//

#import "PUBPhotosController.h"
#import "PUBBasicCountDownView.h"
#import "PUBLoanViewModel.h"
#import "PUBWanLiuView.h"

#import "PUBPhotosViewModel.h"
#import "PUBPhotosModel.h"
#import "PUBPhotosHeadView.h"
#import "PUBPhotoSingleView.h"

#import "PUBPhotoIDCardSingleView.h"
#import "UIViewController+XHPhoto.h"
#import "PUBBasicTxtCell.h"
#import "PUBBasicDayCell.h"

#import "PUBBirthdayView.h"
#import "PUBPhotoOptionCell.h"

@interface PUBPhotosController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) PUBBasicCountDownView *downView;
@property(nonatomic, strong) UIImageView *nextTopImageView;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) PUBWanLiuView *wanLiuView;
@property(nonatomic, strong) PUBPhotosModel *photosModel;
@property(nonatomic, strong) QMUIButton *nextBtn;
@property(nonatomic, strong) PUBLoanViewModel *loanViewModel;
@property(nonatomic, strong) PUBPhotosViewModel *viewModel;
@property(nonatomic, strong) PUBPhotosHeadView *headView;
@property(nonatomic, strong) UITableView *photosTableView;
@property(nonatomic, strong) PUBPhotosModel *model;
@property(nonatomic, strong) PUBPhotosDesideratumEgModel *datalModel;
@property(nonatomic, copy) NSString *startTime;
@end

@implementation PUBPhotosController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.navBar.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    [self.navBar showtitle:@"Photos" isLeft:YES];
    [self creatUI];
    [self reponseData];
     self.startTime = [PUBTools getTime];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PUBTrackHandleManager trackAppEventName:@"af_pub_page_cer" withElementParam:@{}];
    
}

- (void)reponseData
{
    NSDictionary *dic = @{
                          @"perikaryon_eg":NotNull(self.productId)
                         };
    WEAKSELF
    [self.viewModel getPhotosView:self.view dic:dic finish:^(PUBPhotosModel * _Nonnull photosModel) {
        STRONGSELF
        strongSelf.model = photosModel;
        strongSelf.datalModel = photosModel.desideratum_eg;
        [strongSelf updataCountDown:photosModel.sdlkfjl_eg];
        strongSelf.photosTableView.tableHeaderView = strongSelf.headView;
        if([PUBTools isBlankString:photosModel.desideratum_eg.lobsterman_eg]){
            [strongSelf.headView selsectViewClick];
        }else{
            [strongSelf.headView updataIDcardImageUrl:photosModel.desideratum_eg.lobsterman_eg];
        }
        strongSelf.nextBtn.hidden = strongSelf.datalModel.somesuch_eg.count > 0 ? NO : YES;
        [strongSelf.photosTableView reloadData];
    } failture:^{
        
    }];
    
}

- (void)backBtnClick:(UIButton *)btn
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self.wanLiuView show:IdentifictionType];
}

///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self.wanLiuView show:IdentifictionType];
    return NO;
}

- (void)creatUI
{
    self.contentView.height = KSCREEN_HEIGHT - self.navBar.bottom;
    [self.contentView addSubview:self.downView];
    [self.contentView addSubview:self.nextTopImageView];
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.nextBtn];
    [self.backView addSubview:self.photosTableView];
    
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
        self.photosTableView.height =  self.backView.height - self.nextBtn.height -  KSafeAreaBottomHeight - self.navBar.bottom;
        return;
    }
    
    self.downView.countTime = 0;
    self.downView.hidden = YES;
    self.downView.height = 0;
    self.nextTopImageView.Y = 8.f;
    self.backView.y = self.nextTopImageView.bottom + 8.f;
    self.backView.height = KSCREEN_HEIGHT - self.nextTopImageView.bottom - 8.f;
    self.photosTableView.height = self.backView.height - self.nextBtn.height - KSafeAreaBottomHeight - self.navBar.bottom;
    
}

- (void)nexBtnClick
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
   
        for (PUBBasicSomesuchEgModel *obj in self.datalModel.somesuch_eg) {
            if(obj.stare_eg.integerValue == 0){
                if([PUBTools isBlankString:obj.oerlikon_eg]){
                    [PUBTools showToast:STR_FORMAT(@"Please complete %@", NotNull(obj.outbound_eg))];
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
    NSDictionary *pointDic = @{
                                @"testudinal_eg": @(self.startTime.doubleValue),
                                @"grouse_eg": NotNull(self.productId),
                                @"classer_eg":@"24",
                                @"neuroleptic_eg":@(PUBLocation.latitude),
                                @"milligramme_eg":@([PUBTools getTime].doubleValue),
                                @"infortune_eg": NotNull(NSObject.getIDFV),
                                @"nonrecurring_eg":@(PUBLocation.longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"perikaryon_eg"]= NotNull(self.productId);
    if([PUBTools isBlankString:self.datalModel.oversail_eg]){
        dic[@"quadrivalent_eg"] = NotNull(self.datalModel.oerlikon_eg);
    }else{
        dic[@"quadrivalent_eg"] = NotNull(self.datalModel.oversail_eg);
    }
    
    [self nexBtnCkickRequestDic:dic];
    [self.loanViewModel getUploadDevice];
    
}

- (void)nexBtnCkickRequestDic:(NSDictionary*)dic
{
    WEAKSELF
    [PUBTrackHandleManager trackAppEventName:@"af_pub_start_cer" withElementParam:@{}];
    [self.viewModel getSaveIdPhotoView:self.view dic:dic finish:^(NSDictionary * _Nonnull dic) {
        STRONGSELF
        [PUBTrackHandleManager trackAppEventName:@"af_pub_success_cer" withElementParam:@{}];
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

- (void)removeViewController
{
    NSMutableArray *VCArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [VCArr removeObject:self];
    self.navigationController.viewControllers =VCArr;
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

- (void)updataOcrImage:(UIImage*)Image light:(NSInteger)light
{
    NSDictionary *dic = @{
                         @"light": @(light)
                         };
    WEAKSELF
    [PUBTrackHandleManager trackAppEventName:@"af_pub_start_cer_img" withElementParam:@{}];
    [self.viewModel uploadOcrImageView:self.view dic:dic imageTmp:Image finish:^(PUBPhotosDesideratumEgModel * _Nonnull photosModel) {
        STRONGSELF
        strongSelf.datalModel = photosModel;
        [strongSelf.headView updataIDcardImage:photosModel.idCardImage];
        strongSelf.photosTableView.tableHeaderView = strongSelf.headView;
        strongSelf.nextBtn.hidden = NO;
        [strongSelf.photosTableView reloadData];
        [PUBTrackHandleManager trackAppEventName:@"af_pub_success_cer_img" withElementParam:@{}];
    } failture:^{
        
        
    }];
    
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalModel.somesuch_eg.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"photosCellId";
    UITableViewCell *baseCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    if(indexPath.row > self.datalModel.somesuch_eg.count){
        return baseCell;
    }
    WEAKSELF
    PUBBasicSomesuchEgModel *model = [self.datalModel.somesuch_eg objectAtIndex:indexPath.row];
    if([model.cellType isEqualToString:@"txt"])
    {
        NSString*cellID = [NSString stringWithFormat:@"%zd", indexPath.row];
        PUBBasicTxtCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[PUBBasicTxtCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell configModel:model];
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
        NSString*cellID = [NSString stringWithFormat:@"%zd", indexPath.row];
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
                [strongSelf.photosTableView reloadData];
                //[strongSelf nextSelection:indexPath];
                [strongSelf tarckSelectResultTagString:model.paramorphism_eg contentString:model.oerlikon_eg];
            };
        };
        return cell;
        
    }
    if([model.cellType isEqualToString:@"option"]){
        NSString*cellID = [NSString stringWithFormat:@"%zd", indexPath.row];
        PUBPhotoOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[PUBPhotoOptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell configModel:model];
        cell.photoOptionBlock = ^(NSString * _Nonnull str) {
            STRONGSELF
            [strongSelf tarckSelectResultTagString:model.paramorphism_eg contentString:str];
        };
        return cell;
    }
    
    
    return baseCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PUBBasicSomesuchEgModel *model = [self.datalModel.somesuch_eg objectAtIndex:indexPath.row];
    return model.cellHight;
}


#pragma mark - 用户点击埋点
- (void)tarckClickTagString:(NSString*)tagStr
{
    [PUBTrackHandleManager trackAppEventName:@"af_pub_click_cer_item" withElementParam:@{@"tag": NotNull(tagStr)}];
}

#pragma mark - 用户选择结果埋点
- (void)tarckSelectResultTagString:(NSString*)tagStr contentString:(NSString*)contentStr
{
    [PUBTrackHandleManager trackAppEventName:@"af_pub_result_cer_item" withElementParam:@{@"type": NotNull(tagStr),
                       @"content": NotNull(contentStr)}];
}


#pragma mark - lazy
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
        _nextTopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_photos_next"]];
        _nextTopImageView.frame = CGRectMake(32.f, self.downView.bottom + 8, KSCREEN_WIDTH - 52.f , 58.f);
        _nextTopImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _nextTopImageView;
}

- (QMUIButton *)nextBtn{
    if(!_nextBtn){
        _nextBtn = [QMUIButton buttonWithType:UIButtonTypeSystem];
        [_nextBtn addTarget:self action:@selector(nexBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.frame = CGRectMake(32.f,self.contentView.height - KSafeAreaBottomHeight - 48.f, KSCREEN_WIDTH - 64.f, 48.f);
        _nextBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
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

- (PUBWanLiuView *)wanLiuView{
    if(!_wanLiuView){
        _wanLiuView = [[PUBWanLiuView alloc] init];
        WEAKSELF
        _wanLiuView.confirmBlock = ^{
            STRONGSELF
            [strongSelf.wanLiuView hide];
            [strongSelf.navigationController qmui_popViewControllerAnimated:YES completion:nil];
            [PUBTrackHandleManager trackAppEventName:@"af_pub_page_cer_exit" withElementParam:@{}];
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

- (PUBPhotosViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PUBPhotosViewModel alloc] init];
    }
    return _viewModel;
}

- (PUBPhotosHeadView *)headView{
    if(!_headView){
        _headView = [[PUBPhotosHeadView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, 324.f)];
        WEAKSELF
        _headView.selsecTypeBlock = ^{
            STRONGSELF
            [PUBTrackHandleManager trackAppEventName:@"af_pub_click_cer_type" withElementParam:@{}];
            PUBPhotoSingleView *singleView = [[PUBPhotoSingleView alloc] initWithData:strongSelf.model.desideratum_eg.horrific_eg title:@"Select An ID Type"];
            [singleView show];
            singleView.confirmBlock = ^(id  _Nonnull object) {
                PUBPhotosHorrificEgModel *model = (PUBPhotosHorrificEgModel*)object;
                [strongSelf.headView updataModel:model];
                [PUBTrackHandleManager trackAppEventName:@"af_pub_result_cer_type" withElementParam:@{@"type:":@(model.grocer_eg)}];
            };
        };
        _headView.idCardImageClickBlock = ^{
            STRONGSELF
            if(strongSelf.headView.selsecGrocer_eg == 0){
                [PUBTools showToast:@"please select a id type"];
                return;
            }
            PUBPhotoIDCardSingleView *idCdrdSingleView = [[PUBPhotoIDCardSingleView alloc] initWithData:@[@"Photo",@"Camera"] title:@"Select Upload Method"];
            [idCdrdSingleView show];
            idCdrdSingleView.confirmBlock = ^(id  _Nonnull object) {
                NSString *seleStr = (NSString*)object;
                if([seleStr isEqualToString:@"Photo"]){
                    [strongSelf showPhotoLibraryCanEdit:NO photo:^(UIImage *photo) {
                        if(photo){
                          [strongSelf updataOcrImage:photo light:strongSelf.headView.selsecGrocer_eg];
                        }
                        
                    }];
                    
                }else if ([seleStr isEqualToString:@"Camera"]){
                    [strongSelf showCameraCanEdit:NO photo:^(UIImage *photo) {
                        if(photo){
                          [strongSelf updataOcrImage:photo light:strongSelf.headView.selsecGrocer_eg];
                        }
                        
                    }];
                }
            };
        };
    }
    return _headView;
}


- (UITableView *)photosTableView{
    if(!_photosTableView){
        _photosTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, self.backView.height - self.nextBtn.height - 136.f) style:UITableViewStyleGrouped];
        _photosTableView.delegate = self;
        _photosTableView.dataSource = self;
        _photosTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _photosTableView.showsVerticalScrollIndicator = NO;
        _photosTableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        //_basicTableView.backgroundColor = [UIColor yellowColor];
    }
    
    return _photosTableView;
}
@end
