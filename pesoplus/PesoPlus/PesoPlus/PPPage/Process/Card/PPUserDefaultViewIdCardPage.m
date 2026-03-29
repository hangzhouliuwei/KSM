//
//  PPUserDefaultViewIdCardPage.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "PPUserDefaultViewIdCardPage.h"
#import "PPHaussKingPictureTools.h"
#import "DayPPNormalCardAlert.h"
#import "PPUserTopViewTimeView.h"
#import "PPNormalCardInfoAlert.h"
#import "PPUserDefaultViewInfoCell.h"
#import "PPNormalCardGenderCell.h"
#import "PPNormalCardInputCell.h"
#import "PPUserDefaultViewIdCardAlert.h"

#import "PPIconTitleButtonView.h"

@interface PPUserDefaultViewIdCardPage () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) PPHaussKingPictureTools *infopictureToolConfigHelper;
@property (nonatomic, strong) UIView *infoBgViewCardImagView;
@property (nonatomic, strong) NSMutableDictionary *needSaveDicData;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, assign) NSInteger selectCardToOtherValue;
@property (nonatomic, strong) UIImage *ppCongHandleselectedImage;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *dataArr;

@property (nonatomic, strong) UIButton *nextItemConfigToGoButton;
@property (nonatomic, strong) PPIconTitleButtonView *typeInfomationViewToItems;
@property (nonatomic, strong) UIButton *photo;
@property (nonatomic, strong) PPUserDefaultViewIdCardAlert *cardAlert;

@property (nonatomic, strong) PPNormalCardInfoAlert *alert;

@property (nonatomic, strong) NSMutableDictionary *cardDic;
@property (nonatomic, copy) NSArray *itemArr;
@property (nonatomic, assign) NSInteger countdown;
@property (nonatomic, assign) BOOL didCanMoveToTheIdCardImageUpload;
@property (nonatomic, strong) PPUserTopViewTimeView *timeView;

@end

@implementation PPUserDefaultViewIdCardPage

- (id)init{
    self = [super init];
    if (self) {
        self.naviBarHidden = YES;
    }
    return self;
}


- (void)loadData {
    NSDictionary *dic = @{
        p_product_id: self.productId,
    };
    kWeakself;
    [Http post:R_id_card params:dic success:^(Response *response) {
        if (response.success) {
            weakSelf.cardDic = response.dataDic[p_card_first];
            weakSelf.dataArr = response.dataDic[p_card_first][p_note];
            weakSelf.countdown = [response.dataDic[p_countdown] integerValue];
            [weakSelf loadUI];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"======faild!");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.step = 2;
    self.selectCardToOtherValue = -1;
    self.content.backgroundColor = BGColor;
    self.needSaveDicData = [NSMutableDictionary dictionary];
}

- (void)loadView {
    [super loadView];
    [self loadData];
}

- (void)loadUI {
//    self.countdown = 10;
    if (self.countdown > 0) {
        [self.timeView start:self.countdown];
    }
    
    [self refershHeader];


    _infoBgViewCardImagView = [[UIView alloc] initWithFrame:CGRectMake(0, self.header.bottom, ScreenWidth, 130 + 160*WS)];
    _infoBgViewCardImagView.backgroundColor = UIColor.whiteColor;
    [self.content addSubview:_infoBgViewCardImagView];
    
    self.tableView.y = _infoBgViewCardImagView.bottom;
    
    [self.content addSubview:self.tableView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 38)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = rgba(236, 245, 255, 1);

    titleLabel.textColor = TextBlackColor;
    titleLabel.text = @"Upload your ID";

    titleLabel.font = FontBold(14);
    [_infoBgViewCardImagView addSubview:titleLabel];
    
    UILabel *typeDesclabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, titleLabel.bottom, SafeWidth, 40)];
    typeDesclabel.text = @"Select ID Type";
    typeDesclabel.textColor = TextBlackColor;
    typeDesclabel.font = Font(12);
    [_infoBgViewCardImagView addSubview:typeDesclabel];
    
    _typeInfomationViewToItems = [[PPIconTitleButtonView alloc] initWithFrame:CGRectMake(LeftMargin, typeDesclabel.y, SafeWidth, 40) title:@"Please Select" color:rgba(187, 187, 187, 1) font:12 icon:@"arrow_bot"];
    _typeInfomationViewToItems.type = HaoBtnType4;
    [_typeInfomationViewToItems addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [_infoBgViewCardImagView addSubview:_typeInfomationViewToItems];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(16, typeDesclabel.bottom, ScreenWidth - 32, 0.8)];
    line.backgroundColor = rgba(187, 187, 187, 1);
    [_infoBgViewCardImagView addSubview:line];
        
    _photo = [UIButton buttonWithType:UIButtonTypeCustom];
    _photo.frame = CGRectMake(58, line.bottom + 25, 260*WS, 161*WS);
    [_photo setImage:ImageWithName(@"take_photo") forState:UIControlStateNormal];
    [_photo setBackgroundImage:ImageWithName(@"picture_default") forState:UIControlStateNormal];
    [_photo addTarget:self action:@selector(photoAction) forControlEvents:UIControlEventTouchUpInside];
    [_infoBgViewCardImagView addSubview:_photo];
    
    _nextItemConfigToGoButton = [PPKingHotConfigView normalBtn:CGRectMake(34, self.view.h - SafeBottomHeight - 60, ScreenWidth - 68, 48) title:@"Next" font:24];
    [_nextItemConfigToGoButton showBottomShadow:COLORA(0, 0, 0, 0.2)];
    [_nextItemConfigToGoButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextAction)]];
    _nextItemConfigToGoButton.hidden = YES;
    [self.view addSubview:_nextItemConfigToGoButton];
    
    NSString *url = _cardDic[p_url];
    self.needSaveDicData[p_url] = url;
    self.needSaveDicData[p_value] = _cardDic[p_value];
    
    _selectCardToOtherValue = [_cardDic[p_id_type] integerValue];
    self.needSaveDicData[p_id_type] = StrValue(_selectCardToOtherValue);
    if (url.length > 0) {
        [_photo sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
        _nextItemConfigToGoButton.hidden = NO;
    }
    _itemArr = _cardDic[p_list];
    for (int i = 0; i < _itemArr.count; i++) {
        NSDictionary *dic = _itemArr[i];
        NSString *code = dic[p_code];
        NSString *value = [dic[p_value] stringValue];
        self.needSaveDicData[code] = notNull(value);
    }
    
    for (int i = 0; i < _dataArr.count; i++) {
        NSDictionary *dic = _dataArr[i];
        NSInteger type = [dic[p_card_type] integerValue];
        NSString *value = dic[p_card_title];
        if (_selectCardToOtherValue == type) {
            [_typeInfomationViewToItems setTitle:notNull(value) forState:UIControlStateNormal];
            [_typeInfomationViewToItems setTitleColor:TextBlackColor forState:UIControlStateNormal];
        }
    }
    self.tableView.h =  (_itemArr.count + 2)*50;
    self.content.contentSize = CGSizeMake(ScreenWidth, self.tableView.bottom + SafeBottomHeight + 70);
    [self.tableView reloadData];


    if (_itemArr.count > 0) {
        _didCanMoveToTheIdCardImageUpload = YES;
    }
    
    if (_selectCardToOtherValue <= 0) {
        [self selectAction];
    }
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _infoBgViewCardImagView.bottom + 20, ScreenWidth, 100) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BGColor;

        _tableView.separatorColor = UIColor.clearColor;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _tableView;
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


- (void)nextAction {
    NSString *idCardId =  _needSaveDicData[p_value];
    if (isBlankStr(idCardId)) {
        return;
    }
    
    [Track uploadDevice:^(BOOL value) {
    }];
    
    for (int i = 0; i < _itemArr.count; i++) {
        NSDictionary *dicInfomation = _itemArr[i];
        NSString *codestr = dicInfomation[p_code];
        NSString *titlestring = dicInfomation[p_title];
        NSString *catestring = dicInfomation[p_cate];
        NSInteger optionalstr = [dicInfomation[p_optional] integerValue];
        NSString *valuestring = self.needSaveDicData[codestr];

        if (isBlankStr(valuestring) && optionalstr == 0) {
            if ([catestring isEqualToString:p_option]) {
                [PPMiddleCenterToastView show:StrFormat(@"Please select %@", titlestring)];
            }else {
                [PPMiddleCenterToastView show:StrFormat(@"Please enter %@", titlestring)];
            }
            return;
        }
    }
    
    self.needSaveDicData[p_ocr_relation_id] = self.needSaveDicData[p_value];
    self.needSaveDicData[p_product_id] = notNull(self.productId);
    self.needSaveDicData[p_point] = [self track];

    kWeakself;
    [Http post:R_save_id_card params:self.needSaveDicData success:^(Response *response) {
        if (response.success) {
            weakSelf.canDiss = YES;
            [Route ppTextjumpToWithProdutId:weakSelf.productId];
        }else {
            [PPMiddleCenterToastView show:response.msg];
        }
    } failure:^(NSError *error) {

    } showLoading:YES];
}

- (void)refershHeader {
    [self.header removeAllViews];
    self.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SafeWidth, NavBarHeight + 64)];
    [self.content addSubview:self.header];
    
    UIView *headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavBarHeight + 64)];
    headerBgView.backgroundColor = MainColor;
    [headerBgView showPPReallyRadiusBottom:16];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NavBarHeight, ScreenWidth, 64)];
    headImageView.image = ImageWithName(@"header_step3");
    [headerBgView addSubview:headImageView];
    
    UIButton *backBtnItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtnItem.frame = CGRectMake(0, StatusBarHeight, 48, 44);
    [backBtnItem setImage:ImageWithName(@"page_back") forState:UIControlStateNormal];
    [backBtnItem addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerBgView addSubview:backBtnItem];
    
    UILabel *titleViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin + 44, StatusBarHeight, SafeWidth - 44*2, 44)];
    titleViewLabel.text = @"Identification";
    titleViewLabel.textColor = UIColor.whiteColor;
    titleViewLabel.textAlignment = NSTextAlignmentCenter;
    [headerBgView addSubview:titleViewLabel];
    titleViewLabel.font = FontCustom(16);

    if (self.countdown == 0) {
        self.timeView.hidden = YES;
        self.header.h = NavBarHeight + 64;
    }else {
        [self.header addSubview:self.timeView];
        self.timeView.hidden = NO;
        self.header.h = NavBarHeight + 64 + 40;
    }
    [self.header addSubview:headerBgView];
    [self.tableView reloadData];
}

- (void)refreshUI {
    for (int i = 0; i < _itemArr.count; i++) {
        NSDictionary *dic = _itemArr[i];
        NSString *code = dic[p_code];
        NSString *value = [dic[p_value] stringValue];
        self.needSaveDicData[code] = notNull(value);
    }
    self.tableView.h =  (_itemArr.count + 2)*50;
    self.content.contentSize = CGSizeMake(ScreenWidth, self.tableView.bottom + SafeBottomHeight + 70);
    [self.tableView reloadData];
    _nextItemConfigToGoButton.hidden = NO;
}

- (void)selectAction {
    if (_didCanMoveToTheIdCardImageUpload) {
        return;
    }
    _cardAlert = [[PPUserDefaultViewIdCardAlert alloc] initWithData:_dataArr selected:StrValue(_selectCardToOtherValue) title:@"Please select"];
    kWeakself;
    _cardAlert.selectBlock = ^(NSDictionary *dic) {
        [weakSelf selectType:dic];
    };
    [_cardAlert show];
}

- (void)selectType:(NSDictionary *)dic {
    [_typeInfomationViewToItems setTitle:notNull(dic[p_card_title]) forState:UIControlStateNormal];
    [_typeInfomationViewToItems setTitleColor:TextBlackColor forState:UIControlStateNormal];
    [_photo sd_setBackgroundImageWithURL:[NSURL URLWithString:dic[p_card_bg]] forState:UIControlStateNormal];
    _selectCardToOtherValue = [dic[p_card_type] integerValue];
    self.ppCongHandleselectedImage = nil;
    self.itemArr = @[];
    [self.tableView reloadData];
}


- (PPUserTopViewTimeView*)timeView {
    if(!_timeView) {
        kWeakself;
        _timeView = [[PPUserTopViewTimeView alloc] initWithFrame:CGRectMake(0, NavBarHeight + 64 - 20, ScreenWidth, 60)];
        _timeView.finishBlock = ^{
            weakSelf.countdown = 0;
            [weakSelf refershHeader];
            weakSelf.infoBgViewCardImagView.y = weakSelf.header.bottom;
            weakSelf.tableView.y = weakSelf.infoBgViewCardImagView.bottom;
        };
        [_timeView showPPReallyRadiusBottom:16];
        [_timeView ppConfigAddViewShadow];
    }
    return _timeView;
}


- (UIImage *)scaleBiteImage:(UIImage *)image toKBite:(NSInteger)kbiteSize {
    if (!image) {
        return image;
    }
    kbiteSize*=1024;
    CGFloat scale = 0.9f;
    CGFloat maxScaleValue = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, scale);
    while ([imageData length] > kbiteSize && scale > maxScaleValue) {
        scale -= 0.1;
        imageData = UIImageJPEGRepresentation(image, scale);
    }
    return [UIImage imageWithData:imageData];
}

- (void)uploadImage {
    kWeakself;
    NSDictionary *dic = @{@"light":@(_selectCardToOtherValue)};
    UIImage *image = [self scaleBiteImage:_ppCongHandleselectedImage toKBite:404];
    
    [Http upload:R_ocr_upload params:dic thumbName:@"am" image:image success:^(Response *response) {
        if (response.success) {
            weakSelf.itemArr = response.dataDic[p_list];
            weakSelf.needSaveDicData[p_value] = response.dataDic[p_relation_id];
            weakSelf.didCanMoveToTheIdCardImageUpload = YES;
            [weakSelf refreshUI];
            [weakSelf.photo setBackgroundImage:image forState:UIControlStateNormal];
            [weakSelf.photo setImage:nil forState:UIControlStateNormal];
        }else {
            [PPMiddleCenterToastView show:response.msg];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)photoAction {
    if (_didCanMoveToTheIdCardImageUpload) {
        return;
    }
    if (_selectCardToOtherValue <= 0) {
        [self selectAction];
        return;
    }
    _infopictureToolConfigHelper = [[PPHaussKingPictureTools alloc] init];
    [_infopictureToolConfigHelper ppGotoChoosePictureToUse:^(id object) {
        UIImage *image = (UIImage *)object;
        self.ppCongHandleselectedImage = image;
        self.didCanMoveToTheIdCardImageUpload = NO;
        self.itemArr = @[];
        [self.tableView reloadData];
        [self uploadImage];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    NSDictionary *cellDic = _itemArr[indexPath.row];
    NSString *code = cellDic[p_code];

    NSString *cate = cellDic[p_cate];
    if ([cate isEqualToString:@"txt"]) {
        return;
    }
    kWeakself;
    if ([cate isEqualToString:p_day]) {
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
        };
        [alert show];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _itemArr[indexPath.row];
    NSString *cate = dic[p_cate];
    if ([cate isEqualToString:p_day]) {
        static NSString *cellID = @"SelctCell";
        PPUserDefaultViewInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[PPUserDefaultViewInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.needSaveDicData = self.needSaveDicData;
        [cell loadData:dic];
        return cell;
    }else if ([cate isEqualToString:p_txt]) {
        static NSString *cellID = @"InputCell";
        PPNormalCardInputCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[PPNormalCardInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.needSaveDicData = self.needSaveDicData;
        [cell loadData:dic];
        return cell;
    }else {
        static NSString *cellID = @"GenderCell";
        PPNormalCardGenderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[PPNormalCardGenderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.needSaveDicData = self.needSaveDicData;
        [cell loadData:dic];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

@end
