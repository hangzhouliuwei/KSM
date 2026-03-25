//
//  PUBBankPopView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import "PUBBankPopView.h"
#import "PUBBankPopDetailView.h"

@interface PUBBankPopView()
@property (nonatomic,strong) UILabel *ttileLabel;
@property (nonatomic ,strong) UIView *alertView;
@property (nonatomic ,strong) UIStackView *stackView;
@property (nonatomic ,strong) NSArray <NSString*>*modelArray;
@end

@implementation PUBBankPopView

- (instancetype)initWithWord:(NSArray<NSString*>*)wordArr
{
    self = [super init];
    if (self) {
        self.modelArray = wordArr;
        [self cretUI];
    }
    
    return self;
}

- (void)cretUI
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
    UIButton* bgGrayView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgGrayView.frame = self.frame;
    bgGrayView.backgroundColor = [UIColor blackColor];
    bgGrayView.alpha = 0.7;

    [self addSubview:bgGrayView];
    CGFloat alertWidth = 320.f*WScale;
    CGFloat alertHeight = 306.f;
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertWidth, alertHeight)];
    _alertView.backgroundColor = [UIColor qmui_colorWithHexString:@"#444959"];
    _alertView.center = self.center;
    [_alertView showRadius:24];
    [self addSubview:_alertView];

    self.stackView = [[UIStackView alloc]init];
    self.stackView.backgroundColor = [UIColor qmui_colorWithHexString:@"#444959"];
    self.stackView.spacing = 15;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    [_alertView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_alertView.mas_centerX);
        make.top.equalTo(_alertView.mas_top).with.offset(12);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Please confirm your withdrawal account information belongs to yourself and is correct";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = FONT_BOLD(14.f);
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    //    [_alertView addSubview:titleLabel];
    [self.stackView addArrangedSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@52);
    }];
    [self.modelArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PUBBankPopDetailView *detailView = [[PUBBankPopDetailView alloc] initWithWord:idx == 0 ?  @"Channel/Bank：" :@"Account number：" content:obj];
        [self.stackView addArrangedSubview:detailView];
        [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.equalTo(@66.f);
         }];
    }];
    
    int buttonWidth = (KSCREEN_WIDTH - 68.f -52.f)/2;

    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = FONT_Semibold(18.f);
    confirmBtn.layer.cornerRadius = 20;
    [_alertView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-24);
        make.width.equalTo(@(buttonWidth));
        make.height.equalTo(@40);
        make.bottom.equalTo(@-22.f);
    }];

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitle:@"Back" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    closeBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#444959"];
    closeBtn.titleLabel.font = FONT(18.f);
    closeBtn.layer.borderWidth = 1.f;
    closeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    closeBtn.layer.cornerRadius = 20;
    [_alertView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.width.equalTo(@(buttonWidth));
        make.height.equalTo(@40);
        make.bottom.equalTo(@-22.f);
    }];
}

- (void)confirmBtnClick:(UIButton *)btn {
    if(self.confirmBlock){
        self.confirmBlock(self.modelArray);
        [self hide];
    }
}

- (void)cancelBtnClick:(UIButton *)btn {
    [self hide];
    if(self.cancelBlock){
        self.cancelBlock();
    }
    
}
- (void)show {
    self.alpha = 1;
    [TOP_WINDOW addSubview:self];
    [self addAnimation];
}

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
    [self hide];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
