//
//  PPHomeView.m
// FIexiLend
//
//  Created by jacky on 2024/11/6.
//

#import "PPLeftNormalCardView.h"
#import "JYBanner.h"

@interface PPLeftNormalCardView ()
@property (nonatomic, strong) UIImageView *defaultCardheaderImageViewData;
@property (nonatomic, strong) JYBanner *defaultCardbannerViewiewData;
@property (nonatomic, strong) UIView *defaultCardpravicyViewViewData;
@property (nonatomic, assign) BOOL isBlock;
@property (nonatomic, copy) NSDictionary *defaultCardItemsDic;
@property (nonatomic, strong) NSMutableArray *bannerItems;
@end

@implementation PPLeftNormalCardView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

- (void)refreshBanner:(NSMutableArray *)bannerData card:(NSMutableArray *)cardData {
    kWeakself;
    [self removeAllViews];
    
    self.defaultCardheaderImageViewData = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 325*WS)];
    self.defaultCardheaderImageViewData.userInteractionEnabled = YES;
    self.defaultCardheaderImageViewData.image = ImageWithName(@"home_header");
    
    UIImageView *advantageImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 186*WS, ScreenWidth, 240*WS)];
    advantageImageview.image = ImageWithName(@"home_advantage");
    [self addSubview:advantageImageview];
    [self addSubview:self.defaultCardheaderImageViewData];
    
    _bannerItems = bannerData;
    NSMutableArray *imageUrlList = [NSMutableArray array];
    for (NSDictionary *dic in bannerData) {
        [imageUrlList addObject:notNull(dic[p_imgUrlNew])];
    }
    if (imageUrlList.count > 0) {
        self.defaultCardbannerViewiewData = [[JYBanner alloc] initWithFrame:CGRectMake(LeftMargin, advantageImageview.bottom + 15, SafeWidth, 99) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
            carouselConfig.pageContollType = MiddlePageControl;
            carouselConfig.interValTime = 2;
            return carouselConfig;
        } clickBlock:^(NSInteger index) {
            [weakSelf bannerAction:index];
        }];
        [self.defaultCardbannerViewiewData showAddToRadius:8];
        [self addSubview:self.defaultCardbannerViewiewData];
        [self.defaultCardbannerViewiewData startCarouselWithArray:imageUrlList];
    }
    
    JYBanner *displayBanner = [[JYBanner alloc] initWithFrame:CGRectMake(0, self.defaultCardbannerViewiewData.bottom + 10, ScreenWidth, 137*WS) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
        carouselConfig.pageContollType = NonePageControl;
        carouselConfig.interValTime = 3;
        return carouselConfig;
    } clickBlock:^(NSInteger index) {
    }];
    [self addSubview:displayBanner];
    [displayBanner startCarouselWithArray:[NSMutableArray arrayWithArray:@[@"banner1", @"banner2"]]];
    
    UIImageView *publicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*WS, displayBanner.bottom + 15, ScreenWidth - 80*WS, 35*WS)];
    publicImageView.image = ImageWithName(@"right_desc");
    [self addSubview:publicImageView];
    
    self.defaultCardpravicyViewViewData = [[UIView  alloc] initWithFrame:CGRectMake(LeftMargin, publicImageView.bottom + 15, SafeWidth, 40)];
    [self addSubview:self.defaultCardpravicyViewViewData];
    [self setupPrivacy];
    
    self.h = self.defaultCardpravicyViewViewData.bottom + TabBarHeight;
    _defaultCardItemsDic = cardData[0];
    [self setupCard:_defaultCardItemsDic];
    
}

- (void)selectAction:(NSDictionary *)cardInfo  {
    if (!User.isLogin) {
        [User login];
        return;
    }
    if (_isBlock) {
        return;
    }
    if (User.appstore) {
        NSString *pid = [cardInfo[p_id] stringValue];
        [Route ppTextjumpToWithProdutId:pid];
        return;
    }
    [Track getUserPhoneLocationAndUpload:^(BOOL value) {
        if (value) {
            NSString *pid = [cardInfo[p_id] stringValue];
            [Route ppTextjumpToWithProdutId:pid];
        }else {
            
        }
    }];
    [self updateApplyStatus];
}

- (void)updateApplyStatus {
    _isBlock = YES;
    [self performSelector:@selector(endBlock) withObject:nil afterDelay:1];
}

- (void)endBlock {
    _isBlock = NO;
}

- (void)bannerAction:(NSInteger)index {
    NSDictionary *item = _bannerItems[index];
    NSString *url = item[@"rseltCiopjko"];
    if (isBlankStr(url)) {
        return;
    }
    [Page pushToRootTabViewController:@"PPWKWebViewControllerPage" param:@{@"url":url}];
}

- (void)setupCard:(NSDictionary *)data {
        
    NSString *amountDesc = data[p_amountRange];
    if (amountDesc.length > 1) {
        NSString *firstCharacter = [amountDesc substringToIndex:1];
        NSString *remainingCharacters = [amountDesc substringFromIndex:1];
                
        UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 61*WS, 20, 80)];
        amountLabel.text = remainingCharacters;
        amountLabel.textColor = UIColor.whiteColor;
        amountLabel.font = FontBold(65);
        amountLabel.textAlignment = NSTextAlignmentLeft;
        [amountLabel sizeToFit];
        amountLabel.h = 80;
        amountLabel.centerX = self.w/2 + 5;
        [self.defaultCardheaderImageViewData addSubview:amountLabel];
        
        UILabel *leadLabel = [[UILabel alloc] initWithFrame:CGRectMake(amountLabel.x - 24, 92*WS, 24, 48)];
        leadLabel.text = firstCharacter;
        leadLabel.textColor = UIColor.whiteColor;
        leadLabel.font = FontBold(24);
        leadLabel.textAlignment = NSTextAlignmentCenter;
        [self.defaultCardheaderImageViewData addSubview:leadLabel];
    }
    
    UILabel *valueDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, 137*WS, self.w, 24)];
    valueDesc.text = notNull(data[p_amountRangeDes]);
    valueDesc.textColor = UIColor.whiteColor;
    valueDesc.font = FontBold(20);
    valueDesc.textAlignment = NSTextAlignmentCenter;
    [self.defaultCardheaderImageViewData addSubview:valueDesc];
    
    UILabel *leftDesc = [[UILabel alloc] initWithFrame:CGRectMake(42*WS, 172*WS, self.w - 42*WS, 20)];
    leftDesc.text = StrFormat(@"%@:", notNull(data[p_termInfoDes]));
    leftDesc.textColor = UIColor.whiteColor;
    leftDesc.font = Font(14);
    leftDesc.textAlignment = NSTextAlignmentLeft;
    [self.defaultCardheaderImageViewData addSubview:leftDesc];
    
    UILabel *leftValue = [[UILabel alloc] initWithFrame:CGRectMake(42*WS, leftDesc.bottom , self.w - 42*WS, 20)];
    leftValue.text = notNull(data[p_termInfo]);
    leftValue.textColor = UIColor.whiteColor;
    leftValue.font = FontCustom(14);
    leftValue.textAlignment = NSTextAlignmentLeft;
    [self.defaultCardheaderImageViewData addSubview:leftValue];
    
    UILabel *rightDesc = [[UILabel alloc] initWithFrame:CGRectMake(16 + self.w/2, 172*WS, self.w - 42*WS, 20)];
    rightDesc.text = StrFormat(@"%@:", notNull(data[p_loanRateDes]));
    rightDesc.textColor = UIColor.whiteColor;
    rightDesc.font = Font(14);
    rightDesc.textAlignment = NSTextAlignmentLeft;
    [self.defaultCardheaderImageViewData addSubview:rightDesc];

    UILabel *rightInfo = [[UILabel alloc] initWithFrame:CGRectMake(16 + self.w/2, rightDesc.bottom, self.w/2 - 16, 20)];
    rightInfo.text = notNull(data[p_loanRate]);
    rightInfo.textColor = UIColor.whiteColor;
    rightInfo.font = FontCustom(14);
    rightInfo.textAlignment = NSTextAlignmentLeft;
    rightInfo.adjustsFontSizeToFitWidth = YES;
    [self.defaultCardheaderImageViewData addSubview:rightInfo];
    
    NSString *applyDesc = data[p_buttonText];
    NSString *applyColor = data[p_buttoncolor];
    
    UIButton *apply = [[UIButton alloc] initWithFrame:CGRectMake(self.defaultCardheaderImageViewData.w/2 - 44*WS, self.defaultCardheaderImageViewData.h - 23*WS - 88*WS, 88*WS, 88*WS)];
//    apply.titleLabel.adjustsFontSizeToFitWidth = YES;
    apply.titleLabel.font = FontCustom(22);
    apply.titleLabel.numberOfLines = 2;
    apply.titleLabel.textAlignment = NSTextAlignmentCenter;
    [apply setTitle:notNull(applyDesc) forState:UIControlStateNormal];
    [apply setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    apply.backgroundColor = [PPUserDefaultColorHelper ppToolsColorFromHex:notNull(applyColor)];
    apply.layer.borderColor = COLORA(238, 175, 0, 1).CGColor;
    apply.layer.borderWidth = 4;
    apply.layer.cornerRadius = 44;
    apply.layer.masksToBounds = YES;
    [apply addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.defaultCardheaderImageViewData addSubview:apply];
}

- (void)applyAction {
    [self selectAction:_defaultCardItemsDic];
}

- (void)setupPrivacy {
    UIImageView *tips = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 12, 12)];
    tips.image = ImageWithName(@"home_tips");
    [self.defaultCardpravicyViewViewData addSubview:tips];
    
    UILabel *click = [[UILabel alloc] initWithFrame:CGRectMake(tips.right + 5, 0, 0, 24)];
    click.text = @"Click to view the ";
    click.textColor = COLORA(61, 61, 61, 1);
    click.font = Font(10);
    [click sizeToFit];
    click.h = 24;
    [self.defaultCardpravicyViewViewData addSubview:click];
    
    UILabel *pravicy = [[UILabel alloc] initWithFrame:CGRectMake(click.right, 0, 0, 24)];
    pravicy.userInteractionEnabled = YES;
    pravicy.text = @"Privacy Agreement>>>";
    pravicy.textColor = MainColor;
    pravicy.font = Font(12);
    [pravicy sizeToFit];
    pravicy.h = 24;
    [pravicy addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agreementAction)]];
    [self.defaultCardpravicyViewViewData addSubview:pravicy];
    
    self.defaultCardpravicyViewViewData.w = pravicy.right;
    self.defaultCardpravicyViewViewData.centerX = self.w/2;
}


- (void)agreementAction {
    NSString *urlStr = StrFormat(@"%@%@", Http.h5Url, PrivacyUrl);
    [Page pushToRootTabViewController:@"PPWKWebViewControllerPage" param:@{@"url":urlStr}];
}

@end
