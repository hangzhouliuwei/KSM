//
//  InfoAlert.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "PPNormalCardInfoAlert.h"

@interface PPNormalCardInfoAlert ()
@property (nonatomic, copy) NSString *selectType;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, strong) UIView *alertView;


@end

@implementation PPNormalCardInfoAlert


- (void)selectBtnClick:(UIButton *)sender {
    NSDictionary *dic = _arr[sender.tag];
    if (self.selectBlock) {
        self.selectBlock(dic);
        [self hide];
    }
}

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

- (void)loadUI {
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    UIButton* bgGrayView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgGrayView.frame = self.frame;
    [bgGrayView addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgGrayView];
    bgGrayView.backgroundColor = [UIColor blackColor];
    bgGrayView.alpha = 0.3;

    
    CGFloat alertWidth = ScreenWidth;
    CGFloat alertHeight = ScreenHeight/2;
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - alertHeight, alertWidth, alertHeight)];
    _alertView.backgroundColor = UIColor.whiteColor;
    [_alertView showCponfigRadiusTop:16];
    [self addSubview:_alertView];
    
    UILabel *titleValue = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, 0, alertWidth - LeftMargin - 60, 66)];
    titleValue.text = notNull(_titleStr);
    titleValue.textColor = TextBlackColor;
    titleValue.font = Font(16);
    titleValue.numberOfLines = 0;
    [_alertView addSubview:titleValue];
    
    UIButton *closeBtnItem = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtnItem.frame = CGRectMake(alertWidth - 55, 0, 55, 55);
    [closeBtnItem setImage:ImageWithName(@"close_alert") forState:UIControlStateNormal];
    [closeBtnItem addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:closeBtnItem];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 80, SafeWidth, 0.8)];
    line.backgroundColor = rgba(223, 237, 255, 1);
    [_alertView addSubview:line];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 81, alertWidth, alertHeight - 81 - SafeBottomHeight)];
    [_alertView addSubview:scrollView];

    CGFloat itemHeight = 45;
    for (int i = 0; i < self.arr.count; i++) {
        NSDictionary *dic = self.arr[i];
        NSString *type = [dic[p_type] stringValue];
        NSString *value = _arr[i][p_name];
        UIButton *item = [[UIButton alloc] initWithFrame:CGRectMake(24, LeftMargin + itemHeight*i, alertWidth - 48, 40)];
        item.titleLabel.font = FontBold(14);
        item.tag = i;
        [item setTitle:notNull(value) forState:UIControlStateNormal];
        if ([_selectType isEqualToString:type]) {
            [item setTitleColor:TextBlackColor forState:UIControlStateNormal];
            item.backgroundColor = rgba(223, 237, 255, 1);
            [item showAddToRadius:20];
        }else {
            [item setTitleColor:TextGrayColor forState:UIControlStateNormal];
        }
        [item addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:item];
    }
    scrollView.contentSize = CGSizeMake(scrollView.w, self.arr.count*55);
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


@end

