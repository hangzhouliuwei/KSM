//
//  AuthCradViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/5.
//

#import "PLPAuthCardViewController.h"
#import "BasicTimerView.h"
#import "AuthTableViewCell.h"
#import "AuthBankViewCell.h"
#import "BankHeaderView.h"
#import "AuthSelectAlertView.h"
#import "BankConfirmAlertView.h"
@interface PLPAuthCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)UIView *headerView;
@property(nonatomic)BasicTimerView *timerView;
@property(nonatomic)UITableView *tableView;
@property(nonatomic)NSInteger index;
@property(nonatomic)NSMutableArray *dataSource1;
@property(nonatomic)NSMutableArray *dataSource2;
@end

@implementation PLPAuthCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 283);
    gradientLayer.colors = @[
        (__bridge id)kBlueColor_0053FF.CGColor,  // #2964F6
        (__bridge id)kHexColor(0xF5F5F5).CGColor   // #F9F9F9
    ];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    self.navigationItem.title = @"Withdrawal account";
    self.holdConetent = @"Take the final step to apply for your loan -submitting now will enhance your approval rate.";
    self.shouldPopHome = true;
}
-(void)handleNextButtonAction:(UIButton *)button
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSString *bank = @"";
    NSString *number = @"";
    if (self.index == 0) {
        AuthBankModel *model;
        for (AuthBankModel *temp in self.dataSource1) {
            if ([temp isKindOfClass:[AuthBankModel class]]) {
                if(temp.isSelected) {
                    model = temp;
                }
            }
        }
        if (!model) {
            kPLPPopInfoWithStr(@"Choose the recipient’s e-wallet.");
            return;
        }
        result[@"blthtwelveelyNc"] = @(model.regntwelveNc);
        bank = model.uportwelvenNc;
        AuthOptionalModel *option = self.dataSource1.lastObject;
        if ([option.valueStr isReal]) {
            NSString *account = @"";
            if ([[kMMKV getStringForKey:kPhoneKey] hasPrefix:@"0"]) {
                account = option.valueStr;
            }else
            {
//                account = [NSString stringWithFormat:@"0%@",option.valueStr];
                account = option.valueStr;
            }
            number = option.valueStr;
            result[@"ovrctwelveutNc"] = account;
        }else
        {
            kPLPPopInfoWithStr(@"Enter your e-wallet account information.");
            return;
        }
    }else
    {
        AuthSectionModel *temp = _dataSource2.firstObject;
        AuthOptionalModel *model1 = temp.xathtwelveosisNc.firstObject;
        AuthOptionalModel *model2 = temp.xathtwelveosisNc.lastObject;
        if (model1.selectedModel) {
            result[@"blthtwelveelyNc"] = @([model1.selectedModel.regntwelveNc integerValue]);
            bank = model1.selectedModel.uportwelvenNc;
        }else
        {
            kPLPPopInfoWithStr(@"Select the recipient's bank.");
            return;
        }
        if ([model2.valueStr isReal]) {
            NSString *account = @"";
            if ([[kMMKV getStringForKey:kPhoneKey] hasPrefix:@"0"]) {
                account = model2.valueStr;
            }else
            {
//                account = [NSString stringWithFormat:@"0%@",model2.valueStr];
                account = model2.valueStr;
            }
            result[@"ovrctwelveutNc"] = account;
            number = model2.valueStr;
        }else
        {
            kPLPPopInfoWithStr(@"Provide your bank account number.");
            return;
        }
    }
    result[@"liettwelveusNc"] = [PLPDataManager manager].productId;
    result[@"ceNctwelve"] = self.index == 0 ? @"2" : @"1";
    result[@"point"] = [self BASE_GeneragePointDictionaryWithType:@"26"];
    BankConfirmAlertView *view = [[BankConfirmAlertView alloc] initWithFrame:CGRectMake(0, 0, 321, 337)];
    view.label1.text = bank;
    view.label2.text = number;
    view.tapBtnBlk = ^(NSInteger index) {
        kShowLoading
        [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/card_next" paramsInfo:result successBlk:^(id  _Nonnull responseObject) {
            kHideLoading
            NSDictionary *data = responseObject[@"viustwelveNc"][@"deectwelvetibleNc"];
            [self decodeAuthResponseData:data];
        } failureBlk:^(NSError * _Nonnull error) {
            
        }];
    };
    [view popAlertViewOnCenter];
    
}
-(void)tapItemIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf
    AuthTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    AuthSectionModel *temp = _dataSource2[indexPath.section];
    AuthOptionalModel *model = temp.xathtwelveosisNc[indexPath.row];
    if (model.type == kAuthCellType_Select) {
        AuthSelectAlertView *view = [[AuthSelectAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 350)];
        NSMutableArray *titleArray = [NSMutableArray array];
        for (AuthItemModel *item in model.tubotwelvedrillNc) {
            [titleArray addObject:item.uportwelvenNc?:@""];
        }
        view.itemArray = titleArray;
        view.tapItemBlk = ^(AuthItemModel * _Nonnull itemModel, NSInteger index) {
            model.selectedModel = model.tubotwelvedrillNc[index];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        };
        [view popAlertViewOnBottom];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf
    if (_index == 0) {
        AuthBankModel *model = _dataSource1[indexPath.row];
        if ([model isKindOfClass:[AuthBankModel class]]) {
            AuthBankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            
            cell.model = model;
            return cell;
        }
        AuthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.editCompletedBlk = ^(NSString * _Nonnull text) {
            AuthOptionalModel *option = (AuthOptionalModel *)model;
            option.valueStr = text;
        };
        cell.editValueChangeBlk = ^(NSString * _Nonnull text) {
            
        };
        cell.model = model;
        return cell;
    }
    
    AuthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    AuthSectionModel *temp = _dataSource2[indexPath.section];
    AuthOptionalModel *model = temp.xathtwelveosisNc[indexPath.row];
    cell.model = model;
    cell.tapItemBlk = ^(kAuthCellType type) {
        [weakSelf.view endEditing:YES];
        [weakSelf tapItemIndexPath:indexPath];
    };
    __weak AuthTableViewCell *weakCell = cell;
    cell.editCompletedBlk = ^(NSString * _Nonnull text) {
        model.valueStr = text;
    };
    cell.editValueChangeBlk = ^(NSString * _Nonnull text) {
        model.valueStr = text;
    };
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    kWeakSelf
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 110)];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(15, 0, view.width - 30, 110)];
    view3.backgroundColor = kWhiteColor;
    [view addSubview:view3];
    BankHeaderView *bankView = [[BankHeaderView alloc] initWithFrame:CGRectMake(0, 0, view3.width, 46)];
    bankView.tapIndex = ^(NSInteger index) {
        weakSelf.index = index;
        [tableView reloadData];
    };
    bankView.index = self.index;
    [view3 addSubview:bankView];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 46, view3.width - 30, 54)];
    [view3 addSubview:view2];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(14, (view2.height - 13) / 2.0, 3, 13)];
    lineView.backgroundColor = kBlueColor_0053FF;
    [view2 addSubview:lineView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (view2.height - 25) / 2.0, view2.width - 20, 25)];
    [view2 addSubview:titleLabel];
    
    if(self.index == 0) {
        titleLabel.text = @"Select your recipient E-wallet";
    }else
    {
        AuthSectionModel *model = _dataSource2[section];
        titleLabel.text = [NSString stringWithFormat:@"%@",model.fldgtwelveeNc];
    }
    [titleLabel pp_setPropertys:@[kBoldFontSize(18),kBlackColor_333333]];
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view3.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view3.bounds;
    maskLayer.path = path.CGPath;
    view3.layer.mask = maskLayer;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 0) {
        AuthBankModel *model = _dataSource1[indexPath.row];
        if ([model isKindOfClass:[AuthBankModel class]]) {
            for (AuthBankModel *temp in self.dataSource1) {
                if ([temp isKindOfClass:[AuthBankModel class]]) {
                    temp.isSelected = false;
                }
            }
            model.isSelected = true;
            [tableView reloadData];
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 120)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(15, 0, view.width - 30, view.height)];
    view2.backgroundColor = kWhiteColor;
    [view addSubview:view2];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, view2.width - 28, view2.height - 20)];
    [label pp_setPropertys:@[@"Please conhrm the account belongs to yourself and iscorrect, it will be used as a receipt account to receivethe funds",kFontSize(14),kGrayColor_999999]];
    label.numberOfLines = 0;
    [view2 addSubview:label];
    UIRectCorner corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view2.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view2.bounds;
    maskLayer.path = path.CGPath;
    view2.layer.mask = maskLayer;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 120;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_index == 0) {
        return _dataSource1.count;
    }
    AuthSectionModel *model = _dataSource2[section];
    return model.xathtwelveosisNc.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.index == 0) {
        return _dataSource1.count > 0 ? 1 : 0;
    }
    return _dataSource2.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index == 0) {
        AuthBankModel *model = _dataSource1[indexPath.row];
        return model.cellHeight;
    }
    AuthSectionModel *sectionModel = _dataSource2[indexPath.section];
    AuthOptionalModel *model = sectionModel.xathtwelveosisNc[indexPath.row];
    return model.cellHeight;
}
-(void)BASE_RequestHTTPInfo
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/card" paramsInfo:@{@"liettwelveusNc":[PLPDataManager manager].productId} successBlk:^(id  _Nonnull responseObject) {
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
        NSArray *array = data[@"abentwelvetlyNc"][@"unrdtwelveerlyNc"];
        NSDictionary *exist = data[@"abentwelvetlyNc"][@"koNctwelve"];
        NSInteger type = [exist[@"blthtwelveelyNc"] intValue];
        NSString *name = exist[@"ovrctwelveutNc"];
        for (NSDictionary *dic in array) {
            AuthBankModel *model = [AuthBankModel yy_modelWithDictionary:dic];
            if (model.regntwelveNc == type) {
                self.index = 0;
                model.isSelected = true;
            }
            model.cellHeight = 60;
            [self.dataSource1 addObject:model];
        }
        {
            AuthOptionalModel *model2 = [AuthOptionalModel new];
            model2.techtwelveedNc = 1;
            model2.fldgtwelveeNc = @"E-wallet Account";
            model2.orintwelvearilyNc = @"Enter the E-wallet account";
            model2.labelHeight = [model2.fldgtwelveeNc heightWithWidth:kScreenW - 30 - 28 font:kFontSize(16)];
            model2.isBankPage = true;
            if ([name isReal]) {
                model2.valueStr = name;
            }else
            {
                if ([[kMMKV getStringForKey:kPhoneKey] hasPrefix:@"0"]) {
                    model2.valueStr = [kMMKV getStringForKey:kPhoneKey];
                }else
                {
                    model2.valueStr = [NSString stringWithFormat:@"0%@",[kMMKV getStringForKey:kPhoneKey]];
                }
            }
            model2.cellHeight = model2.labelHeight + 50 + 16 + 7 + 20;
            model2.type = kAuthCellType_TextField;
            [self.dataSource1 addObject:model2];
        }
        NSArray *array2 = data[@"muratwelveyNc"][@"unrdtwelveerlyNc"];
        NSMutableArray *itemArray = [NSMutableArray array];
        {
            NSDictionary *exist = data[@"muratwelveyNc"][@"koNctwelve"];
            NSInteger type = [exist[@"blthtwelveelyNc"] intValue];
            NSString *name = exist[@"ovrctwelveutNc"];
            AuthSectionModel *sectionModel = [AuthSectionModel new];
            sectionModel.fldgtwelveeNc = @"Select Bank";
            AuthOptionalModel *model1 = [AuthOptionalModel new];
            for (NSDictionary *dic in array2) {
                AuthItemModel *itemModel = [AuthItemModel yy_modelWithDictionary:dic];
                if ([itemModel.regntwelveNc integerValue] == type) {
                    self.index = 1;
                    model1.selectedModel = itemModel;
                }
                [itemArray addObject:itemModel];
            }
            model1.fldgtwelveeNc = @"Bank";
            model1.orintwelvearilyNc = @"Choose your bank";
            CGFloat height = [model1.fldgtwelveeNc heightWithWidth:kScreenW - 30 - 28 font:kFontSize(16)];
            model1.labelHeight = height;
            model1.cellHeight = height + 50 + 16 + 7;
            model1.type = kAuthCellType_Select;
            model1.tubotwelvedrillNc = itemArray;
            
            AuthOptionalModel *model2 = [AuthOptionalModel new];
            model2.fldgtwelveeNc = @"Bank Account";
            model2.techtwelveedNc = 0;
            model2.orintwelvearilyNc = @"Enter the bank number";
            model2.labelHeight = [model2.fldgtwelveeNc heightWithWidth:kScreenW - 30 - 28 font:kFontSize(16)];
            if ([name isReal]) {
                model2.valueStr = name;
            }
            model2.cellHeight = [model2.fldgtwelveeNc heightWithWidth:kScreenW - 30 - 28 font:kFontSize(16)] + 50 + 16 + 7;
            model2.type = kAuthCellType_TextField;
            sectionModel.xathtwelveosisNc = @[model1, model2];
            [self.dataSource2 addObject:sectionModel];
            [self.tableView reloadData];
        }
        
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(void)BASE_GenerateSubview
{
    kWeakSelf
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0)];
    self.timerView = [[BasicTimerView alloc] initWithFrame:CGRectMake(15, 16 , kScreenW - 30, 114)];
    _timerView.timerFinishBlk = ^{
        [weakSelf timerFinish];
    };

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenW, kScreenH - kTopHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[AuthBankViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[AuthTableViewCell class] forCellReuseIdentifier:@"cell2"];
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
    
    self.tableView.tableHeaderView = [UIView new];
}
-(NSMutableArray *)dataSource1
{
    if (!_dataSource1) {
        _dataSource1 = [NSMutableArray array];
    }
    return _dataSource1;
}
-(NSMutableArray *)dataSource2
{
    if(!_dataSource2) {
        _dataSource2 = [NSMutableArray array];
    }
    return _dataSource2;
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
