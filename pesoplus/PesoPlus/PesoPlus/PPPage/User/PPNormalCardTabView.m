//
//  PPNormalCardTabView.m
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import "PPNormalCardTabView.h"

@interface PPNormalCardTabView ()
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) NSMutableArray *dataBtnArrIndeItemsArray;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation PPNormalCardTabView



- (void)lineFrameTransfer:(UIButton *)btn {
    self.line.centerX = btn.centerX;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.dataBtnArrIndeItemsArray = [NSMutableArray array];
    }
    return self;
}

- (void)loadTitles:(NSArray *)arr selectIndex:(NSInteger)index {
    self.titleArr = arr;
    [self loadUIselectIndex:index];
}

- (void)loadUIselectIndex:(NSInteger)index {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.w, self.h)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, self.h - 6, 40, 12)];
    [_line showCponfigRadiusTop:6];
    _line.backgroundColor = MainColor;
    [_scrollView addSubview:_line];
    _scrollView.clipsToBounds = YES;
    
    CGFloat itemWidth = self.w/_titleArr.count;
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = FontCustom(12);
        btn.tag = i;
        btn.frame = CGRectMake(i*itemWidth, 0, itemWidth, self.h);
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:i==index ? rgba(51, 51, 51, 1) : rgba(187, 187, 187, 1) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
        [self.dataBtnArrIndeItemsArray addObject:btn];
    }
    [self lineFrameTransfer:self.dataBtnArrIndeItemsArray[index]];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    for (UIButton *tmpBtn in self.dataBtnArrIndeItemsArray) {
        if (tmpBtn.tag == _selectIndex) {
            [tmpBtn setTitleColor:rgba(51, 51, 51, 1) forState:UIControlStateNormal];
        }else {
            [tmpBtn setTitleColor:rgba(187, 187, 187, 1) forState:UIControlStateNormal];
        }
    }
}

- (void)buttonClick:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock(btn.tag);
    }
    for (UIButton *tmpBtn in self.dataBtnArrIndeItemsArray) {
        if (tmpBtn == btn) {
            [tmpBtn setTitleColor:rgba(51, 51, 51, 1) forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                [self lineFrameTransfer:tmpBtn];
            }];
        }else {
            [tmpBtn setTitleColor:rgba(187, 187, 187, 1) forState:UIControlStateNormal];
        }
    }
}


@end
