//
//  PPNavTopStausAndBar.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPNavTopStausAndBar.h"

@implementation PPNavTopStausAndBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self showAddToRadius:12];
        [self ppConfigAddViewShadow];
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self addSubview:self.backBtn];
    [self addSubview:self.titleView];
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(4, StatusBarHeight, 48, 44);
        [_backBtn setImage:ImageWithName(@"page_back") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel *)titleView {
    if (!_titleView) {
        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin + 44, StatusBarHeight, SafeWidth - 44*2, 44)];
        _titleView.textColor = TextBlackColor;
        _titleView.font = FontBold(18);
        _titleView.textAlignment = NSTextAlignmentCenter;
    }
    return _titleView;
}

- (void)backClick {
    if (self.backBtnClick) {
        self.backBtnClick();
    }
}

@end
