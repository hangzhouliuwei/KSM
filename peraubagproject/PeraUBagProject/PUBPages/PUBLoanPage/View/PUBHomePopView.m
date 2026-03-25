//
//  PUBHomePopView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/16.
//

#import "PUBHomePopView.h"
#import "PUBHomePopModel.h"
#import "FLAnimatedImageView+WebCache.h"

@interface PUBHomePopView()
@property (nonatomic,strong) PUBBaseButton *confirmBtn;
@property (nonatomic,strong) PUBBaseButton *cancelBtn;
@property (nonatomic,strong) FLAnimatedImageView *logoImageV;
@property (nonatomic,strong) UIImageView *logoImageIcon;
@property (nonatomic,strong) UILabel *logoImageLabel;
@property (nonatomic ,strong) UIView *alertView;
@property (nonatomic ,strong) PUBHomePopModel *model;
@end
@implementation PUBHomePopView

- (instancetype)init {
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
    _alertView.centerX = self.centerX;
    _alertView.centerY = self.centerY - 30.f;
    [_alertView showRadius:16];
    [self addSubview:_alertView];
    self.logoImageV = [[FLAnimatedImageView alloc]initWithImage:ImageWithName(@"")];
    self.logoImageV.userInteractionEnabled = YES;
    self.logoImageV.frame = CGRectMake(0, 0, alertWidth, alertHeight);
    self.logoImageV.centerX = _alertView.centerX;
    [_alertView addSubview:self.logoImageV];
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_alertView);
    }];
//    }];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    // 将 UITapGestureRecognizer 添加到视图上
    [self.logoImageV addGestureRecognizer: tapGesture];

    PUBBaseButton *closeBtn = [PUBBaseButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImage:[UIImage imageNamed:@"pub_pop_close"] forState:UIControlStateNormal];
    [bgGrayView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.height.equalTo(@(28));
        make.top.equalTo(self.logoImageV.mas_bottom).offset(30.f);
    }];


}

- (void)confirmBtnClick:(UIButton *)btn {
    if(self.confirmBlock){
        self.confirmBlock();
    }
}

- (void)cancelBtnClick:(UIButton *)btn {
    [self hide];
}
- (void)show:(PUBHomePopModel*)model {
    self.model = model;
    [self.logoImageV sd_setImageWithURL:[NSURL URLWithString:model.sequestrum_eg]]; //[UIImage imageNamed:]];

    self.alpha = 1;
    [TOP_WINDOW addSubview:self];
    [self addAnimation];
}

- (void)handleTap:(UITapGestureRecognizer *)gesture {
    // 当手势被识别时，执行这个方法
    if (self.model.lobsterman_eg != NULL && [NSURL URLWithString:self.model.lobsterman_eg]) {
        [self hide];
        if(self.cancelBlock){
            self.cancelBlock();
        }
        
    }
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
