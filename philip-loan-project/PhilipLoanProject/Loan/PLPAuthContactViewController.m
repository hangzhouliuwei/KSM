//
//  AuthContactViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/5.
//

#import "PLPAuthContactViewController.h"
#import "BasicHeadView.h"
#import "BasicTimerView.h"
#import "AuthContactViewCell.h"
#import <ContactsUI/ContactsUI.h>
#import "AuthSelectAlertView.h"
@interface PLPAuthContactViewController ()<UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic)NSMutableArray *dataSource;
@property(nonatomic)UIView *headerView;
@property(nonatomic)BasicHeadView *progressView;
@property(nonatomic)BasicTimerView *timerView;
@property(nonatomic)NSInteger index;
@end

@implementation PLPAuthContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.baseImageView removeFromSuperview];
    self.navigationItem.title = @"Contact";
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 283);
    gradientLayer.colors = @[
        (__bridge id)kBlueColor_0053FF.CGColor,  // #2964F6
        (__bridge id)kHexColor(0xF5F5F5).CGColor   // #F9F9F9
    ];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    [self plp_generateSubview];
    self.shouldPopHome = true;
    self.holdConetent = @"Enhance vour loan approval chances byproviding your emergency contact information now.";
}
-(void)handleNextButtonAction:(UIButton *)button
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (AuthContactModel *model in self.dataSource) {
        if (!model.selectedModel || (![model.contactName isReal] && ![model.contactPhone isReal])) {
            kPLPPopInfoWithStr(@"Please make a selection");
            return;
        }
        result[model.inhotwelveationNc[0][@"uportwelvenNc"]] = model.contactName;
        result[model.inhotwelveationNc[1][@"uportwelvenNc"]] = model.contactPhone;
        result[model.inhotwelveationNc[2][@"uportwelvenNc"]] = @(model.selectedModel.demptwelvehasizeNc);
    }
    result[@"point"] = [self BASE_GeneragePointDictionaryWithType:@"23"];
    result[@"liettwelveusNc"] = [PLPDataManager manager].productId;
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/contact_next" paramsInfo:result successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        NSDictionary *data = responseObject[@"viustwelveNc"][@"deectwelvetibleNc"];
        [self decodeAuthResponseData:data];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
    
}
#pragma marl -UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuthContactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AuthContactModel *model = _dataSource[indexPath.row];
    cell.model = model;
    kWeakSelf
    cell.tapItemBlk = ^(NSInteger index) {
        if (index == 0) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (AuthContactRelationModel *temp in model.beditwelveeNc) {
                [tempArray addObject:temp.uportwelvenNc];
            }
            AuthSelectAlertView *view = [[AuthSelectAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 350)];
            view.titleLabel.text = model.fldgtwelveeNc;
            view.itemArray = tempArray;
            view.tapItemBlk = ^(AuthItemModel * _Nonnull itemModel, NSInteger index) {
                model.selectedModel = model.beditwelveeNc[index];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            };
            [view popAlertViewOnBottom];
        }else{
            weakSelf.index = indexPath.row;
            CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
            contactPicker.delegate = weakSelf;
            contactPicker.modalPresentationStyle = UIModalPresentationFullScreen;
            [weakSelf presentViewController:contactPicker animated:YES completion:nil];;
        }
    };
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *name = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
    NSArray *array = contact.phoneNumbers;
    NSString *phone = contact.phoneNumbers.lastObject.value.stringValue?:@"";
    AuthContactModel *model = _dataSource[self.index];
    model.contactName = name.length > 0 ? name : @"";
    model.contactPhone = phone.length > 0 ? phone : @"";
    [self.tableView reloadData];
}
-(void)BASE_RequestHTTPInfo
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/contact" paramsInfo:@{@"liettwelveusNc":[PLPDataManager manager].productId,@"seistwelveacredNc":@"blaalleynk"} successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        NSDictionary *data = responseObject[@"viustwelveNc"];
        NSInteger time = [data[@"paeotwelvegrapherNc"] integerValue];
        if (time > 0) {
            self.timerView.count = time;
            [self.timerView startTimer];
            [self.headerView addSubview:self.timerView];
            self.headerView.height = self.timerView.bottom + 12;
            self.tableView.tableHeaderView = _headerView;
        }
        for (NSDictionary *dic in data[@"ovrftwelveraughtNc"]) {
            AuthContactModel *model = [AuthContactModel yy_modelWithDictionary:dic];
            if (model.koNctwelve) {
                for (AuthContactRelationModel *relation in model.beditwelveeNc) {
                    if (relation.demptwelvehasizeNc == model.koNctwelve.beditwelveeNc) {
                        model.selectedModel = relation;
                    }
                }
                if ([model.koNctwelve.uportwelvenNc isReal]) {
                    model.contactName = model.koNctwelve.uportwelvenNc;
                }
                if ([model.koNctwelve.halotwelvewNc isReal]) {
                    model.contactPhone = model.koNctwelve.halotwelvewNc;
                }
            }
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(void)plp_generateSubview
{
    kWeakSelf
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0)];
    BasicHeadView *progressView = [[BasicHeadView alloc] initWithFrame:CGRectMake(15, 16, _headerView.width - 2 * 15, 85) index:1];
    self.progressView = progressView;
    [_headerView addSubview:progressView];
    self.timerView = [[BasicTimerView alloc] initWithFrame:CGRectMake(15, 16 + progressView.bottom, progressView.width, 114)];
    _timerView.timerFinishBlk = ^{
//        [weakSelf timerFinish];
    };
//    _headerView.backgroundColor = UIColor.redColor;
    _headerView.height = progressView.bottom + 12;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenW, kScreenH - kTopHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 257;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[AuthContactViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kBottomSafeHeight + 16, 0);
    [self.view addSubview:self.tableView];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(14, kScreenH - 47 - kBottomSafeHeight - 16, kScreenW - 28, 47);
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    nextButton.backgroundColor = kBlueColor_0053FF;
    nextButton.layer.cornerRadius = nextButton.height / 2.0;
    [nextButton addTarget:self action:@selector(handleNextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}
-(void)timerFinish
{
    [self.timerView removeFromSuperview];
    self.headerView.height = self.progressView.bottom + 12;
    self.tableView.tableHeaderView = _headerView;
}
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
