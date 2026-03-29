//
//  RelationAlert.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "PPNormalCardRelationAlert.h"
@interface PPNormalCardRelationAlert ()
@property (nonatomic, copy) NSString *selectType;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, strong) UIView *alertView;


@end

@implementation PPNormalCardRelationAlert

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
    UIButton* bgViewGrayV = [UIButton buttonWithType:UIButtonTypeCustom];
    bgViewGrayV.frame = self.frame;
    bgViewGrayV.backgroundColor = [UIColor blackColor];
    bgViewGrayV.alpha = 0.3;
    [bgViewGrayV addTarget:self action:@selector(bgBtnClickHide:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgViewGrayV];
    
    CGFloat alertViewWidth = ScreenWidth;
    CGFloat alertViewHeight = ScreenHeight/2;
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - alertViewHeight, alertViewWidth, alertViewHeight)];
    _alertView.backgroundColor = UIColor.whiteColor;
    [_alertView showCponfigRadiusTop:16];
    [self addSubview:_alertView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, 0, alertViewWidth - LeftMargin - 60, 55)];
    title.textAlignment = NSTextAlignmentLeft;
    title.font = Font(16);
    title.text = notNull(_titleStr);
    title.textColor = TextBlackColor;

    [_alertView addSubview:title];
    title.numberOfLines = 0;

    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(alertViewWidth - 55, 0, 55, 55);
    [closeBtn setImage:ImageWithName(@"close_alert") forState:UIControlStateNormal];
    [_alertView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(bgBtnClickHide:) forControlEvents:UIControlEventTouchUpInside];

    UIView *Middleline = [[UIView alloc] initWithFrame:CGRectMake(0, 66, ScreenWidth, 0.8)];
    Middleline.backgroundColor = rgba(223, 237, 255, 1);
    [_alertView addSubview:Middleline];
    
    UIScrollView *scrollViewContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 81, alertViewWidth, alertViewHeight - 81 - SafeBottomHeight)];
    [_alertView addSubview:scrollViewContent];

    CGFloat itemHeight = 45;
    for (int i = 0; i < self.arr.count; i++) {
        NSDictionary *dic = self.arr[i];
        NSString *typeString = [dic[p_key] stringValue];
        NSString *valueString = _arr[i][p_name];
        UIButton *itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, LeftMargin + itemHeight*i, SafeWidth, 40)];
        itemBtn.titleLabel.font = FontBold(14);
        itemBtn.tag = i;
        [itemBtn setTitle:notNull(valueString) forState:UIControlStateNormal];
        if ([_selectType isEqualToString:typeString]) {
            [itemBtn setTitleColor:TextBlackColor forState:UIControlStateNormal];
            itemBtn.backgroundColor = rgba(223, 237, 255, 1);
            [itemBtn showAddToRadius:20];
        }else {
            [itemBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        }
        [itemBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollViewContent addSubview:itemBtn];
    }
    scrollViewContent.contentSize = CGSizeMake(scrollViewContent.w, self.arr.count*55);
}

- (void)selectBtnClick:(UIButton *)sender {
    NSDictionary *dic = _arr[sender.tag];
    if (self.selectBlock) {
        self.selectBlock(dic);
        [self hide];
    }
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

- (void)bgBtnClickHide:(UIButton *)btn {
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

