//
//  LoanViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/25.
//

#import "PLPLoanViewController.h"
#import <MSCycleScrollView.h>
#import "BigCardView.h"
#import "TestController.h"
#import "LoanCycleViewCell.h"
#import "SmallCardView.h"
#import "RepayView.h"
#import "ProductItemView.h"
#import "PLPAuthInfoViewController.h"
#import "LoanAlertView.h"
#import "PLPWebViewController.h"
@interface PLPLoanViewController ()<MSCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)UIScrollView *scrollView;
@property(nonatomic)NSMutableArray *bannerArray;
@property(nonatomic)NSMutableArray *cycleArray;
@property(nonatomic)MSCycleScrollView *bottomCycleView;

@property(nonatomic)UITableView *tableView;


@end

@implementation PLPLoanViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
    [self fetchNetInfo];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bannerArray = [NSMutableArray array];
    self.cycleArray = [NSMutableArray array];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kBottomHeight)];
    [self requestPopInfo];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kBottomHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    kWeakSelf
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchNetInfo];
    }];
    [self.view addSubview:self.tableView];
#if DEBUG
//    [Tools uploadDeviceInfo];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [DataManager manager].productId = @"1";
//        Class cls = NSClassFromString(@"AuthOCRViewController");
//        UIViewController *vc = [cls new];
//        [self.navigationController pushViewController:vc animated:YES];
//    });
#endif
    
    
}

-(void)fetchNetInfo
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] GETURL:@"twelvech/index" paramsInfo:nil successBlk:^(id  _Nonnull responseObject) {
        [self.tableView.mj_header endRefreshing];
        kHideLoading
        [[PLPDataManager manager] updateInfoWithResponseObject:responseObject];
        NSDictionary *data = responseObject[@"viustwelveNc"];
        NSArray *dataArray = data[@"xathtwelveosisNc"];
        NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
        for (NSDictionary *dic in dataArray) {
            NSString *key = dic[@"itlitwelveanizeNc"];
            resultDic[key] = dic;
        }
        [self createSubviewWithDic:resultDic];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}

-(void)requestPopInfo
{
    kWeakSelf
    [[PLPNetRequestManager plpJsonManager] GETURL:@"twelvech/pop-up" paramsInfo:nil successBlk:^(id  _Nonnull responseObject) {
        NSDictionary *data = responseObject[@"viustwelveNc"];
        NSString *imageURL = data[@"meultwelveloblastomaNc"];
        NSString *url = data[@"relotwelveomNc"];
        if ([NSURL URLWithString:imageURL]) {
            LoanAlertView *view = [[LoanAlertView alloc] initWithFrame:CGRectMake(0, 0, 294, 401)];
            view.tapBlk = ^{
                PLPWebViewController *vc = [[PLPWebViewController alloc] init];
                vc.url = url;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            [view.imageView sd_setImageWithURL:kURL(imageURL)];
            [view popAlertViewOnCenter];
            
        }
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}

-(void)createSubviewWithDic:(NSDictionary *)resultDic
{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat rate = 346 / 750.0;
    MSCycleScrollView *cycleScrollView = [MSCycleScrollView cycleViewWithFrame:CGRectMake(0, 0, kScreenW, kScreenW * rate) delegate:self placeholderImage:kImageName(@"base_head_small")];
    cycleScrollView.backgroundColor = kBlueColor_0053FF;
    cycleScrollView.currentPageDotColor = kBlueColor_0053FF;
    cycleScrollView.pageDotColor = [UIColor colorWithWhite:0 alpha:0.2];
    cycleScrollView.pageControlDotSize = CGSizeMake(28, 3);
    NSMutableArray *images = [NSMutableArray array];
    for (NSDictionary *dic in resultDic[@"AATWELVEAV"][@"gugotwelveyleNc"]) {
        [images addObject:[NSString stringWithFormat:@"%@",dic[@"aristwelveNc"]]];
        [self.bannerArray addObject:dic];
    }
    cycleScrollView.imageUrls = images;
    [self.scrollView addSubview:cycleScrollView];
    //largecard
    if ([[resultDic allKeys] containsObject:@"AATWELVEAX"]) {
        [self createBigCardView:cycleScrollView.bottom info:resultDic];
    }else if ([[resultDic allKeys] containsObject:@"AATWELVEAY"])//small card
    {
        [self createSmallCardView:cycleScrollView.bottom info:resultDic];
    }
    self.tableView.tableHeaderView = self.scrollView;
    [self.tableView reloadData];
}
#pragma mark -MSCycleScrollViewDelegate
-(void)cycleScrollView:(MSCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}
-(Class)customCellClassForCycleScrollView:(MSCycleScrollView *)view
{
    if ([view isEqual:self.bottomCycleView]) {
        return [LoanCycleViewCell class];
    }
    return nil;
}
-(void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(MSCycleScrollView *)view
{
    if ([view isEqual:self.bottomCycleView]) {
        LoanCycleViewCell *customCell = cell;
        customCell.titleLabel.text = self.cycleArray[index][@"thcktwelveleafNc"];
        customCell.titleLabel.textColor = kStringHexColor(self.cycleArray[index][@"epgytwelvenyNc"]);
    }
}

-(void)createBigCardView:(CGFloat)y info:(NSDictionary *)resultDic
{
    NSDictionary *dic = ((NSArray *)resultDic[@"AATWELVEAX"][@"gugotwelveyleNc"]).firstObject;
    BigCardView *cardView = [[BigCardView alloc] initWithFrame:CGRectMake(14, 10 + y, kScreenW - 2 * 14, 180)];
    cardView.tapAppleyBlk = ^{
        kShowLoading
        [PLPDataManager manager].productId = [NSString stringWithFormat:@"%@",dic[@"regntwelveNc"]];
        [PLPCommondTools tapItemWithProductID:[NSString stringWithFormat:@"%@",dic[@"regntwelveNc"]]];
    };
    
//#if DEBUG
//    cardView.tapAppleyBlk();
//#endif
    
    [_scrollView addSubview:cardView];
    
    [cardView configureCardInfo:dic isBigCard:true];
    self.scrollView.backgroundColor = UIColor.clearColor;
    UILabel *whyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cardView.bottom + 26, _scrollView.width, 23)];
    [whyLabel pp_setPropertys:@[kFontSize(16),kBlackColor_333333, @(NSTextAlignmentCenter),@"Why choose us？"]];
    [self.scrollView addSubview:whyLabel];
    
    UILabel *voiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, whyLabel.bottom + 121, _scrollView.width, 23)];
    [voiceLabel pp_setPropertys:@[kFontSize(16),kBlackColor_333333, @(NSTextAlignmentCenter),@"Users Voices？"]];
    [self.scrollView addSubview:voiceLabel];
    
    UIView *whyView = [[UIView alloc] initWithFrame:CGRectMake(14, whyLabel.bottom + 18, _scrollView.width - 2 * 14, voiceLabel.top - (whyLabel.bottom + 18))];
    CGFloat itemWidth = whyView.width / 3.0;
    NSArray *titleArray = @[@"High Quota",@"Quick Tranfer",@"Several Payment Method"];
    for (int i = 0; i < titleArray.count; i++) {
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(itemWidth * i, 0, itemWidth, whyView.height)];
        [whyView addSubview:tempView];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((tempView.width - 45) / 2.0, 0, 45, 45)];
        NSString *iconName = [NSString stringWithFormat:@"loan_why_%d",i];
        iconImageView.image = kImageName(iconName);
        [tempView addSubview:iconImageView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6 + iconImageView.bottom, tempView.width, 0)];
        [nameLabel pp_setPropertys:@[kBlackColor_333333, kFontSize(14),@(NSTextAlignmentCenter)]];
        nameLabel.numberOfLines = 2;
        nameLabel.text = titleArray[i];
        nameLabel.height = [nameLabel.text heightWithWidth:nameLabel.width font:nameLabel.font];
        [tempView addSubview:nameLabel];
        if (i < 2) {
            UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(itemWidth - 17 / 2.0 + (itemWidth - 17) * i, iconImageView.centerY - 17 / 2.0, 17, 17)];
            arrowImageView.image = kImageName(@"loan_why_arrow");
            [whyView addSubview:arrowImageView];
        }
    }
    [_scrollView addSubview:whyView];
    
    UIView *voiceView = [[UIView alloc] initWithFrame:CGRectMake(14, 9 + voiceLabel.bottom, _scrollView.width - 28, 0)];
    voiceView.layer.cornerRadius = 12;
    voiceView.backgroundColor = kHexColor(0xe9e9e9);
    [_scrollView addSubview:voiceView];
    NSArray *newsArray = @[@{@"name":@"Manuel",@"new":@"This borrowing app offers flexible repayment terms. The interest rates are clearly shown with no hidden catches. I highly recommend it to those facing financial difficulties and in need of quick solutions."},@{@"name":@"Lourdes",@"new":@"This borrowing app is amazing! It has a simple application process and quick approval. When I was in financial trouble, it provided timely help."}];
    CGFloat lastY = 15;
    for (int i = 0; i < newsArray.count; i++) {
        NSDictionary *infoDic = newsArray[i];
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, lastY, 38, 38)];
        NSString *imageName = [NSString stringWithFormat:@"loan_voice_head_%d",i];
        headImageView.image = kImageName(imageName);
        [voiceView addSubview:headImageView];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + headImageView.right, lastY, voiceView.width - (5 + headImageView.right), 20)];
        [nameLabel pp_setPropertys:@[kBoldFontSize(14),kBlackColor_333333,infoDic[@"name"]]];
        [voiceView addSubview:nameLabel];
        for (int j = 0; j < 5; j++) {
            UIImageView *starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headImageView.right + 5 + (12 + 1) * j, nameLabel.bottom + 2, 12, 120 / 11.0)];
            starImageView.image = kImageName(@"loan_voice_star");
            [voiceView addSubview:starImageView];
        }
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom + 16, voiceView.width - 17 - nameLabel.left, 0)];
        [infoLabel pp_setPropertys:@[kFontSize(12),kHexColor(0x666666),infoDic[@"new"]]];
        infoLabel.numberOfLines = 0;
        infoLabel.height = [infoLabel.text heightWithWidth:infoLabel.width font:infoLabel.font];
        [voiceView addSubview:infoLabel];
        lastY = 16 + infoLabel.bottom;
    }
    voiceView.height = lastY;
    
    UILabel *qualifiTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, voiceView.bottom + 24, _scrollView.width, 23)];
    [qualifiTitleLabel pp_setPropertys:@[kBlackColor_333333,kFontSize(16),@"Qualification",@(NSTextAlignmentCenter)]];
    [_scrollView addSubview:qualifiTitleLabel];
    UIImageView *qualiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(38, 9 + qualifiTitleLabel.bottom, 85, 53)];
    qualiImageView.image = kImageName(@"loan_qualifi_icon");
    [_scrollView addSubview:qualiImageView];
    UILabel *qualiInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 + qualiImageView.right, 13 + qualifiTitleLabel.bottom, _scrollView.width - 30 - (3 + qualiImageView.right), 0)];
    [qualiInfoLabel pp_setPropertys:@[kFontSize(11), kGrayColor_999999,@"Company Name: ORAGON LENDING CORPORATION SEC REGISTRATION NO.CS200927465 CERT. OF AUTHORITY NO.423"]];
    qualiInfoLabel.numberOfLines = 0;
    qualiInfoLabel.height = [qualiInfoLabel.text heightWithWidth:qualiInfoLabel.width font:qualiInfoLabel.font];
    [_scrollView addSubview:qualiInfoLabel];
    
    NSMutableArray *emptyArray = [NSMutableArray array];
    for (NSDictionary *dic in resultDic[@"AATWELVEAW"][@"gugotwelveyleNc"]) {
        [emptyArray addObject:@""];
        [self.cycleArray addObject:dic];
    }
    
    self.bottomCycleView = [MSCycleScrollView cycleViewWithFrame:CGRectMake(56, 25 + qualiImageView.bottom, _scrollView.width - 2 * 56, 24) delegate:self placeholderImage:nil];
    self.bottomCycleView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.bottomCycleView.layer.cornerRadius = 12;
    self.bottomCycleView.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.bottomCycleView disableScrollGesture];
    self.bottomCycleView.showPageControl = false;
    [self.scrollView addSubview:self.bottomCycleView];
    self.scrollView.contentSize = CGSizeMake(0, self.bottomCycleView.bottom + 20);
//        self.bottomCycleView.onlyDisplayText = true;
    self.bottomCycleView.imageUrls = emptyArray;
}

-(void)createSmallCardView:(CGFloat)y info:(NSDictionary *)resultDic
{
    kWeakSelf
    SmallCardView *cardView = [[SmallCardView alloc] initWithFrame:CGRectMake(14, 10 + y, kScreenW - 2 * 14, 180)];
    
    [_scrollView addSubview:cardView];
    NSDictionary *dic = ((NSArray *)resultDic[@"AATWELVEAY"][@"gugotwelveyleNc"]).firstObject;
    cardView.tapAppleyBlk = ^{
        kShowLoading
        [PLPDataManager manager].productId = [NSString stringWithFormat:@"%@",dic[@"regntwelveNc"]];
        [PLPCommondTools tapItemWithProductID:[NSString stringWithFormat:@"%@",dic[@"regntwelveNc"]]];
    };
    [cardView configureCardInfo:dic];
    self.scrollView.backgroundColor = kHexColor(0xF5F5F5);
    CGFloat lastY = cardView.bottom;
    NSDictionary *repayDic = ((NSArray *)resultDic[@"REPAY_NOTICE"][@"gugotwelveyleNc"]).firstObject;
    if (repayDic.allKeys.count > 0) {
        RepayView *repayView = [[RepayView alloc] initWithFrame:CGRectMake(14, lastY + 14, _scrollView.width - 28, 75)];
        repayView.backgroundColor = kWhiteColor;
        repayView.layer.cornerRadius = 14;
        repayView.tapBlk = ^{
            if ([repayDic[@"relotwelveomNc"] isReal]) {
                PLPWebViewController *vc = [[PLPWebViewController alloc] init];
                vc.url = repayDic[@"relotwelveomNc"];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        };
        repayView.info = repayDic;
        [self.scrollView addSubview:repayView];
        lastY = repayView.bottom;
    }
    
    NSMutableArray *emptyArray = [NSMutableArray array];
    for (NSDictionary *dic in resultDic[@"AATWELVEAW"][@"gugotwelveyleNc"]) {
        [emptyArray addObject:@""];
        [self.cycleArray addObject:dic];
    }
    self.bottomCycleView = [MSCycleScrollView cycleViewWithFrame:CGRectMake(56, 12 + lastY, _scrollView.width - 2 * 56, 24) delegate:self placeholderImage:nil];
    self.bottomCycleView.backgroundColor = kWhiteColor;
    self.bottomCycleView.layer.cornerRadius = 8;
    self.bottomCycleView.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.bottomCycleView disableScrollGesture];
    self.bottomCycleView.showPageControl = false;
    [self.scrollView addSubview:self.bottomCycleView];
    self.bottomCycleView.imageUrls = emptyArray;
    
    NSArray *productArray = resultDic[@"AATWELVEAZ"][@"gugotwelveyleNc"];
    lastY = self.bottomCycleView.bottom + 12;
    for (int i = 0; i < productArray.count; i++) {
        NSDictionary *itemDic = productArray[i];
        ProductItemView *itemView = [[ProductItemView alloc] initWithFrame:CGRectMake(14, lastY, _scrollView.width - 28, 151)];
        itemView.dic = itemDic;
        itemView.tapItemBlk = ^{
            kShowLoading
            [PLPDataManager manager].productId = [NSString stringWithFormat:@"%@",itemDic[@"regntwelveNc"]];
            [PLPCommondTools tapItemWithProductID:[NSString stringWithFormat:@"%@",itemDic[@"regntwelveNc"]]];
        };
        lastY = itemView.bottom + 12;
        [_scrollView addSubview:itemView];
    }
    
    UIImageView *qualiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(38, lastY + 12, 85, 53)];
    qualiImageView.image = kImageName(@"loan_qualifi_icon");
    [_scrollView addSubview:qualiImageView];
    UILabel *qualiInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 + qualiImageView.right, qualiImageView.top + 3, _scrollView.width - 30 - (3 + qualiImageView.right), 0)];
    [qualiInfoLabel pp_setPropertys:@[kFontSize(11), kGrayColor_999999,@"Copperstonc lending inc SEC Registration No.2021050012959-04 CERTIFICATE OF AUTHORITY NO.3454"]];
    qualiInfoLabel.numberOfLines = 0;
    qualiInfoLabel.height = [qualiInfoLabel.text heightWithWidth:qualiInfoLabel.width font:qualiInfoLabel.font];
    qualiInfoLabel.centerY = qualiImageView.centerY;
    [_scrollView addSubview:qualiInfoLabel];
    
    UIView *privicyView = [[UIView alloc] initWithFrame:CGRectMake(0, qualiImageView.bottom + 25, 0, 17)];
    UIImageView *warnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2.5, 11, 11)];
    warnImageView.image = [kImageName(@"home_warn_icon") sd_tintedImageWithColor:kBlueColor_0053FF];
    [privicyView addSubview:warnImageView];
    YYLabel *infoLabel = [[YYLabel alloc] initWithFrame:CGRectMake(warnImageView.right + 2, 0, 0, 17)];
    [privicyView addSubview:infoLabel];
    NSString *text = @"Click to view the Privacy Agreement >>";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text attributes: @{NSFontAttributeName:kFontSize(13),NSForegroundColorAttributeName:kGrayColor_C9C9C9}];
    infoLabel.numberOfLines = 0;
    [attStr yy_setTextHighlightRange:[text rangeOfString:@"Privacy Agreement >>"] color:kBlueColor_0053FF backgroundColor:UIColor.clearColor userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weakSelf jumpToWebWithURL:@"https://www.oragon-lending.com/#/privacyagreement"];
    } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
    }];
    infoLabel.attributedText = attStr;
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(999999, infoLabel.height) text:attStr];
    infoLabel.width = layout.textBoundingSize.width;
    [privicyView addSubview:infoLabel];
    privicyView.width = infoLabel.right;
    privicyView.centerX = kScreenW / 2.0;
    [_scrollView addSubview:privicyView];
    self.scrollView.contentSize = CGSizeMake(0, privicyView.bottom + 20);
}
-(void)jumpToWebWithURL:(NSString *)url
{
    PLPWebViewController *vc = [[PLPWebViewController alloc] init];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark   UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;;
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
