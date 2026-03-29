//
//  PPUserInfoProfilePage.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPUserInfoProfilePage.h"
#import "PPIconTitleButtonView.h"
#import "MJRefresh.h"

@interface PPUserInfoProfilePage ()
@property (nonatomic, copy) NSDictionary *refunPaydDic;
@property (nonatomic, strong) NSMutableArray *itemDataListCodeHeader;
@property (nonatomic, strong) UIImageView *headerImageViewCodeHeader;
@property (nonatomic, strong) UIView *listView;

@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeaderView;
@end

@implementation PPUserInfoProfilePage

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.content.backgroundColor = BGColor;
    self.content.h = ScreenHeight;
    kWeakself;
    _refreshHeaderView = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf catchUserData];
    }];
    self.content.mj_header = _refreshHeaderView;

    self.headerImageViewCodeHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 228)];
    self.headerImageViewCodeHeader.image = ImageWithName(@"user_header");
    [self.content addSubview:self.headerImageViewCodeHeader];
    self.headerImageViewCodeHeader.userInteractionEnabled = YES;

    [self loadHeader];
}


- (void)loadHeader {
    [self.headerImageViewCodeHeader removeAllViews];
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(ScreenWidth - 44, StatusBarHeight, 44, 44);
    [setBtn setImage:ImageWithName(@"user_set") forState:UIControlStateNormal];
    [setBtn setTitleColor:TextBlackColor forState:UIControlStateNormal];
    [self.headerImageViewCodeHeader addSubview:setBtn];
    [setBtn addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];

    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(34, StatusBarHeight + 20, 32, 32)];
    [icon showAddToRadius:4];
    icon.image = ImageWithName(@"app_icon");
    [self.headerImageViewCodeHeader addSubview:icon];

    UIImageView *hiIcon = [[UIImageView alloc] initWithFrame:CGRectMake(icon.right + 10, StatusBarHeight + 20, 52, 36)];
    [self.headerImageViewCodeHeader addSubview:hiIcon];
    hiIcon.image = ImageWithName(@"user_hi");
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(hiIcon.right + 10, icon.y, 200, 22)];
    name.text = @"Esteemed Member";
    name.font = FontCustom(14);
    name.textColor = UIColor.whiteColor;
    [self.headerImageViewCodeHeader addSubview:name];
    
    NSString *originalString = User.userName;
    if (originalString.length >= 10) {
        NSMutableString *maskedString = [originalString mutableCopy];
        [maskedString replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        originalString = maskedString;
    }
    
    UILabel *phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(name.x, name.bottom, SafeWidth, 23)];
    phoneNum.text = originalString;
    phoneNum.font = Font(19);
    phoneNum.textColor = COLORA(255, 177, 28, 1);
    [self.headerImageViewCodeHeader addSubview:phoneNum];
    
    
    UIImageView *borrow = [[UIImageView alloc] initWithFrame:CGRectMake(33*WS, self.headerImageViewCodeHeader.h - 83, 149*WS, 91)];
    borrow.image = ImageWithName(@"user_borrowing");
    [borrow addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(borrowClick)]];
    [self.headerImageViewCodeHeader addSubview:borrow];
    borrow.userInteractionEnabled = YES;

    UIImageView *order = [[UIImageView alloc] initWithFrame:CGRectMake(12*WS + borrow.right, self.headerImageViewCodeHeader.h - 83, 149*WS, 91)];
    order.image = ImageWithName(@"user_order");
    order.userInteractionEnabled = YES;
    [self.headerImageViewCodeHeader addSubview:order];
    [order addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderClick)]];

}


- (void)refreshUI {
    [self.listView removeFromSuperview];
    self.listView = [[UIView alloc] initWithFrame:CGRectMake(12, 250, ScreenWidth - 24, 0)];
    [self.content addSubview:self.listView];
    
    
    CGFloat offsetY = 0;
    if (_refunPaydDic) {
        UIView *payView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, self.listView.w, 155)];
        payView.backgroundColor = UIColor.whiteColor;
        [payView ppAddViewToshowShadow:rgba(1, 38, 85, 0.10)];
        [self.listView addSubview:payView];
        [payView showAddToRadius:12];

        
        UIView *payTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, payView.w, 41)];
        payTopView.backgroundColor = rgba(255, 221, 221, 1);
        [payView addSubview:payTopView];
        [payTopView showCponfigRadiusTop:12];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 11, 22, 22)];
        [payView addSubview:iconImageView];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:_refunPaydDic[p_icon]]];

        
        UILabel *nameValueL = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.right + 10, iconImageView.y, 200, 22)];
        nameValueL.text = _refunPaydDic[p_product_name];
        nameValueL.font = FontCustom(14);
        nameValueL.textColor = TextBlackColor;
        [payView addSubview:nameValueL];
        
        UILabel *statuslabel = [[UILabel alloc] initWithFrame:CGRectMake(200, iconImageView.y, payView.w - 212, 22)];
        statuslabel.textColor = rgba(253, 118, 118, 1);
        statuslabel.font = FontCustom(14);
        statuslabel.textAlignment = NSTextAlignmentRight;
        statuslabel.text = @"Overdue payment";
        [payView addSubview:statuslabel];
        
        UILabel *amountDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, 10 + payTopView.bottom + 8, payView.w/2 - 10, 15)];
        amountDesc.textColor = TextGrayColor;
        amountDesc.text = @"Loan amount";
        
        amountDesc.textAlignment = NSTextAlignmentCenter;
        amountDesc.font = Font(12);
        [payView addSubview:amountDesc];

        UILabel *amountValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, amountDesc.bottom, payView.w/2 - 10, 30)];
        amountValueLabel.text = _refunPaydDic[p_amount];
        amountValueLabel.font = FontBold(25);
        amountValueLabel.textAlignment = NSTextAlignmentCenter;
        amountValueLabel.textColor = rgba(253, 118, 118, 1);
        
        [payView addSubview:amountValueLabel];
        
        UILabel *rateDescLanel = [[UILabel alloc] initWithFrame:CGRectMake(payView.w/2, 10 +  payTopView.bottom + 8, payView.w/2 - 10, 15)];
        rateDescLanel.text = @"Repayment date";
        rateDescLanel.textColor = TextGrayColor;
        rateDescLanel.font = Font(12);
        rateDescLanel.textAlignment = NSTextAlignmentCenter;
        
        [payView addSubview:rateDescLanel];

        UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(payView.w/2, rateDescLanel.bottom, payView.w/2 - 10, 30)];
        rateLabel.text = _refunPaydDic[p_date];
        rateLabel.font = FontBold(25);
        rateLabel.textColor = rgba(253, 118, 118, 1);
        
        rateLabel.textAlignment = NSTextAlignmentCenter;
        [payView addSubview:rateLabel];
        
        UIButton *rePaybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rePaybtn.frame = CGRectMake(0, payView.h - 44, 236, 32);
        rePaybtn.titleLabel.font = FontCustom(12);
        rePaybtn.backgroundColor = rgba(253, 118, 118, 1);
        
        rePaybtn.centerX = payView.w/2;
        [rePaybtn setTitle:@"Refund" forState:UIControlStateNormal];
        [rePaybtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [payView addSubview:rePaybtn];
        [rePaybtn showAddToRadius:16];

        [rePaybtn addTarget:self action:@selector(repayClick) forControlEvents:UIControlEventTouchUpInside];
        
        offsetY = payView.bottom;
    }
    
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY + 12, self.listView.w, self.itemDataListCodeHeader.count * 42 + 14)];
    itemView.backgroundColor = UIColor.whiteColor;
    [itemView ppConfigAddViewShadow];
    [self.listView addSubview:itemView];
    [itemView showAddToRadius:12];

    
    self.listView.h = itemView.bottom;
    [self.content fitView:self.listView];
    
    for (int i = 0; i < self.itemDataListCodeHeader.count; i++) {
        NSDictionary *dic = self.itemDataListCodeHeader[i];
        UIButton *item = [[UIButton alloc] initWithFrame:CGRectMake(12, 7 + i*42, itemView.w - 24, 42)];
        item.tag = i;
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [itemView addSubview:item];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 22, 22)];
        [item addSubview:icon];
        [icon sd_setImageWithURL:dic[p_icon]];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(icon.right + 12, 10, item.w - icon.right - 24, 22)];
        name.text = dic[p_title];
        name.textColor = TextBlackColor;
        name.font = Font(14);
        [item addSubview:name];
        
        UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(item.right - 34, 10, 22, 22)];
        right.image = ImageWithName(@"icon_arrow") ;
        [item addSubview:right];
    }
}

- (void)orderClick {
    if (!User.isLogin) {
        [User login];
        return;
    }
    [Page pushToRootTabViewController:@"PPNormalCardOrderPage" param:@{@"selectTabIndex":@(1), @"orderType":@"4"}];
}

- (void)repayClick {
    if (!User.isLogin) {
        [User login];
        return;
    }
    
    NSString *repayUrl = _refunPaydDic[p_url];
    [Route jump:repayUrl];
}

- (void)setClick {
    if (!User.isLogin) {
        [User login];
        return;
    }
    [Page pushToRootTabViewController:@"SettingPPNormalCardPage"];
}

- (void)itemAction:(UIButton *)sender {
    if (!User.isLogin) {
        [User login];
        return;
    }
    
    NSDictionary *dic = self.itemDataListCodeHeader[sender.tag];
    NSString *link = dic[p_url];
    
    [PPMiddleCenterLoadingView showLoading];
    NSString *key = dic[p_key];
    if ([key isEqualToString:@"set_up"]) {
        [Page pushToRootTabViewController:@"SettingPPNormalCardPage"];
    }else {
        [Route jump:link];
    }
    [PPMiddleCenterLoadingView hideLoading];
    
}

- (void)viewWillAppear:(BOOL)animated {
    if (User.isLogin) {
        [self catchUserData];
    }
}

- (void)borrowClick {
    if (!User.isLogin) {
        [User login];
        return;
    }
    [Page pushToRootTabViewController:@"PPNormalCardOrderPage" param:@{@"selectTabIndex":@(0), @"orderType":@"6"}];
}

- (void)catchUserData {
    kWeakself;
    [Http get:R_userCenter params:nil success:^(Response *response) {
        if (response.success) {
            weakSelf.itemDataListCodeHeader = [NSMutableArray arrayWithArray:response.dataDic[p_extendLists]];
            weakSelf.refunPaydDic = response.dataDic[p_repayment_order];
            [weakSelf loadHeader];
            [weakSelf refreshUI];
        }
        [weakSelf.content.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.content.mj_header endRefreshing];
    }];
}

@end
