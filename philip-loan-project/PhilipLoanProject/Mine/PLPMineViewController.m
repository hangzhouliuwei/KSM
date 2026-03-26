//
//  MineViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/25.
//

#import "PLPMineViewController.h"
#import "PLPWebViewController.h"
#import "PLPSettingViewController.h"
@interface PLPMineViewController ()
@property(nonatomic)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel, *numberLabel;
@property(nonatomic,strong)NSArray *itemArray;
@property(nonatomic,strong)NSDictionary *refundInfo;
@end

@implementation PLPMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.baseImageView removeFromSuperview];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kBottomHeight)];
    _scrollView.backgroundColor = kHexColor(0xf5f5f5);
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.scrollView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kImageName(@"mine_setting") style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItemAction:)];
//#if DEBUG
//    [self handleRightItemAction:nil];
//#endif
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self BASE_RequestHTTPInfo];
}

-(void)handleRightItemAction:(UIBarButtonItem *)item
{
    PLPSettingViewController *vc = [PLPSettingViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)handelRefundButtonAction:(UIButton *)button
{
    NSString *url = self.refundInfo[@"relotwelveomNc"];
    if ([url isReal]) {
        PLPWebViewController *web = [[PLPWebViewController alloc] init];
        web.url = url;
        [self.navigationController pushViewController:web animated:YES];
    }
    
}
-(void)generateSubviewWithResponseObject:(NSDictionary *)responseObject
{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    NSDictionary *data = responseObject[@"viustwelveNc"];
    NSDictionary *repayDic = data[@"unqutwelvealizeNc"];
    NSArray *itemArray = data[@"mehatwelveemoglobinNc"];
    self.itemArray = itemArray;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 253 + kStatusHeight)];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = headerView.bounds;
    gl.startPoint = CGPointMake(0.44, 0.72);
    gl.endPoint = CGPointMake(0.44, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:41/255.0 green:100/255.0 blue:246/255.0 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [headerView.layer insertSublayer:gl atIndex:0];
    [self.scrollView addSubview:headerView];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 37 + kStatusHeight, 60, 60)];
    _headImageView.layer.masksToBounds = _headImageView.layer.cornerRadius = _headImageView.height / 2.0;
    _headImageView.image = kImageName(@"mine_head_logo");
    [headerView addSubview:self.headImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + _headImageView.right, _headImageView.top + 4, headerView.width - (10 + _headImageView.right) - 10, 20)];
    [_nameLabel pp_setPropertys:@[kFontSize(14), kWhiteColor]];
    [headerView addSubview:_nameLabel];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + _headImageView.right, _headImageView.top + 6, _nameLabel.width, 33)];
    
    NSString *account = [NSString stringWithFormat:@"%@",[kMMKV getStringForKey:kPhoneKey]];
    
    if (account.length > 6) {
        NSString *startStr=@"";
        for (int i = 3; i < account.length - 3; i++) {
            startStr = [NSString stringWithFormat:@"%@*",startStr];
        }
        account = [NSString stringWithFormat:@"%@%@%@",[account substringToIndex:3],startStr,[account substringWithRange:NSMakeRange(startStr.length + 3, account.length - startStr.length -3)]];
//        account = [account stringByReplacingOccurrencesOfString:[account substringWithRange:NSMakeRange(3, account.length - 3 - 3)] withString:startStr];
    }
    
    [self.numberLabel pp_setPropertys:@[kBoldFontSize(24), kWhiteColor,account]];
    [headerView addSubview:self.numberLabel];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(14, _headImageView.bottom + 21, headerView.width - 2 * 14, 82)];
    bgView.backgroundColor = kWhiteColor;
    bgView.layer.cornerRadius = 12;
    [headerView addSubview:bgView];
    CGFloat itemWidth = bgView.width / 2.0;
    NSArray *titleArray = @[@"Borrowing", @"Order"];
    NSArray *imageArray = @[@"mine_head_card", @"mine_head_cart"];
    CGFloat lastY = bgView.bottom + 12;
    for (int i = 0; i < 2; i++) {
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(itemWidth * i, 0, itemWidth, bgView.height)];
        [tempView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureAction:)]];
        tempView.tag = 200 + i;
        [bgView addSubview:tempView];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.image = kImageName(imageArray[i]);
        if (i == 0) {
            imageView.frame = CGRectMake((tempView.width - 34) / 2.0, 18, 34, 25);
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(itemWidth, 40, 1, 20)];
            lineView.backgroundColor = kHexColor(0xd8d8d8);
            [bgView addSubview:lineView];
        }else
        {
            imageView.frame = CGRectMake((tempView.width - 33) / 2.0, 14, 33, 32);
        }
        [tempView addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 47, itemWidth, 20)];
        label.text = titleArray[i];
        [label pp_setPropertys:@[titleArray[i],kFontSize(14),kBlackColor_333333, @(NSTextAlignmentCenter)]];
        [tempView addSubview:label];
    }
    self.refundInfo = repayDic;
    if (repayDic.allKeys.count > 0) {
        UIView *repayBgView = [[UIView alloc] initWithFrame:CGRectMake(15, lastY, kScreenW - 2 * 15, 202)];
        repayBgView.backgroundColor = kWhiteColor;
        repayBgView.layer.cornerRadius = 12;
        [_scrollView addSubview:repayBgView];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 27, 27)];
        [iconImageView sd_setImageWithURL:kURL(repayDic[@"ieNctwelve"])];
        [repayBgView addSubview:iconImageView];
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(repayBgView.width - 200 - 14, 18, 200, 20)];
        [tipLabel pp_setPropertys:@[@"Overdue payment",kFontSize(12),kGrayColor_999999,@(NSTextAlignmentRight)]];
        [repayBgView addSubview:tipLabel];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(13 + iconImageView.right, 18, tipLabel.right - 13 - iconImageView.right, 20)];
        [nameLabel pp_setPropertys:@[kFontSize(14),kBlackColor_333333,[NSString stringWithFormat:@"%@",repayDic[@"harytwelveNc"]]]];
        [repayBgView addSubview:nameLabel];
        
        UIView *grayBgView = [[UIView alloc] initWithFrame:CGRectMake(14, 53, repayBgView.width - 2 * 14, 76)];
        grayBgView.layer.cornerRadius = 11;
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[
            (__bridge id)[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.0].CGColor,
            (__bridge id)[UIColor colorWithRed:0.780 green:0.780 blue:0.780 alpha:1.0].CGColor
        ];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
        gradientLayer.cornerRadius = 11;
        gradientLayer.frame = grayBgView.bounds;
        [grayBgView.layer insertSublayer:gradientLayer atIndex:0];
        [repayBgView addSubview:grayBgView];
        NSArray *infoArray = @[@"Loan amount",@"Repayment date"];
        NSArray *valueArray = @[[NSString stringWithFormat:@"%@",repayDic[@"geertwelvealitatNc"]],[NSString stringWithFormat:@"%@",repayDic[@"aceptwelvetablyNc"]]];
        CGFloat tempWidth = grayBgView.width / 2.0;
        for (int i = 0; i < 2; i++) {
            UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(tempWidth * i, 13, tempWidth, 30)];
            [valueLabel pp_setPropertys:@[valueArray[i],kBoldFontSize(22), kWhiteColor,@(NSTextAlignmentCenter)]];
            [grayBgView addSubview:valueLabel];
            UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(valueLabel.left, valueLabel.bottom, valueLabel.width, 19)];
            [desLabel pp_setPropertys:@[infoArray[i],kFontSize(14), kWhiteColor,@(NSTextAlignmentCenter)]];
            [grayBgView addSubview:desLabel];
            if (i == 0) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tempWidth, (grayBgView.height - 33) / 2.0, 1, 33)];
                lineView.backgroundColor = kWhiteColor;
                [grayBgView addSubview:lineView];
            }
        }
        UIButton *refundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        refundButton.frame = CGRectMake(14, 14 + grayBgView.bottom, repayBgView.width - 28, 40);
        refundButton.backgroundColor = kBlueColor_0053FF;
        refundButton.layer.cornerRadius = refundButton.height / 2.0;
        [refundButton setTitle:@"Refund" forState:UIControlStateNormal];
        refundButton.titleLabel.font = kFontSize(14);
        [refundButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [refundButton addTarget:self action:@selector(handelRefundButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [repayBgView addSubview:refundButton];
        
        
        lastY = repayBgView.bottom + 12;
    }
    self.scrollView.contentSize = CGSizeMake(0, lastY + 20);
    if (itemArray.count > 0) {
        UIView *itemBgView = [[UIView alloc] initWithFrame:CGRectMake(15, lastY, _scrollView.width - 30, 0)];
        itemBgView.backgroundColor = kWhiteColor;
        itemBgView.layer.cornerRadius = 12;
        [_scrollView addSubview:itemBgView];
        for (int i = 0; i < itemArray.count; i++) {
            NSDictionary *dic = itemArray[i];
            UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0,8 + 45 * i, itemBgView.width, 45)];
            [itemBgView addSubview:tempView];
            if (i < itemArray.count - 1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(14,8 + 45 * (i + 1), itemBgView.width - 28, 1)];
                lineView.backgroundColor = kHexColor(0xe5e5e5);
                [itemBgView addSubview:lineView];
            }
            UIImageView *itemIcon = [[UIImageView alloc] initWithFrame:CGRectMake((tempView.height - 30) / 2.0, (tempView.height - 30) / 2.0, 30, 30)];
            [itemIcon sd_setImageWithURL:kURL(dic[@"ieNctwelve"])];
            [tempView addSubview:itemIcon];
            UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(tempView.width - 15 - 10, (tempView.height - 25) / 2.0, 15, 15)];
            rightImageView.image = [[kImageName(@"mine_item_arrow") sd_tintedImageWithColor:kHexColor(0xd5d5d5)] sd_rotatedImageWithAngle:M_PI_2 fitSize:YES];
            [tempView addSubview:rightImageView];
            UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemIcon.right + 10, 12, rightImageView.left - (itemIcon.right + 10), 20)];
            [itemLabel pp_setPropertys:@[[NSString stringWithFormat:@"%@",dic[@"fldgtwelveeNc"]],kFontSize(14), kBlackColor_333333]];
            [tempView addSubview:itemLabel];
            if (i == itemArray.count - 1) {
                itemBgView.height = tempView.bottom + 8;
            }
            tempView.tag = 100 + i;
            [tempView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureAction:)]];
            if (i == itemArray.count - 1) {
                self.scrollView.contentSize = CGSizeMake(0, tempView.bottom + 20);
            }
        }
    }
}
-(void)handleTapGestureAction:(UITapGestureRecognizer *)tapG
{
    NSInteger tag = tapG.view.tag;
    if (tag == 200) {//borrowing
        self.navigationController.tabBarController.selectedIndex = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:kOrderChangeIndexNotification object:@(0)];
    }else if(tag == 201)//Order
    {
        self.navigationController.tabBarController.selectedIndex = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:kOrderChangeIndexNotification object:@(1)];
    }else if (tag < 200) {//item action
        NSDictionary *dic = self.itemArray[tag - 100];
        PLPWebViewController *vc = [PLPWebViewController new];
        vc.url = [NSString stringWithFormat:@"%@",dic[@"relotwelveomNc"]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}






-(void)BASE_RequestHTTPInfo
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] GETURL:@"twelvech/home" paramsInfo:nil successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        [self generateSubviewWithResponseObject:responseObject];
        
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
    
    
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
