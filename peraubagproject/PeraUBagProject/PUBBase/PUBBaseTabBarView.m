//
//  PUBBaseTabBarView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/16.
//

#import "PUBBaseTabBarView.h"

@interface PUBBaseTabBarView ()
@property(nonatomic, copy) NSArray *titleArray;
@property(nonatomic, copy) NSMutableArray <UIButton*>*itemBtnArr;
@end
static NSInteger const tags = 10;

@implementation PUBBaseTabBarView


- (void)updataItmebtnSelectedIndex:(NSInteger)selectedIndex
{
    if(selectedIndex >= self.itemBtnArr.count)return;
    [self.itemBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.tag - tags == selectedIndex){
            obj.selected = YES;
        }else{
            obj.selected = NO;
        }
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.titleArray = @[@"Loan", @"Order", @"Mine"].copy;
    self.backgroundColor = MainBgColor;
    self.layer.cornerRadius = 24.f;
    self.clipsToBounds = YES;
    CGFloat itemBttwidth = (KSCREEN_WIDTH - 38.f)/self.titleArray.count;
    
    for (NSInteger i=0; i<self.titleArray.count; i++) {
        QMUIButton *itemBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [itemBtn setBackgroundImage:[UIImage qmui_imageWithGradientColors:@[[UIColor qmui_colorWithHexString:@"#8E3EFB"],[UIColor qmui_colorWithHexString:@"#5845F3"]] type:QMUIImageGradientTypeVertical locations:nil size:CGSizeMake(itemBttwidth, 48) cornerRadiusArray:nil] forState:UIControlStateSelected];
        [itemBtn setTitle:self.titleArray[i] forState:UIControlStateSelected];
        itemBtn.imagePosition = QMUIButtonImagePositionLeft;
        itemBtn.spacingBetweenImageAndTitle = 4;
        itemBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
        [itemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        itemBtn.tag = 10 + i;
        [itemBtn  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_button_%ld_off",i+1]] forState:UIControlStateNormal];
        [itemBtn  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_button_%ld_on",i+1]] forState:UIControlStateSelected];
        itemBtn.layer.cornerRadius = 24.f;
        itemBtn.clipsToBounds = YES;
        itemBtn.frame = CGRectMake(itemBttwidth*i, 0, itemBttwidth, 48.f);
        [itemBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtn];
        if(i==0){
            itemBtn.selected = YES;
        }else{
            itemBtn.selected = NO;
        }
        [self.itemBtnArr addObject:itemBtn];
    }
    
}

- (void)itemBtnClick:(UIButton*)btn
{
    if(btn.selected)return;
    btn.selected = !btn.selected;
    [self.itemBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj != btn){
            obj.selected = NO;
        }
    }];
    if(self.itemBtnClickBlock){
        self.itemBtnClickBlock(btn.tag - tags);
    }
    
}

#pragma mark - lazy

- (NSMutableArray<UIButton *> *)itemBtnArr{
    if(!_itemBtnArr){
        _itemBtnArr = [NSMutableArray array];
    }
    return _itemBtnArr;
}

@end
