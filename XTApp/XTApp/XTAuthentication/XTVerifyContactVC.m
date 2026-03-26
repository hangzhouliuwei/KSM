//
//  XTVerifyContactVC.m
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import "XTVerifyContactVC.h"
#import "XTSetAltView.h"
#import <YFPopView/YFPopView.h>
#import "XTVerifyViewModel.h"
#import "XTLocationManger.h"
#import "XTVerifyHeadView.h"
#import "XTVerifyContactModel.h"
#import "XTVerifyContactCell.h"
#import "XTSelectView.h"
#import <YFPopView/YFPopView.h>
#import "XTContactItemModel.h"
#import <ContactsUI/ContactsUI.h>

@interface XTVerifyContactVC ()<UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate>

@property(nonatomic,strong) XTVerifyViewModel *viewModel;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *submitBtn;
@property(nonatomic,copy) NSString *startTime;
@property(nonatomic,copy) XTDicBlock indexBlock;

@end

@implementation XTVerifyContactVC

- (instancetype)initWithProductId:(NSString *)productId
                          orderId:(NSString *)orderId {
    self = [super init];
    if(self) {
        self.productId = productId;
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([NSString xt_isEmpty:[XTLocationManger xt_share].xt_longitude] || [NSString xt_isEmpty:[XTLocationManger xt_share].xt_latitude]) {
        [[XTLocationManger xt_share] xt_startLocation];
    }
    self.startTime = [[XTUtility xt_share] xt_nowTimeStamp];
    self.xt_title = @"Contact";
    self.xt_title_color = [UIColor whiteColor];
    self.view.backgroundColor = XT_RGB(0xF7F7F7, 1.0f);
    [self xt_UI];
    @weakify(self)
    [self.viewModel xt_contact:self.productId success:^{
        @strongify(self)
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

- (void)xt_UI {
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-XT_Bottom_Height-20);
        make.height.equalTo(@48);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.xt_navView.mas_bottom);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(-20);
    }];
    
    self.tableView.tableHeaderView = [[XTVerifyHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 94) type:XT_Verify_Contact];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.contactModel.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"XTVerifyContactCell";
    XTVerifyContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[XTVerifyContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    @weakify(self)
    XTContactItemModel *model = self.viewModel.contactModel.items[indexPath.row];
    cell.model = model;
    cell.block = ^(XTDicBlock block) {
        @strongify(self)
        [self selectRelation:model block:block];
    };
    cell.contactBlock = ^(XTDicBlock block) {
        @strongify(self)
        self.indexBlock = block;
        [self goContactVC];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 196;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView xt_frame:CGRectMake(0, 0, self.view.width, 20) color:self.view.backgroundColor];
    [view xt_rect:view.bounds corners:UIRectCornerTopLeft|UIRectCornerTopRight size:CGSizeMake(20, 20)];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(void)selectRelation:(XTContactItemModel *)model block:(XTDicBlock)block{
    XTSelectView *view = [[XTSelectView alloc] initTit:@"Please Select" arr:model.relation];
    [view xt_value:model.threeValue];
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:view];
    __weak YFPopView *weakView = popView;
    popView.animationStyle = YFPopViewAnimationStyleBottomToTop;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    view.closeBlock = ^{
        [weakView removeSelf];
    };
    view.sureBlock = ^(NSDictionary *dic) {
        if(block){
            block(dic);
        }
    };
}

-(void)goContactVC {
    CNContactPickerViewController *contactVc = [[CNContactPickerViewController alloc]init];
    contactVc.delegate = self;

    [self xt_presentViewController:contactVc animated:YES completion:^{
        
    } modalPresentationStyle:UIModalPresentationFullScreen];
}

#pragma mark CNContactPickerDelegate
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
    
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSString *givenName = contact.givenName;
    NSString *familyName = contact.familyName;
    //全名
    NSMutableString *name = [NSMutableString string];
    if ([familyName length] > 0) {
        [name appendString:familyName];
    }
    if ([givenName length] > 0) {
        [name appendString:givenName];
    }
    NSString *phone = nil;
    NSArray *tmpArr = contact.phoneNumbers;
    for (CNLabeledValue *labelValue  in tmpArr) {
        CNPhoneNumber * number = labelValue.value;
        NSString *phoneNumber = number.stringValue;
        if (phoneNumber.length > 0) {
            phone = phoneNumber;
            break;
        }
    }
    
    phone = [phone xt_trimPhoneNumber];
    if(self.indexBlock) {
        self.indexBlock(@{
            @"name":XT_Object_To_Stirng(name),
            @"value":XT_Object_To_Stirng(phone),
        });
    }

}


-(void)xt_back {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    XTSetAltView *altView = [[XTSetAltView alloc] initWithAlt:@"Are you sure you want to\n leave?"];
    altView.center = self.view.center;
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:altView];
    popView.animationStyle = YFPopViewAnimationStyleFade;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    __weak YFPopView *weakView = popView;
    @weakify(self)
    altView.sureBlock = ^{
        [weakView removeSelf];
        weakView.didDismiss = ^(YFPopView *popView) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        };
    };
    altView.cancelBlock = ^{
        [weakView removeSelf];
    };
}

-(void)goSubmit {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for(XTContactItemModel *model in self.viewModel.contactModel.items) {
        if(model.xt_field.count == 3){
            if([NSString xt_isEmpty:model.firstValue] || [NSString xt_isEmpty:model.secondValue] || [NSString xt_isEmpty:model.threeValue]) {
                [XTUtility xt_showTips:[NSString stringWithFormat:@"Please complete %@",model.xt_title] view:self.view];
                return;
            }
            [dic setObject:XT_Object_To_Stirng(model.firstValue) forKey:XT_Object_To_Stirng(model.xt_field[0][@"uporsixnNc"])];
            [dic setObject:XT_Object_To_Stirng(model.secondValue) forKey:XT_Object_To_Stirng(model.xt_field[1][@"uporsixnNc"])];
            [dic setObject:XT_Object_To_Stirng(model.threeValue) forKey:XT_Object_To_Stirng(model.xt_field[2][@"uporsixnNc"])];
        }
    }
    [dic setObject:XT_Object_To_Stirng(self.productId) forKey:@"lietsixusNc"];
    NSDictionary *point = @{
        @"deamsixatoryNc":XT_Object_To_Stirng(self.startTime),
        @"munisixumNc":XT_Object_To_Stirng(self.productId),
        @"hyrasixrthrosisNc":@"23",
        @"boomsixofoNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_latitude),
        @"unulsixyNc":XT_Object_To_Stirng([[XTUtility xt_share] xt_nowTimeStamp]),
        @"cacosixtomyNc":XT_Object_To_Stirng([XTDevice xt_share].xt_idfv),
        @"unevsixoutNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_longitude),
    };
    [dic setObject:point forKey:@"point"];
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_contact_next:dic success:^(NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [self goNext:str];
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

-(void)goNext:(NSString *)str{
//    if([XTUserManger xt_share].xt_user.xt_is_aduit){
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
    @weakify(self)
    if([NSString xt_isEmpty:str]) {
        [XTUtility xt_showProgress:self.view message:@"loading..."];
        [self.viewModel xt_push:self.orderId success:^(NSString *str) {
            @strongify(self)
            [XTUtility xt_atHideProgress:self.view];
            [[XTRoute xt_share] goHtml:str success:^(BOOL success) {
                @strongify(self)
                if(success){
                    [self xt_removeSelf];
                }
            }];
            
        } failure:^{
            @strongify(self)
            [XTUtility xt_atHideProgress:self.view];
        }];
        return;
    }
    [[XTRoute xt_share] goVerifyItem:str productId:self.productId orderId:self.orderId success:^(BOOL success) {
        @strongify(self)
        if(success){
            [self xt_removeSelf];
        }
    }];
}

-(void)xt_removeSelf {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [arr removeObject:self];
    self.navigationController.viewControllers = arr;
}

- (XTVerifyViewModel *)viewModel {
    if(!_viewModel){
        _viewModel = [XTVerifyViewModel new];
    }
    return _viewModel;
}

#pragma mark 列表
- (UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.estimatedRowHeight = 50;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//如果cell不能铺满屏幕，下面的分割线没有
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        _tableView = tableView;
    }
    return _tableView;
}

- (UIButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [UIButton xt_btn:@"Next" font:XT_Font_B(24) textColor:[UIColor whiteColor] cornerRadius:24 tag:0];
        _submitBtn.backgroundColor = XT_RGB(0x02CC56, 1.0f);
        @weakify(self)
        _submitBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [self goSubmit];
            return [RACSignal empty];
        }];
    }
    return _submitBtn;
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
