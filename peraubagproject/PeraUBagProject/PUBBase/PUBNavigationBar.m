//
//  PUBNavigationBar.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/16.
//

#import "PUBNavigationBar.h"

@interface PUBNavigationBar()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *midView;

@end

@implementation PUBNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MainBgColor;
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    self.leftBtn.hidden = NO;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, StatusBarHeight, 44, 44);
        _leftBtn.titleLabel.font = FONT(14);
        [_leftBtn setTitle:@"" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:TextBlackColor forState:UIControlStateNormal];
        [_leftBtn setImage:ImageWithName(@"white_nav_return") forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (UILabel *)midView {
    if (!_midView) {
        _midView = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin + 44, StatusBarHeight, SafeWidth - 44*2, 44)];
        _midView.textColor = [UIColor whiteColor];
        _midView.font = FONT_BOLD(19.0);
        _midView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_midView];
    }
    return _midView;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _rightBtn.frame = CGRectMake(SCREEN_WIDTH - LeftMargin - 80, StatusBarHeight, 80, 44);
        _rightBtn.titleLabel.font = FONT(15);
        [_rightBtn setTitleColor:TextBlackColor forState:UIControlStateNormal];
        [_rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 80 - 44, 0, 0)];
        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (void)leftBtnClick:(UIButton *)btn {
    if (self.leftBtnClick) {
        self.leftBtnClick();
    }
}

- (void)rightBtnClick:(UIButton *)btn {
    if (self.rightBtnClick) {
        self.rightBtnClick();
    }
}

- (void)hideLeftBtn {
    _leftBtn.hidden = YES;
}

- (void)showLeftBtn {
    _leftBtn.hidden = NO;
}

- (void)hideRightBtn {
    _rightBtn.hidden = YES;
}

- (void)showRightBtn {
    _rightBtn.hidden = NO;
}

- (void)showtitle:(NSString*)title isLeft:(BOOL)isLeft
{
    self.midView.x = LeftMargin  + (self.leftBtn.hidden ? 0 : 44);
    self.midView.textAlignment = isLeft ? NSTextAlignmentLeft :  NSTextAlignmentCenter;
    self.midView.text = NotNull(title);
}

@end
