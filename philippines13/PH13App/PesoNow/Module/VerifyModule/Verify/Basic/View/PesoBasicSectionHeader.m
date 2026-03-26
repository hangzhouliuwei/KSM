//
//  PesoBasicSectionHeader.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBasicSectionHeader.h"

@interface PesoBasicSectionHeader ()
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) QMUILabel *subTitleL;
@property (nonatomic, strong) QMUIButton *arrowBtn;
@end
@implementation PesoBasicSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = ColorFromHex(0xFFFCDC);
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(15) textColor:ColorFromHex(0x000000)];
    titleL.frame = CGRectMake(0, 0, 200, 20);
    titleL.numberOfLines = 0;
    titleL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleL];
    _titleL = titleL;
    
    QMUILabel *subTitleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(12) textColor:ColorFromHex(0x616C5F)];
    subTitleL.frame = CGRectMake(titleL.right, 0, 100, 20);
    subTitleL.centerY = titleL.centerY;
    subTitleL.numberOfLines = 0;
    [self addSubview:subTitleL];
    _subTitleL = subTitleL;
    
    QMUIButton *arrowBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    arrowBtn.frame = CGRectMake(kScreenWidth-10-53, 5, 53, 20);
//    arrowBtn.layer.cornerRadius = radius;
//    arrowBtn.layer.masksToBounds = YES;
    [arrowBtn setImage:[UIImage imageNamed:@"basic_more_down"] forState:UIControlStateNormal];
    [arrowBtn setImage:[UIImage imageNamed:@"basic_more_up"] forState:UIControlStateSelected];
    [arrowBtn addTarget:self action:@selector(onMoreClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:arrowBtn];
    _arrowBtn = arrowBtn;

}
- (void)updateUIWithTitle:(NSString *)title Subtitle:(NSString*)subtitle more:(BOOL)more isSelected:(BOOL)isSelected
{
    _titleL.text = title;
    _subTitleL.text = subtitle;
    CGFloat width = [title br_getTextWidth:PH_Font_B(15) height:20];
    CGFloat subWid = [subtitle br_getTextWidth:PH_Font(12) height:20];

    self.titleL.width = width;
    _arrowBtn.hidden = !more;
    if (more) {
        self.titleL.textAlignment = NSTextAlignmentLeft;
        self.titleL.frame = CGRectMake(14, 5, width, self.titleL.height);
        _subTitleL.frame = CGRectMake(_titleL.right+3, 0, subWid, 20);
        _subTitleL.centerY = _titleL.centerY;
    }else{
        self.titleL.textAlignment = NSTextAlignmentCenter;
        self.titleL.frame = CGRectMake(0, 0, width,20);
        self.titleL.center = CGPointMake(kScreenWidth/2, 15);

    }
    [self layoutIfNeeded];
    self.arrowBtn.selected = isSelected;
}
- (void)onMoreClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.click) {
        self.click(btn.selected);
    }
}
@end
