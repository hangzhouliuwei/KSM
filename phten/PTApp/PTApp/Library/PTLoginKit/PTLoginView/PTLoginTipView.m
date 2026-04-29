//
//  PTLoginTipView.m
//  PTApp
//
//  Created by Jacky on 2024/8/30.
//

#import "PTLoginTipView.h"

@interface PTLoginTipView()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@end
@implementation PTLoginTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)show{
    [TOP_WINDOW addSubview:self];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
- (void)setupUI{
    self.backgroundColor = RGBA(0, 0, 0, 0.61);
    
    self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_login_tip"]];
    [self addSubview:self.backImageView];
    self.backImageView.frame = CGRectMake(0, 0, 244, 80);
    self.backImageView.center = self.center;
    
    self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_login_tip_!"]];
    self.iconImageView.frame = CGRectMake(0, 17, 21, 21);
    self.iconImageView.centerX = 244/2;
    [self.backImageView addSubview:self.iconImageView];
    
    self.titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(14) textColor:UIColor.blackColor];
    self.titleLabel.frame = CGRectMake(0, self.iconImageView.bottom + 9, 210, 16);
    self.titleLabel.text = @"Please confirm the agreement";
    self.titleLabel.centerX = 244/2;

    [self.backImageView addSubview:self.titleLabel];
    
}
@end
