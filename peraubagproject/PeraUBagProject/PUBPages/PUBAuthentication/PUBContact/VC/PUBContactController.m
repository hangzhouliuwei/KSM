//
//  PUBContactController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/4.
//

#import "PUBContactController.h"
#import "PUBContactViewModel.h"
#import "PUBBasicModel.h"
#import "PUBBasicCountDownView.h"

#import "PUBLoanViewModel.h"
#import "PUBWanLiuView.h"
#import "PUBContactModel.h"
#import "PUBContanctCell.h"

#import "PUBContanSingleView.h"
#import <ContactsUI/ContactsUI.h>


@interface PUBContactController ()<UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate>
@property(nonatomic, strong) PUBContactViewModel *viewModel;
@property(nonatomic, strong) PUBBasicCountDownView *downView;
@property(nonatomic, strong) UIImageView *nextTopImageView;
@property(nonatomic, strong) QMUIButton *nextBtn;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UITableView *contactTableView;
@property(nonatomic, strong) PUBWanLiuView *wanLiuView;
@property(nonatomic, strong) PUBLoanViewModel *loanViewModel;
@property(nonatomic, strong) PUBContactModel *contactModel;
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, strong) PUBContactItmeModel *selectModel;
@property(nonatomic, assign) NSInteger seletIndex;
@end

@implementation PUBContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.navBar.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    [self.navBar showtitle:@"Contact" isLeft:YES];
    [self creatUI];
    [self reponseData];
    self.startTime = [PUBTools getTime];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PUBTrackHandleManager trackAppEventName:@"af_pub_page_contact" withElementParam:@{}];
}

- (void)creatUI
{
    self.contentView.height = KSCREEN_HEIGHT - self.navBar.bottom;
    [self.contentView addSubview:self.downView];
    [self.contentView addSubview:self.nextTopImageView];
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.nextBtn];
    [self.backView addSubview:self.contactTableView];
}

- (void)reponseData
{
    NSDictionary *dic=@{
                       @"perikaryon_eg": NotNull(self.productId),
                       @"aluminosilicate_eg": @"blaalleynk",
                       };
    WEAKSELF
    [self.viewModel getContactView:self.view dic:dic finish:^(PUBContactModel * _Nonnull contactModel) {
        STRONGSELF
        strongSelf.contactModel = contactModel;
        [strongSelf updataCountDown:strongSelf.contactModel.sdlkfjl_eg];
        [strongSelf.contactTableView reloadData];
    } failture:^{
        
    }];
    
}

- (void)backBtnClick:(UIButton *)btn
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self.wanLiuView show:ContactType];
}

///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self.wanLiuView show:ContactType];
    return NO;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactModel.draffy_eg.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"contactCellId";
    UITableViewCell *baseCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    if(indexPath.row > self.contactModel.draffy_eg.count){
        return baseCell;
    }
    
    NSString*cellID = [NSString stringWithFormat:@"%zd+%zd",indexPath.section, indexPath.row];
    PUBContanctCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[PUBContanctCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    PUBContactItmeModel *itmeModel = [self.contactModel.draffy_eg objectAtIndex:indexPath.row];
    [cell configModel:itmeModel];
    WEAKSELF
    cell.relationshipViewBlock = ^{
        PUBContanSingleView *singleView = [[PUBContanSingleView alloc] initWithData:itmeModel.featherstitch_eg title:itmeModel.neanderthaloid_eg];
        [singleView show];
        singleView.confirmBlock = ^(id  _Nonnull object) {
            PUBContactFeatherstitchEgModel *model = (PUBContactFeatherstitchEgModel*)object;
            itmeModel.megrim_eg.featherstitch_eg = model.skeeter_eg;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    };
    cell.contactViewBlock = ^{
        STRONGSELF
        strongSelf.seletIndex = indexPath.row;
        strongSelf.selectModel = itmeModel;
        CNContactPickerViewController *pickerViewController = [[CNContactPickerViewController alloc] init];
        pickerViewController.delegate = strongSelf;
        pickerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [strongSelf presentViewController:pickerViewController animated:YES completion:nil];
        [PUBTrackHandleManager trackAppEventName:@"af_pub_click_contact" withElementParam:@{@"index": @(indexPath.row)}];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170.f;
}


#pragma mark - delegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSString *firstName = contact.givenName;
    NSString *lastName = contact.familyName;
    NSString *name = [NSString string];
    if (firstName != nil && firstName.length > 0) {
        name = firstName;
    } else {
        name = lastName;
    }
    for (CNLabeledValue *phone in contact.phoneNumbers) {
        CNPhoneNumber *phoneNumber = phone.value;
        NSString *phoneString = phoneNumber.stringValue;

        NSLog(@"Name: %@ %@", firstName, lastName);
        NSLog(@"Phone: %@", phoneString);
        self.selectModel.megrim_eg.rhodo_eg = NotNull(name);
        self.selectModel.megrim_eg.xat_eg = NotNull(phoneString);
        
        [PUBTrackHandleManager trackAppEventName:@"af_pub_result_contact" withElementParam:@{
                                                                                            @"index": @(self.seletIndex),
                                                                                            @"name": NotNull(self.selectModel.megrim_eg.rhodo_eg),
                                                                                            @"phone": NotNull(self.selectModel.megrim_eg.xat_eg),
                                                                                            
                                                                                            }];
    }
    [self.contactTableView reloadData];
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker 
{
    // 用户取消了联系人选择
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
        self.contactTableView.height =  self.backView.height - self.nextBtn.height -  KSafeAreaBottomHeight - self.navBar.bottom;
        return;
    }
    
    self.downView.countTime = 0;
    self.downView.hidden = YES;
    self.downView.height = 0;
    self.nextTopImageView.Y = 8.f;
    self.backView.y = self.nextTopImageView.bottom + 8.f;
    self.backView.height = KSCREEN_HEIGHT - self.nextTopImageView.bottom - 8.f;
    self.contactTableView.height = self.backView.height - self.nextBtn.height - KSafeAreaBottomHeight - self.navBar.bottom;
    
}

- (void)nexBtnCkick
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self.contactModel.draffy_eg enumerateObjectsUsingBlock:^(PUBContactItmeModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setValue:model.megrim_eg.rhodo_eg forKey:model.endothelium_eg[0][@"rhodo_eg"]];
        [dic setValue:model.megrim_eg.xat_eg forKey:model.endothelium_eg[1][@"rhodo_eg"]];
        [dic setValue:@(model.megrim_eg.featherstitch_eg) forKey:model.endothelium_eg[2][@"rhodo_eg"]];
    }];
    
    NSDictionary *pointDic = @{
                                @"testudinal_eg": @(self.startTime.doubleValue),
                                @"grouse_eg": NotNull(self.productId),
                                @"classer_eg":@"23",
                                @"neuroleptic_eg":@(PUBLocation.latitude),
                                @"milligramme_eg":@([PUBTools getTime].doubleValue),
                                @"infortune_eg": NotNull(NSObject.getIDFV),
                                @"nonrecurring_eg":@(PUBLocation.longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"perikaryon_eg"]= NotNull(self.productId);
    NSLog(@"lw=====>%@",dic);
    [self nexBtnCkickRequestDic:dic];
}

- (void)nexBtnCkickRequestDic:(NSDictionary*)dic
{
    WEAKSELF
    [PUBTrackHandleManager trackAppEventName:@"af_pub_start_contact" withElementParam:@{}];
    [self.viewModel getSaveEmergencyContactView:self.view dic:dic finish:^(NSDictionary * _Nonnull dic) {
        STRONGSELF
        [PUBTrackHandleManager trackAppEventName:@"af_pub_success_contact" withElementParam:@{}];
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

- (PUBContactViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PUBContactViewModel alloc] init];
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
        _nextTopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_contact_next"]];
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

- (UITableView *)contactTableView{
    if(!_contactTableView){
        _contactTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, self.backView.height - self.nextBtn.height - 136.f) style:UITableViewStylePlain];
        _contactTableView.delegate = self;
        _contactTableView.dataSource = self;
        _contactTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contactTableView.showsVerticalScrollIndicator = NO;
        _contactTableView.sectionFooterHeight = 0;
        _contactTableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        //_contactTableView.backgroundColor = [UIColor yellowColor];
    }
    
    return _contactTableView;
}

- (PUBWanLiuView *)wanLiuView{
    if(!_wanLiuView){
        _wanLiuView = [[PUBWanLiuView alloc] init];
        WEAKSELF
        _wanLiuView.confirmBlock = ^{
            STRONGSELF
            [strongSelf.wanLiuView hide];
            [strongSelf.navigationController qmui_popViewControllerAnimated:YES completion:nil];
            [PUBTrackHandleManager trackAppEventName:@"af_pub_page_contact_exit" withElementParam:@{}];
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
