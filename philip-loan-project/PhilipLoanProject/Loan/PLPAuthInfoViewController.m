//
//  AuthInfoViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/3.
//

#import "PLPAuthInfoViewController.h"
#import "BasicHeadView.h"
#import "BasicTimerView.h"
#import "AuthTableViewCell.h"
#import "AuthSelectAlertView.h"
#import "AuthDateAlertView.h"
@interface PLPAuthInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic)NSMutableArray *dataSource;

@property(nonatomic)UIView *headerView;
@property(nonatomic)BasicHeadView *progressView;
@property(nonatomic)BasicTimerView *timerView;

@end

@implementation PLPAuthInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.baseImageView removeFromSuperview];
    self.navigationItem.title = @"Basic";
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
    self.holdConetent = @"Complete the form to apply for a loan, andwe'll tailor a loan amount just for you.";
    self.shouldPopHome = true;
}
-(void)plp_generateSubview
{
    kWeakSelf
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0)];
    BasicHeadView *progressView = [[BasicHeadView alloc] initWithFrame:CGRectMake(15, 16, _headerView.width - 2 * 15, 85) index:0];
    self.progressView = progressView;
    [_headerView addSubview:progressView];
    self.timerView = [[BasicTimerView alloc] initWithFrame:CGRectMake(15, 16 + progressView.bottom, progressView.width, 114)];
    _timerView.timerFinishBlk = ^{
        [weakSelf timerFinish];
    };
//    _headerView.backgroundColor = UIColor.redColor;
    _headerView.height = progressView.bottom + 12;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenW, kScreenH - kTopHeight - kBottomSafeHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[AuthTableViewCell class] forCellReuseIdentifier:@"cell"];
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
-(void)handleNextButtonAction:(UIButton *)button
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (AuthSectionModel *sectionModel in self.dataSource) {
        for (AuthOptionalModel *optionalModel in sectionModel.xathtwelveosisNc) {
            if (!optionalModel.selectedModel && optionalModel.valueStr.length == 0 && ![sectionModel.fldgtwelveeNc isEqualToString:@"Optional"]) {
                kPLPPopInfoWithStr(optionalModel.orintwelvearilyNc);
                return;
            }
            if (optionalModel.selectedModel) {
                dic[optionalModel.imeatwelvesurabilityNc] = optionalModel.selectedModel.itlitwelveanizeNc;
            }
            if (optionalModel.valueStr.length > 0) {
                dic[optionalModel.imeatwelvesurabilityNc] = optionalModel.valueStr;
            }
        }
    }
    dic[@"liettwelveusNc"] = [PLPDataManager manager].productId;
    dic[@"point"] = [self BASE_GeneragePointDictionaryWithType:@"22"];
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/person_next" paramsInfo:dic successBlk:^(id  _Nonnull responseObject) {
        NSDictionary *data = responseObject[@"viustwelveNc"][@"deectwelvetibleNc"];
        [self decodeAuthResponseData:data];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(void)tapItemType:(kAuthCellType)type indexPath:(NSIndexPath *)indexPath
{
    kWeakSelf
    AuthTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    AuthSectionModel *temp = _dataSource[indexPath.section];
    AuthOptionalModel *model = temp.xathtwelveosisNc[indexPath.row];
    if (type == kAuthCellType_Select) {
        AuthSelectAlertView *view = [[AuthSelectAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 350)];
        view.model = model;
        view.tapItemBlk = ^(AuthItemModel * _Nonnull itemModel, NSInteger index) {
            model.selectedModel = itemModel;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self startNextActionWithIndexPath:indexPath];
        };
        [view popAlertViewOnBottom];
        
    }else if (type == kAuthCellType_Date) {
        AuthDateAlertView *view = [[AuthDateAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 350)];
        view.model = model;
        view.tapItemBlk = ^(NSString * _Nonnull date) {
            model.valueStr = date;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self startNextActionWithIndexPath:indexPath];
        };
        [view popAlertViewOnBottom];
    }else if (type == kAuthCellType_Email) {
        model.showEmail = YES;
        [cell.textField becomeFirstResponder];
    }else if (type == kAuthCellType_TextField) {
        [cell.textField becomeFirstResponder];
    }
}


-(void)startNextActionWithIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *nextIndexPath = [self getNextIndexPath:indexPath];
    AuthSectionModel *nextSectionModel = self.dataSource[nextIndexPath.section];
    AuthOptionalModel *nextOptionModel = nextSectionModel.xathtwelveosisNc[nextIndexPath.row];
    if (nextIndexPath) {
        [self.tableView scrollToRowAtIndexPath:nextIndexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
        if (nextOptionModel.type == kAuthCellType_Email || nextOptionModel.type == kAuthCellType_TextField) {
            AuthTableViewCell *cell = [_tableView cellForRowAtIndexPath:nextIndexPath];
            [cell.textField becomeFirstResponder];
        }else
        {
            [self tapItemType:nextOptionModel.type indexPath:nextIndexPath];
        }
    }
}
#pragma mark - UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf
    AuthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AuthSectionModel *temp = _dataSource[indexPath.section];
    AuthOptionalModel *model = temp.xathtwelveosisNc[indexPath.row];
    cell.model = model;
    cell.tapItemBlk = ^(kAuthCellType type) {
        [weakSelf.view endEditing:YES];
        [weakSelf tapItemType:type indexPath:indexPath];
    };
    __weak AuthTableViewCell *weakCell = cell;
    cell.editCompletedBlk = ^(NSString * _Nonnull text) {
        model.valueStr = text;
        if (model.type == kAuthCellType_Email) {
            model.showEmail = false;
            [tableView beginUpdates];
            weakCell.model = model;
            [tableView endUpdates];
        }
        [weakSelf startNextActionWithIndexPath:indexPath];
    };
    cell.editValueChangeBlk = ^(NSString * _Nonnull text) {
        if (model.type == kAuthCellType_Email) {
            model.valueStr = text;
            [tableView beginUpdates];
            weakCell.model = model;
            [tableView endUpdates];
            if (model.valueStr.length == 1) {
                [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
            }
        }
    };
    cell.emailView.tapItemBlk = ^(NSString * _Nonnull emailAddress) {
        weakCell.textField.text = emailAddress;
        model.valueStr = emailAddress;
        [weakCell.textField endEditing:YES];
    };
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AuthSectionModel *model = _dataSource[section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, model.more ? 98 : 54)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(15, 0, view.width - 30, view.height)];
    view2.backgroundColor = kWhiteColor;
    [view addSubview:view2];
    
    if (model.more) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(view2.width - 60 - 10, 23, 60, 40);
        [button setTitle:@"More" forState:UIControlStateNormal];
        [button setTitleColor:kBlackColor_333333 forState:UIControlStateNormal];
        [button setImage:kImageName(@"auth_base_arrow_down") forState:UIControlStateNormal];
        [button setImage:kImageName(@"auth_base_arrow_up") forState:UIControlStateSelected];
        button.tag = 100 + section;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        CGFloat spacing = 2.0;
        CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
        CGSize imageSize = button.imageView.frame.size;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width - spacing, 0, imageSize.width);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + spacing, 0, -titleSize.width);
        [button addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.selected = model.currentStatus;
        [view2 addSubview:button];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(14, 23, 3, 13)];
    lineView.backgroundColor = kBlueColor_0053FF;
    [view2 addSubview:lineView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 16, view2.width - 20, 25)];
    [view2 addSubview:titleLabel];
    
    titleLabel.text = [NSString stringWithFormat:@"%@",model.fldgtwelveeNc];
    [titleLabel pp_setPropertys:@[kBoldFontSize(18),kBlackColor_333333]];
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    if (model.more && !model.currentStatus) {
        corners = UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight;
    }
    
    if (model.more) {
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, titleLabel.bottom + 12, view2.width - 2 * 14, 18)];
        [tipLabel pp_setPropertys:@[kFontSize(16),model.sub_title,kGrayColor_999999]];
        [view2 addSubview:tipLabel];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view2.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view2.bounds;
    maskLayer.path = path.CGPath;
    view2.layer.mask = maskLayer;
    return view;
}
-(void)moreButtonAction:(UIButton *)button
{
    NSInteger index = button.tag - 100;
    AuthSectionModel *model = _dataSource[index];
    model.currentStatus = !model.currentStatus;
    button.selected = model.currentStatus;
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    AuthSectionModel *model = _dataSource[section];
    if(model.more) {
        return 98;
    }
    return 54;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 12)];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 12;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AuthSectionModel *model = _dataSource[section];
    if (model.more) {
        if (model.currentStatus) {
            return model.xathtwelveosisNc.count;
        }
        return 0;
    }
    return model.xathtwelveosisNc.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuthSectionModel *sectionModel = _dataSource[indexPath.section];
    AuthOptionalModel *model = sectionModel.xathtwelveosisNc[indexPath.row];
    if (model.showEmail) {
        return model.cellHeightEmail;
    }
    return model.cellHeight;
}
-(void)BASE_RequestHTTPInfo
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"ph/v2/certify/basic-info" paramsInfo:@{@"liettwelveusNc":[PLPDataManager manager].productId,@"bunatwelvebleNc":@"stauistill"} successBlk:^(id  _Nonnull responseObject) {
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
            AuthSectionModel *model = [AuthSectionModel yy_modelWithDictionary:dic];
            for (int i = 0; i < model.xathtwelveosisNc.count; i++) {
                AuthOptionalModel *temp = model.xathtwelveosisNc[i];
                CGFloat height = [temp.fldgtwelveeNc heightWithWidth:kScreenW - 30 - 28 font:kFontSize(16)];
                temp.labelHeight = height;
                temp.cellHeight = height + 50 + 16 + 7;
                NSString *cellType = temp.lebotwelveardNc;
                if ([cellType isEqualToString:@"AATWELVEBF"]) {
                    temp.type = kAuthCellType_Select;
                }else if ([cellType isEqualToString:@"AATWELVEBG"]) {
                    if ([temp.fldgtwelveeNc.uppercaseString isEqualToString:@"EMAIL"]) {
                        temp.type = kAuthCellType_Email;
                        temp.cellHeightEmail = height + 50 + 16 + 7 + 150 + 5 * 2;
                    }else
                    {
                        temp.type = kAuthCellType_TextField;
                    }
                }else if ([cellType isEqualToString:@"AATWELVEBJ"]) {
                    temp.type = kAuthCellType_Date;
                }
                if (i == model.xathtwelveosisNc.count - 1) {
                    temp.needClip = true;
                }
                if ([temp.darytwelvemanNc isReal]) {
                    if (temp.type == kAuthCellType_Select) {
                        for (AuthItemModel *item in temp.tubotwelvedrillNc) {
                            if ([item.itlitwelveanizeNc isEqualToString:temp.darytwelvemanNc]) {
                                temp.selectedModel = item;
                            }
                        }
                    }else
                    {
                        temp.valueStr = temp.darytwelvemanNc;
                    }
                }
            }
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(void)timerFinish
{
    [self.timerView removeFromSuperview];
    self.headerView.height = self.progressView.bottom + 12;
    self.tableView.tableHeaderView = _headerView;
}
-(NSIndexPath *)getNextIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = 0,section = indexPath.section;
    AuthSectionModel *model = self.dataSource[indexPath.section];
    if (indexPath.row < model.xathtwelveosisNc.count - 1) {
        row = indexPath.row + 1;
        section = indexPath.section;
        AuthOptionalModel *optionalModel = model.xathtwelveosisNc[row];
        if (optionalModel.type == kAuthCellType_Select || optionalModel.type == kAuthCellType_Date) {
            if (!optionalModel.selectedModel && optionalModel.valueStr.length == 0) {
                return [NSIndexPath indexPathForRow:row inSection:section];
            }
            return [self getNextIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        }
    }
    return nil;
    
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
