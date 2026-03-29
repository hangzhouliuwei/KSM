//
//  InformationPagePPNormalCard.m
// FIexiLend
//
//  Created by jacky on 2024/11/15.
//

#import "InformationPagePPNormalCard.h"
#import "PPNormalCardInputCell.h"
#import "IQKeyboardManager.h"
#import "PPIconTitleButtonView.h"
#import "PPUserTopViewTimeView.h"

#import "PPUserDefaultViewInfoCell.h"

#import "PPNormalCardInfoAlert.h"
#import "DayPPNormalCardAlert.h"

@interface InformationPagePPNormalCard () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIView *emailTypeViewConfigHelper;

@property (nonatomic, copy) NSMutableArray *configHelperDataItemList;
@property (nonatomic, strong) NSMutableDictionary *needSaveDicData;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PPNormalCardInfoAlert *alert;
@property (nonatomic, assign) CGFloat emailY;

@property (nonatomic, strong) PPUserTopViewTimeView *timeView;
@property (nonatomic, assign) NSInteger countdown;
@property (nonatomic, assign) BOOL cantoFolderIsExtend;
@end

@implementation InformationPagePPNormalCard

- (id)init{
    self = [super init];
    if (self) {
        self.naviBarHidden = YES;
    }
    return self;
}

- (void)requestInfoData {
    NSDictionary *dic = @{
        p_product_id: self.productId,
        @"rshydrobromideCiopjko":@"stauistill"
    };
    kWeakself;
    [Http post:R_personal_info params:dic success:^(Response *response) {
        if (response.success) {
            weakSelf.configHelperDataItemList = [NSMutableArray arrayWithArray:response.dataDic[p_items]];
            weakSelf.countdown = [response.dataDic[p_countdown] integerValue];
            [weakSelf loadUI];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"======faild!");
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:130];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:10];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    if (!self.canDiss) {
        return;
    }
    UINavigationController *navigationController = self.navigationController;
    if (navigationController && ![navigationController.viewControllers containsObject:self]) {
        return;
    }
    
    if (navigationController) {
        NSMutableArray *viewControllers = [navigationController.viewControllers mutableCopy];
        [viewControllers removeObject:self];
        navigationController.viewControllers = [viewControllers copy];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.step = 0;
    self.cantoFolderIsExtend = NO;
    self.needSaveDicData = [NSMutableDictionary dictionary];
    self.emailY = 0;
    self.content.delegate = self;
    self.content.backgroundColor = BGColor;

    [self.content addSubview:self.tableView];
    [self requestInfoData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        self.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SafeWidth, NavBarHeight + 64)];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.scrollEnabled = NO;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.backgroundColor = BGColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = UIColor.clearColor;

        _tableView.rowHeight = 44;
        _tableView.tableHeaderView = self.header;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _tableView;
}

- (void)refershHeader {
    [self.header removeAllViews];
    
    UIView *headerBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavBarHeight + 64)];
    headerBg.backgroundColor = MainColor;
    [headerBg showPPReallyRadiusBottom:16];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, NavBarHeight, ScreenWidth, 64)];
    image.image = ImageWithName(@"header_step1");
    [headerBg addSubview:image];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, StatusBarHeight, 48, 44);
    [backBtn setImage:ImageWithName(@"page_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerBg addSubview:backBtn];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin + 44, StatusBarHeight, SafeWidth - 44*2, 44)];
    titleView.text = @"Basic";
    titleView.textColor = UIColor.whiteColor;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = FontCustom(16);

    [headerBg addSubview:titleView];
    if (self.countdown == 0) {
        self.timeView.hidden = YES;
        self.header.h = NavBarHeight + 64;
    }else {
        [self.header addSubview:self.timeView];
        self.timeView.hidden = NO;
        self.header.h = NavBarHeight + 64 + 40;
    }
    [self.header addSubview:headerBg];
    [self.tableView reloadData];
}


- (void)loadUI {
    if (self.countdown > 0) {
        [self.timeView start:self.countdown];
    }
    
    CGFloat heitht = self.header.h;
    for (NSDictionary *info in self.configHelperDataItemList) {
        NSArray *itemArr = info[p_list];
        heitht = heitht + 38;
        for (int i = 0; i < itemArr.count; i++) {
            heitht = heitht + 44;
            NSDictionary *dic = itemArr[i];
            NSString *value = dic[p_value];
            NSString *code = dic[p_code];

            self.needSaveDicData[code] = notNull(value);
            if ([code isEqualToString:@"email"]) {
                self.emailY = heitht + 44;
            }
        }
    }
    
    self.tableView.h = heitht + SafeBottomHeight + 60 + (StatusBarHeight > 20 ? 0 : 80);
    self.content.contentSize = CGSizeMake(ScreenWidth, self.tableView.bottom + SafeBottomHeight + 70);
    [self refershHeader];
    
    UIButton *next = [PPKingHotConfigView normalBtn:CGRectMake(34, self.view.h - SafeBottomHeight - 60, ScreenWidth - 68, 48) title:@"Next" font:24];
    [next showBottomShadow:COLORA(0, 0, 0, 0.2)];
    [next addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextAction)]];
    [self.view addSubview:next];
        
    if (self.emailY > 0) {
        _emailTypeViewConfigHelper = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, self.emailY, SafeWidth, 4*30)];
        _emailTypeViewConfigHelper.hidden = YES;
        _emailTypeViewConfigHelper.backgroundColor = UIColor.whiteColor;
        [_emailTypeViewConfigHelper showAddToRadius:8];
        [_emailTypeViewConfigHelper ppAddViewToshowShadow:LineGrayColor];
        [self.content addSubview:_emailTypeViewConfigHelper];
    }
}

- (void)nextAction {
    for (NSDictionary *info in _configHelperDataItemList) {
        NSArray *itemArr = info[p_list];
        for (int i = 0; i < itemArr.count; i++) {
            NSDictionary *dic = itemArr[i];
            NSString *codeString = dic[p_code];
            NSString *titleString = dic[p_title];
            NSString *valueStr = self.needSaveDicData[codeString];
            NSInteger optionalStr = [dic[p_optional] integerValue];

            NSString *cate = dic[p_cate];
            if (isBlankStr(valueStr) && optionalStr == 0) {
                if ([cate isEqualToString:@"enum"] || [cate isEqualToString:@"day"]) {
                    [PPMiddleCenterToastView show:StrFormat(@"Please Select %@", titleString)];
                }else {
                    [PPMiddleCenterToastView show:StrFormat(@"Please Enter %@", titleString)];
                }
                return;
            }
        }
    }
    [self saveData];

}

- (void)saveData {
    self.needSaveDicData[p_product_id] = notNull(self.productId);
    self.needSaveDicData[p_point] = [self track];

    kWeakself;
    [Http post:R_save_personal_info params:self.needSaveDicData success:^(Response *response) {
        if (response.success) {
            weakSelf.canDiss = YES;
            [Route ppTextjumpToWithProdutId:weakSelf.productId];
        }else {
            [PPMiddleCenterToastView show:response.msg];
        }
    } failure:^(NSError *error) {

    } showLoading:YES];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    _emailTypeViewConfigHelper.hidden = YES;
}

- (PPUserTopViewTimeView*)timeView {
    if(!_timeView) {
        kWeakself;
        _timeView = [[PPUserTopViewTimeView alloc] initWithFrame:CGRectMake(0, NavBarHeight + 64 - 20, ScreenWidth, 60)];
        _timeView.finishBlock = ^{
            weakSelf.countdown = 0;
            weakSelf.emailTypeViewConfigHelper.y = weakSelf.emailY - 44;
            [weakSelf refershHeader];
        };
        [_timeView showPPReallyRadiusBottom:16];
        [_timeView ppConfigAddViewShadow];
    }
    return _timeView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _configHelperDataItemList[indexPath.section][p_list][indexPath.row];
    NSString *cate = dic[p_cate];
    if ([cate isEqualToString:p_enum] || [cate isEqualToString:p_day]) {
        NSString *cellID = StrFormat(@"SelctCell%@", @(indexPath.section*100 + indexPath.row));
        PPUserDefaultViewInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[PPUserDefaultViewInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.needSaveDicData = self.needSaveDicData;
        [cell loadData:dic];
        return cell;
    }else {
        NSString *cellID = StrFormat(@"InputCell%@", @(indexPath.section*100 + indexPath.row));
        PPNormalCardInputCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[PPNormalCardInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.needSaveDicData = self.needSaveDicData;
        NSString *code = dic[p_code];
        if ([code isEqualToString:@"email"]) {
            cell.emailView = _emailTypeViewConfigHelper;
        }
        [cell loadData:dic];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    NSDictionary *cellDic = _configHelperDataItemList[indexPath.section][p_list][indexPath.row];
    NSString *cate = cellDic[p_cate];
    NSString *code = cellDic[p_code];
    if ([cate isEqualToString:p_txt]) {
        return;
    }
    kWeakself;
    if ([cate isEqualToString:p_enum]) {
        NSString *title = notNull(cellDic[p_title]);
        NSArray *noteList = cellDic[p_note];
        PPNormalCardInfoAlert *alert = [[PPNormalCardInfoAlert alloc] initWithData:noteList selected:[_needSaveDicData[code] stringValue] title:title];
        alert.selectBlock = ^(NSDictionary *dic) {
            UITableViewCell *cellTmp = [tableView cellForRowAtIndexPath:indexPath];
            PPUserDefaultViewInfoCell *cell = (PPUserDefaultViewInfoCell *)cellTmp;
            cell.text.text = notNull([dic[p_name] stringValue]);
            weakSelf.needSaveDicData[code] = notNull([dic[p_type] stringValue]);

            NSInteger currentSection = indexPath.section;
            NSInteger currentRow = indexPath.row;
            NSIndexPath *nextPath;
            if ((currentRow + 1) < [tableView numberOfRowsInSection:currentSection]) {
                nextPath = [NSIndexPath indexPathForRow:(currentRow + 1) inSection:currentSection];
            }else {
                nextPath = [NSIndexPath indexPathForRow:0 inSection:currentSection + 1];
            }
            if ((currentSection + 1) < [tableView numberOfSections] && ([tableView numberOfRowsInSection:currentSection] > 0)) {
                NSDictionary *nextDic = weakSelf.configHelperDataItemList[nextPath.section][p_list][nextPath.row];
                NSString *code = nextDic[p_code];
                NSString *value = [weakSelf.needSaveDicData[code] stringValue];
                if (value.length == 0) {
                    [weakSelf tableView:tableView didSelectRowAtIndexPath:nextPath];
                }
            }
        };
        [alert show];
    }else if ([cate isEqualToString:p_day]) {
        NSString *date = @"";
        NSString *selectDate = self.needSaveDicData[code];
        if (selectDate.length > 0) {
            date = selectDate;
        }else {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat: @"dd-MM-yyyy"];
            date = [dateFormatter stringFromDate:[NSDate date]];
        }
        DayPPNormalCardAlert *alert = [[DayPPNormalCardAlert alloc] initWithData:date title:cellDic[p_title]];
        alert.selectBlock = ^(NSString *str) {
            UITableViewCell *cellTmp = [tableView cellForRowAtIndexPath:indexPath];
            PPUserDefaultViewInfoCell *cell = (PPUserDefaultViewInfoCell *)cellTmp;
            weakSelf.needSaveDicData[code] = str;
            cell.text.text = notNull(str);
            NSInteger currentSection = indexPath.section;
            NSInteger currentRow = indexPath.row;
            NSIndexPath *nextPath;
            if ((currentRow + 1) < [tableView numberOfRowsInSection:currentSection]) {
                nextPath = [NSIndexPath indexPathForRow:(currentRow + 1) inSection:currentSection];
            }else {
                nextPath = [NSIndexPath indexPathForRow:0 inSection:currentSection + 1];
            }
            if ((currentSection + 1) < [tableView numberOfSections] && ([tableView numberOfRowsInSection:currentSection] > 0)) {
                NSDictionary *nextDic = weakSelf.configHelperDataItemList[nextPath.section][p_list][nextPath.row];
                NSString *code = nextDic[p_code];
                NSString *value = [weakSelf.needSaveDicData[code] stringValue];
                if (value.length == 0) {
                    [weakSelf tableView:tableView didSelectRowAtIndexPath:nextPath];
                }
            }
        };
        [alert show];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDictionary *dic = _configHelperDataItemList[section];
    BOOL isMore = [dic[@"more"] boolValue];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 38)];
    title.text = notNull(dic[p_title]);
    title.textColor = TextBlackColor;
    title.font = FontBold(14);
    title.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:title];

    if (isMore) {
        headerView.h = 82;
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 38, ScreenWidth, 44)];
        bg.backgroundColor = UIColor.whiteColor;
        [headerView addSubview:bg];

        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, 38, SafeWidth, 40)];
        desc.text = notNull(dic[p_sub_title]);
        desc.textColor = TextBlackColor;
        desc.font = Font(12);
        [headerView addSubview:desc];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, headerView.h - 4, SafeWidth, 1)];
        line.backgroundColor = LineGrayColor;
        [headerView addSubview:line];
        
        UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
        more.titleLabel.font = FontBold(14);
        more.frame = CGRectMake(ScreenWidth - LeftMargin - 50, 38, 50, 40);
        [more setTitleColor:MainColor forState:UIControlStateNormal];
        [more setTitle:@"Hide" forState:UIControlStateSelected];
        [more setTitle:@"More" forState:UIControlStateNormal];
        more.selected = _cantoFolderIsExtend;
        [more addTarget:self action:@selector(hideClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:more];


    }
    return headerView;
}

- (void)hideClick:(UIButton *)sender {
    _cantoFolderIsExtend = !_cantoFolderIsExtend;
    sender.selected = _cantoFolderIsExtend;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = _configHelperDataItemList[section];
    NSArray *itemList = dic[p_list];

    BOOL isMore = [dic[@"more"] boolValue];
    if (isMore && !_cantoFolderIsExtend) {
        return 0;
    }
    return itemList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _configHelperDataItemList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < _configHelperDataItemList.count - 1) {
        return 38;
    }else {
        return 82;
    }
}



@end
