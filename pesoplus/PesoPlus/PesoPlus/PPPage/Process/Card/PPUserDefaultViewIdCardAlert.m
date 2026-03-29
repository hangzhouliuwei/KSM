//
//  PPUserDefaultViewIdCardAlert.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "PPUserDefaultViewIdCardAlert.h"

@interface PPUserDefaultViewIdCardAlert ()
@property (nonatomic, copy) NSString *selectType;

@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, copy) NSString *titleStr;

@end

@implementation PPUserDefaultViewIdCardAlert

- (id)initWithData:(NSArray *)arr selected:(NSString *)selectType title:(NSString *)titleStr {
    self = [super init];
    if (self) {
        self.arr = arr;
        self.selectType = selectType;
        self.titleStr = titleStr;
        [self loadUI];
    }
    return self;
}

- (void)show {
    CGFloat y = _alertView.y;
    _alertView.y = ScreenHeight;
    kWeakself;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = y;
    } completion:^(BOOL finished) {
        
    }];
    [TopWindow addSubview:self];
}

- (void)bgBtnClick:(UIButton *)btn {
    [self hide];
}

- (void)loadUI {
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    UIButton* bgGreyView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgGreyView.frame = self.frame;
    bgGreyView.backgroundColor = [UIColor blackColor];
    bgGreyView.alpha = 0.3;
    [bgGreyView addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgGreyView];
    
    CGFloat alertWidth = ScreenWidth;
    CGFloat alertHeight = ScreenHeight/2;
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - alertHeight, alertWidth, alertHeight)];
    _alertView.backgroundColor = UIColor.whiteColor;
    [_alertView showCponfigRadiusTop:16];
    [self addSubview:_alertView];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, 0, alertWidth - LeftMargin - 60, 66)];
    titleLable.text = notNull(_titleStr);
    titleLable.textColor = TextBlackColor;
    titleLable.font = Font(16);
    titleLable.numberOfLines = 0;
    titleLable.textAlignment = NSTextAlignmentLeft;
    [_alertView addSubview:titleLable];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 66, ScreenWidth, 0.8)];
    line.backgroundColor = rgba(223, 237, 255, 1);
    [_alertView addSubview:line];

    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(alertWidth - 55, 0, 55, 55);
    [closeBtn setImage:ImageWithName(@"close_alert") forState:UIControlStateNormal];
    [_alertView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 81, alertWidth, alertHeight - 81 - SafeBottomHeight)];
    [_alertView addSubview:scrollView];

    CGFloat itemHeight = 45;
    for (int i = 0; i < self.arr.count; i++) {
        NSDictionary *dic = self.arr[i];
        NSString *valuestr = dic[p_card_title];

        NSString *typestr = [dic[p_card_type] stringValue];
        UIButton *itembtn = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, LeftMargin + itemHeight*i, SafeWidth, 40)];
        itembtn.titleLabel.font = FontBold(14);
        itembtn.tag = i;
        [itembtn setTitle:notNull(valuestr) forState:UIControlStateNormal];
        if ([_selectType isEqualToString:typestr]) {
            [itembtn setTitleColor:TextBlackColor forState:UIControlStateNormal];
            itembtn.backgroundColor = rgba(223, 237, 255, 1);
            [itembtn showAddToRadius:20];
        }else {
            [itembtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        }
        [itembtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:itembtn];
    }
    scrollView.contentSize = CGSizeMake(scrollView.w, self.arr.count*55);
}

- (void)selectBtnClick:(UIButton *)sender {
    NSDictionary *dic = _arr[sender.tag];
    if (self.selectBlock) {
        self.selectBlock(dic);
        [self hide];
    }
}


- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
