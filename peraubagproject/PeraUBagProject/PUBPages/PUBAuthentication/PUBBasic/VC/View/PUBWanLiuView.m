//
//  PUBWanLiuView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/4.
//

#import "PUBWanLiuView.h"

@interface PUBWanLiuView()
@property (nonatomic,strong) QMUIButton *confirmBtn;
@property (nonatomic,strong) QMUIButton *cancelBtn;
@property (nonatomic,strong) UIImageView *logoImageIcon;
@property (nonatomic,strong) UILabel *logoImageLabel;
@property (nonatomic,strong) UILabel *secondTitle;
@property (nonatomic ,strong) UIView *alertView;
@end

@implementation PUBWanLiuView

- (id)init {
    self = [super init];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIButton* bgGrayView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgGrayView.frame = self.frame;
    bgGrayView.backgroundColor = [UIColor blackColor];
    bgGrayView.alpha = 0.7;
    [bgGrayView addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgGrayView];
    
    
    CGFloat alertWidth = 320*WScale;
    CGFloat alertHeight = 272 + 34;
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertWidth, alertHeight)];
    _alertView.backgroundColor = [UIColor qmui_colorWithHexString:@"#444959"];
    [_alertView showRadius:16];
    [self addSubview:_alertView];
        
//    UIView *secondBg = [[UIView alloc]initWithFrame:CGRectMake(0, 114*WScale - 1, alertWidth, alertHeight)];
//    secondBg.backgroundColor = [UIColor whiteColor];
//    [_alertView addSubview:secondBg];

    UILabel *logoLabel = [[UILabel alloc] init];
    logoLabel.text = @"Are you sure you want to leave？";
    logoLabel.textColor = [UIColor qmui_colorWithHexString:@"#FFFFFF"];
    logoLabel.font = FONT_BOLD(19);
    logoLabel.numberOfLines = 0;
    logoLabel.textAlignment = NSTextAlignmentCenter;
    [self.alertView addSubview:logoLabel];
    [logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(15.f);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];


    self.logoImageIcon = [[UIImageView alloc]initWithImage:ImageWithName(@"ic_wanliu_topV")];
    [_alertView addSubview:self.logoImageIcon];
    [self.logoImageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(logoLabel.mas_bottom);
    }];

    
    self.secondTitle = [[UILabel alloc] init];
    self.secondTitle.text = @"";
    self.secondTitle.textColor = [UIColor qmui_colorWithHexString:@"#FFFFFF"];
    self.secondTitle.font = FONT_MED_SIZE(14);
    self.secondTitle.textAlignment = NSTextAlignmentCenter;
    self.secondTitle.numberOfLines = 0;
    [_alertView addSubview:self.secondTitle];
    [self.secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logoImageIcon.mas_centerX);
        make.top.equalTo(self.logoImageIcon.mas_bottom).with.offset(5);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
    }];

    CGFloat btnWidth = (_alertView.width-3*18)/2;
    self.confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.confirmBtn.cornerRadius = 21.f;
    self.confirmBtn.layer.borderWidth = 1.f;
    self.confirmBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.confirmBtn.titleLabel.font = FONT(18.f);
    self.confirmBtn.backgroundColor = [UIColor clearColor];
    [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_confirmBtn];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.width.equalTo(@(btnWidth));
        make.height.equalTo(@42);
        make.top.equalTo(self.secondTitle.mas_bottom).with.offset(23);
        make.bottom.equalTo(@-18);
    }];
    
//    _cancelBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(_confirmBtn.right + 18, self.secondTitle.bottom + 24, btnWidth, 42) title:@"Cancel"];
    self.cancelBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelBtn.cornerRadius = 21.f;
    self.cancelBtn.titleLabel.font = FONT_Semibold(18.f);
    self.cancelBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-14);
        make.width.equalTo(@(btnWidth));
        make.height.equalTo(@42);
        make.top.equalTo(self.secondTitle.mas_bottom).with.offset(23);
        make.bottom.equalTo(@-18);
    }];

//    secondBg.height = _cancelBtn.bottom + 24;
//    [_alertView showBottomRarius:8];
//    _alertView.height = secondBg.bottom ;
    _alertView.centerX = SCREEN_WIDTH/2;
    _alertView.centerY = SCREEN_HEIGHT/2 - 20;
}

- (void)confirmBtnClick:(UIButton *)btn {
    if(self.confirmBlock){
        self.confirmBlock();
    }
}

- (void)cancelBtnClick:(UIButton *)btn {
    [self hide];
}
- (void)show:(WanLiuType)type {
    switch (type) {
        case BasicType:
            [self.logoImageIcon setImage:[UIImage imageNamed:@"pub_basic_icon"]];
            self.secondTitle.text = @"Complete the form to apply for a loan, and we'll tailor a loan amount just for you.";
            break;
        case ContactType:
            [self.logoImageIcon setImage:[UIImage imageNamed:@"pub_contract_icon"]];
            self.secondTitle.text = @"Enhance your loan approval chances by providing your emergency contact information now.";
            break;
        case IdentifictionType:
            [self.logoImageIcon setImage:[UIImage imageNamed:@"pub_photos_icon"]];
            self.secondTitle.text = @"Complete your identification now for a chance to increase your loan limit.";
            break;
        case FacialType:
            [self.logoImageIcon setImage:[UIImage imageNamed:@"pub_live_icon"]];
            self.secondTitle.text = @"Boost your credit score by completing facial recognition now.";
            break;
        case WithdrawType:
            [self.logoImageIcon setImage:[UIImage imageNamed:@"pub_bank_icon"]];
            self.secondTitle.text = @"Take the final step to apply for your loan—submitting now will enhance your approval rate.";
            break;

        default:
            break;
    }


    self.alpha = 1;
    [TOP_WINDOW addSubview:self];
    [self addAnimation];
}

//- (void)show {
//    self.alpha = 1;
//    [TOP_WINDOW addSubview:self];
//    [self addAnimation];
//}

- (void)addAnimation {
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scale.values = @[@(0.1),@(1.1),@(0.9),@(1.0)];
    scale.calculationMode = kCAAnimationLinear;
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[scale];
    animationGroup.duration = 0.5;
    [_alertView.layer addAnimation:animationGroup forKey:nil];
}

- (void)bgBtnClick:(UIButton *)btn {
//    [self hide];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
