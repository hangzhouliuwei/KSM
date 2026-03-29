//
//  PPUserDefaultViewBankAlert.m
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import "PPUserDefaultViewBankAlert.h"

@interface PPUserDefaultViewBankAlert ()
@property (nonatomic, strong) UIView *popWidgetItemView;
@property (nonatomic, copy) NSString *bank;
@property (nonatomic, copy) NSString *account;
@end

@implementation PPUserDefaultViewBankAlert

- (id)initWithBank:(NSString *)bank account:(NSString *)account {
    self = [super init];
    if (self) {
        self.bank = bank;
        self.account = account;
        self.backgroundColor = UIColor.clearColor;
        [self loadUI];
    }
    return self;
}

- (void)show {
    self.alpha = 1;
    [TopWindow addSubview:self];
    [self addAnimation];
}


- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)loadUI {
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    UIButton *bgGrayItemView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgGrayItemView.backgroundColor = [UIColor blackColor];
    bgGrayItemView.alpha = 0.7;
    bgGrayItemView.frame = self.frame;

    [self addSubview:bgGrayItemView];
    [bgGrayItemView addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    CGFloat alertWidth = SafeWidth;
    CGFloat alertHeight = 290;
    _popWidgetItemView = [[UIView alloc]initWithFrame:CGRectMake(LeftMargin, ScreenHeight - alertHeight, alertWidth, alertHeight)];
    [self addSubview:_popWidgetItemView];
    _popWidgetItemView.backgroundColor = [UIColor whiteColor];

    
    UIView *topVuteItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _popWidgetItemView.w, 71)];
    [_popWidgetItemView addSubview:topVuteItem];
    topVuteItem.backgroundColor = MainColor;

    
    UIImageView *middleImage = [[UIImageView alloc] initWithFrame:CGRectMake(_popWidgetItemView.w - 71 - 16, 0, 71, 71)];
    [topVuteItem addSubview:middleImage];
    middleImage.image = ImageWithName(@"confirm_note");

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, _popWidgetItemView.w - 71 - 20, 71)];
    
    NSString *aString = @"Please confirm your withdrawa";
    NSString *bString = @"l account information belongs to";
    NSString *cString = @" yourself and is correct";
    NSString *valueString = StrFormat(@"%@%@%@", aString, bString, cString);

    titleLabel.text = valueString;

    [topVuteItem addSubview:titleLabel];
    titleLabel.textColor = UIColor.whiteColor;
    titleLabel.font = FontBold(12);
    titleLabel.numberOfLines = 0;

    UILabel *bankLeadingLable = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, titleLabel.bottom + 5, 200, 50)];
    bankLeadingLable.text = @"Canhel/Bank";

    bankLeadingLable.textAlignment = NSTextAlignmentLeft;
    [_popWidgetItemView addSubview:bankLeadingLable];
    
    bankLeadingLable.textColor = TextGrayColor;
    bankLeadingLable.font = Font(13);
    
    UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(215, titleLabel.bottom + 5, alertWidth - 230, 50)];
    bankLabel.text = _bank;

    bankLabel.textAlignment = NSTextAlignmentRight;
    [_popWidgetItemView addSubview:bankLabel];
    bankLabel.textColor = TextBlackColor;
    bankLabel.font = FontBold(14);
    
    UILabel *accountLeadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, bankLeadingLable.bottom, 200, 50)];
    accountLeadingLabel.text = @"Account number";
    accountLeadingLabel.textAlignment = NSTextAlignmentLeft;
    [_popWidgetItemView addSubview:accountLeadingLabel];
    accountLeadingLabel.textColor = TextGrayColor;
    accountLeadingLabel.font = Font(13);

    
    UILabel *accountViewItem = [[UILabel alloc] initWithFrame:CGRectMake(215, bankLeadingLable.bottom, alertWidth - 230, 50)];
    accountViewItem.text = _account;

    accountViewItem.textAlignment = NSTextAlignmentRight;
    [_popWidgetItemView addSubview:accountViewItem];
    accountViewItem.textColor = TextBlackColor;
    accountViewItem.font = FontBold(14);
    
    UIView *lineViewTop = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, bankLeadingLable.bottom, alertWidth - 2*LeftMargin, 0.8)];
    [_popWidgetItemView addSubview:lineViewTop];
    lineViewTop.backgroundColor = LineGrayColor;

    
    UIView *lineNormalView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, accountLeadingLabel.bottom, alertWidth - 2*LeftMargin, 0.8)];
    [_popWidgetItemView addSubview:lineNormalView];
    lineNormalView.backgroundColor = LineGrayColor;

        
    UIButton *sureBtn = [PPKingHotConfigView normalBtn:CGRectMake(14, lineNormalView.bottom + 28, alertWidth - 28, 42) title:@"Confirm" font:18];
    [_popWidgetItemView addSubview:sureBtn];
    [sureBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(confirmAction)]];

    UIButton *closeBtn = [PPKingHotConfigView normalBtn:CGRectMake(14, sureBtn.bottom, alertWidth - 28, 42) title:@"Back" font:18];
    closeBtn.backgroundColor = UIColor.whiteColor;
    [closeBtn setTitleColor:MainColor forState:UIControlStateNormal];
    
    [_popWidgetItemView addSubview:closeBtn];
    [closeBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)]];

    
    _popWidgetItemView.h = 300;
    _popWidgetItemView.centerX = ScreenWidth/2;
    _popWidgetItemView.centerY = ScreenHeight/2;
    [_popWidgetItemView showAddToRadius:16];
}

- (void)backAction {
    [self hide];
}


- (void)addAnimation {
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scale.values = @[@(0.1),@(1.15),@(0.85),@(1.0)];
    scale.calculationMode = kCAAnimationLinear;
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[scale];
    animationGroup.duration = 0.25;
    [_popWidgetItemView.layer addAnimation:animationGroup forKey:nil];
}

- (void)bgBtnClick:(UIButton *)btn {
    [self hide];
}


- (void)confirmAction {
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self hide];
}



@end
