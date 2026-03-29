//
//  PPRightCardDefaultView.m
// FIexiLend
//
//  Created by jacky on 2024/11/8.
//

#import "PPRightCardDefaultView.h"
#import "JYBanner.h"

@interface PPRightCardDefaultView ()
@property (nonatomic, strong) UIImageView *defaultCardheaderImageView;
@property (nonatomic, strong) UIView *itemView;
@property (nonatomic, strong) UIButton *defaultCardpayView;
@property (nonatomic, strong) JYBanner *defaultCarfbannerView;
@property (nonatomic, strong) UIView *defaultpravicyCardItmeView;
@property (nonatomic, copy) NSDictionary *cardDic;
@property (nonatomic, copy) NSMutableArray *payData;
@property (nonatomic, copy) NSMutableArray *listDic;
@property (nonatomic, assign) BOOL isBlock;
@property (nonatomic, strong) NSMutableArray *defaultbannerItems;
@end

@implementation PPRightCardDefaultView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

- (void)refreshBanner:(NSMutableArray *)bannerData card:(NSMutableArray *)cardData payData:(NSMutableArray *)payData items:(NSMutableArray *)items {
    kWeakself;
    [self removeAllViews];
    
    self.defaultCardheaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 246*WS)];
    self.defaultCardheaderImageView.image = ImageWithName(@"credit_header");
    [self addSubview:self.defaultCardheaderImageView];
    
    CGFloat midSpace = 15;
    if (payData.count > 0) {
        _payData = payData;
        self.defaultCardpayView = [UIButton buttonWithType:UIButtonTypeCustom];
        self.defaultCardpayView.frame = CGRectMake(LeftMargin, self.defaultCardheaderImageView.bottom - 45, SafeWidth, 90);
        [self insertSubview:self.defaultCardpayView atIndex:0];
        [self.defaultCardpayView sd_setBackgroundImageWithURL:[NSURL URLWithString:payData[0][p_message]] forState:UIControlStateNormal];
        [self.defaultCardpayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payAction)]];
        midSpace = 65;
    }

    _defaultbannerItems = bannerData;
    NSMutableArray *imageUrlList = [NSMutableArray array];
    for (NSDictionary *dic in bannerData) {
        [imageUrlList addObject:notNull(dic[p_imgUrlNew])];
    }
    
    CGFloat nextY = self.defaultCardheaderImageView.bottom + midSpace;
    if (imageUrlList.count > 0) {
        self.defaultCarfbannerView = [[JYBanner alloc] initWithFrame:CGRectMake(LeftMargin, self.defaultCardheaderImageView.bottom + midSpace, SafeWidth, 99) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
            carouselConfig.pageContollType = MiddlePageControl;
            carouselConfig.interValTime = 2;
            return carouselConfig;
        } clickBlock:^(NSInteger index) {
            [weakSelf bannerAction:index];
        }];
        [self.defaultCarfbannerView showAddToRadius:8];
        [self addSubview:self.defaultCarfbannerView];
        [self.defaultCarfbannerView startCarouselWithArray:imageUrlList];
        nextY = self.defaultCarfbannerView.bottom + 15;
    }
    
    self.itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nextY, ScreenWidth, 0)];
    [self addSubview:self.itemView];
    _listDic = items;
    [self setupItemView:items];
    
    self.defaultpravicyCardItmeView = [[UIView  alloc] initWithFrame:CGRectMake(LeftMargin, self.itemView.bottom + 15, SafeWidth, 40)];
    [self addSubview:self.defaultpravicyCardItmeView];
    [self setupPrivacy];
    
    self.h = self.defaultpravicyCardItmeView.bottom + TabBarHeight;
    
    self.cardDic = cardData[0];
    [self setupCard:self.cardDic];
    
}

- (void)payAction {
    NSString *url = self.payData[0][p_url];
    if ([url containsString:@"http"]) {
        [Route jump:url];
    }
}

- (void)itemAction:(UIButton *)sender {
    NSDictionary *info = self.listDic[sender.tag];
    NSString *pid = [info[p_id] stringValue];
    [self checkStatus:pid];
}

- (void)selectAction {
    NSString *pid = [self.cardDic[p_id] stringValue];
    [self checkStatus:pid];

}

- (void)checkStatus:(NSString *)pid {
    if (!User.isLogin) {
        [User login];
        return;
    }
    if (_isBlock) {
        return;
    }
    if (User.appstore) {
        [Route ppTextjumpToWithProdutId:pid];
        return;
    }
    [Track getUserPhoneLocationAndUpload:^(BOOL value) {
        if (value) {
            [Route ppTextjumpToWithProdutId:pid];
        }else {
            
        }
    }];
    [self updateApplyStatus];

}

- (void)endBlock {
    _isBlock = NO;
}

- (void)updateApplyStatus {
    _isBlock = YES;
    [self performSelector:@selector(endBlock) withObject:nil afterDelay:1];
}

- (void)bannerAction:(NSInteger)index {
    NSDictionary *item = _defaultbannerItems[index];
    NSString *url = item[@"rseltCiopjko"];
    if (isBlankStr(url)) {
        return;
    }
    [Page pushToRootTabViewController:@"PPWKWebViewControllerPage" param:@{@"url":url}];
}

- (void)setupCard:(NSDictionary *)data {
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(143*WS, 57*WS, 12*WS, 12*WS)];
    leftImageView.image = ImageWithName(@"coin");
    [self.defaultCardheaderImageView addSubview:leftImageView];
    
    UIImageView *rightImageview = [[UIImageView alloc] initWithFrame:CGRectMake(220*WS, 57*WS, 12*WS, 12*WS)];
    rightImageview.image = ImageWithName(@"coin");
    [self.defaultCardheaderImageView addSubview:rightImageview];
    
    UIImageView *logoImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42*WS, 48*WS, 48*WS)];
    logoImageview.image = ImageWithName(@"app_icon");
    logoImageview.centerX = self.w/2;
    [self.defaultCardheaderImageView addSubview:logoImageview];
    
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, logoImageview.bottom, self.w, 15)];
    nameLable.text = @"FIexiLend";
    nameLable.textColor = UIColor.whiteColor;
    nameLable.font = FontCustom(12);
    nameLable.textAlignment = NSTextAlignmentCenter;
    [self.defaultCardheaderImageView addSubview:nameLable];
    
    NSString *amountDescString = data[p_amountRange];
    if (amountDescString.length > 1) {
//        NSString *firstCharacter = [amountDescString substringToIndex:1];
//        NSString *remainingCharacters = [amountDescString substringFromIndex:1];
//        
        UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 93*WS, 20, 72)];
        amountLabel.text = amountDescString;
        amountLabel.textColor = UIColor.whiteColor;
        amountLabel.font = FontBold(55);
        amountLabel.textAlignment = NSTextAlignmentLeft;
        [amountLabel sizeToFit];
        amountLabel.h = 72;
        amountLabel.centerX = self.w/2 + 5;
        [self.defaultCardheaderImageView addSubview:amountLabel];
        [amountLabel showBottomShadow:COLORA(0, 0, 0, 0.5)];
        
//        UILabel *leadLabel = [[UILabel alloc] initWithFrame:CGRectMake(amountLabel.x - 15, 121*WS, 24, 44)];
//        leadLabel.text = firstCharacter;
//        leadLabel.textColor = UIColor.whiteColor;
//        leadLabel.font = FontBold(22);
//        leadLabel.textAlignment = NSTextAlignmentCenter;
//        [self.defaultCardheaderImageView addSubview:leadLabel];
    }
    
    UILabel *valueDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 161*WS, self.w, 24)];
    valueDescLabel.text = notNull(data[p_amountRangeDes]);
    valueDescLabel.textColor = UIColor.whiteColor;
    valueDescLabel.font = FontBold(17);
    valueDescLabel.textAlignment = NSTextAlignmentCenter;
    [self.defaultCardheaderImageView addSubview:valueDescLabel];
    
    NSString *applyDesc = data[p_buttonText];
    NSString *applyColor = data[p_buttoncolor];
    
    UIButton *applyBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.defaultCardheaderImageView.w/2 - 105*WS, 193*WS, 210*WS, 46*WS)];
    applyBtn.titleLabel.font = FontCustom(22);
    [applyBtn setTitle:notNull(applyDesc) forState:UIControlStateNormal];
    [applyBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    applyBtn.backgroundColor = [PPUserDefaultColorHelper ppToolsColorFromHex:notNull(applyColor)];
    applyBtn.layer.borderColor = COLORA(238, 175, 0, 1).CGColor;
    applyBtn.layer.borderWidth = 3;
    applyBtn.layer.cornerRadius = 23;
    applyBtn.layer.masksToBounds = YES;
    [applyBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [applyBtn showBottomShadow:COLORA(6, 52, 111, 0.1)];
    [self.defaultCardheaderImageView addSubview:applyBtn];
}

- (void)setupItemView:(NSArray *)data {
    for (int i = 0; i < data.count; i++) {
        NSDictionary *dic = data[i];
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(12, i*130, self.w - 24, 120)];
        itemView.backgroundColor = UIColor.whiteColor;
        [itemView showAddToRadius:12];
        [itemView showBottomShadow:COLORA(6, 52, 111, 0.1)];
        [self.itemView addSubview:itemView];
        
        UIImageView *logoImageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 22, 22)];
        [logoImageview sd_setImageWithURL:[NSURL URLWithString:dic[p_productLogo]]];
        [itemView addSubview:logoImageview];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(logoImageview.right + 8, 8, self.w, 16)];
        nameLabel.text = notNull(dic[p_productName]);
        nameLabel.textColor = COLORA(51, 51, 51, 1);
        nameLabel.font = FontCustom(12);
        [itemView addSubview:nameLabel];
        
        UIView *lineGray = [[UIView alloc] initWithFrame:CGRectMake(0, 33, itemView.w, 1)];
        lineGray.backgroundColor = LineGrayColor;
        [itemView addSubview:lineGray];
        
        UILabel *valueDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, 39, self.w - 40, 15)];
        valueDesc.text = notNull(dic[p_amountRangeDes]);
        valueDesc.textColor = COLORA(102, 102, 102, 1);
        valueDesc.font = FontBold(12);
        [itemView addSubview:valueDesc];

        NSString *applyDesc = dic[p_buttonText];
        NSString *applyColor = dic[p_buttoncolor];
        UIColor *targetColor = [PPUserDefaultColorHelper ppToolsColorFromHex:notNull(applyColor)];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.tag = 0;
        rightBtn.titleLabel.font = FontCustom(12);
        rightBtn.backgroundColor = targetColor;
        rightBtn.frame = CGRectMake(itemView.w - 120, 46, 100, 32);
        [rightBtn setTitle:notNull(applyDesc) forState:UIControlStateNormal];
        [rightBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn showAddToRadius:12];
        [itemView addSubview:rightBtn];
        
        UIView *tipsBg = [[UIView alloc] initWithFrame:CGRectMake(20, 90, self.w - 40, 17)];
        tipsBg.backgroundColor = UIColor.whiteColor;
        [itemView addSubview:tipsBg];
        tipsBg.alpha = 0.5;
        [tipsBg addGradient:@[UIColor.whiteColor, targetColor, UIColor.whiteColor] start:CGPointMake(0, 0.5) end:CGPointMake(1, 0.5)];
        
        UILabel *botTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, self.w - 40, 17)];
        botTipsLabel.text = notNull(dic[p_productDesc]);
        botTipsLabel.textColor = COLORA(102, 102, 102, 1);
        botTipsLabel.font = Font(12);
        botTipsLabel.textAlignment = NSTextAlignmentCenter;
        [itemView addSubview:botTipsLabel];
        
        NSString *amountDesc = dic[p_amountRange];
        if (amountDesc.length > 1) {
//            NSString *firstCharacter = [amountDesc substringToIndex:1];
//            NSString *remainingCharacters = [amountDesc substringFromIndex:1];
            
//            UILabel *leadLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 66, 15, 20)];
//            leadLabel.text = firstCharacter;
//            leadLabel.textColor = targetColor;
//            leadLabel.font = FontBold(15);
//            [itemView addSubview:leadLabel];
            
            UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 51, 0, 38)];
            amountLabel.text = amountDesc;
            amountLabel.textColor = targetColor;
            amountLabel.font = FontBold(32);
            amountLabel.textAlignment = NSTextAlignmentLeft;
            [amountLabel sizeToFit];
            amountLabel.h = 38;
            [itemView addSubview:amountLabel];
        }
    }
    self.itemView.h = data.count*130;
}

- (void)setupPrivacy {
    UIImageView *tipsImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 12, 12)];
    tipsImage.image = ImageWithName(@"home_tips");
    [self.defaultpravicyCardItmeView addSubview:tipsImage];
    
    UILabel *clickLabel = [[UILabel alloc] initWithFrame:CGRectMake(tipsImage.right + 5, 0, 0, 24)];
    clickLabel.text = @"Click to view the ";
    clickLabel.textColor = COLORA(61, 61, 61, 1);
    clickLabel.font = Font(10);
    [clickLabel sizeToFit];
    clickLabel.h = 24;
    [self.defaultpravicyCardItmeView addSubview:clickLabel];
    
    UILabel *pravicyLabel = [[UILabel alloc] initWithFrame:CGRectMake(clickLabel.right, 0, 0, 24)];
    pravicyLabel.userInteractionEnabled = YES;
    pravicyLabel.text = @"Privacy Agreement>>>";
    pravicyLabel.textColor = MainColor;
    pravicyLabel.font = Font(12);
    [pravicyLabel sizeToFit];
    pravicyLabel.h = 24;
    [pravicyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agreementAction)]];
    [self.defaultpravicyCardItmeView addSubview:pravicyLabel];
    
    self.defaultpravicyCardItmeView.w = pravicyLabel.right;
    self.defaultpravicyCardItmeView.centerX = self.w/2;
}

- (void)agreementAction {
    NSString *urlStr = StrFormat(@"%@%@", Http.h5Url, PrivacyUrl);
    [Page pushToRootTabViewController:@"PPWKWebViewControllerPage" param:@{@"url":urlStr}];
}

@end

