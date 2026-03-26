//
//  MoneyDateView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/29.
//

#import "MoneyDateView.h"

@implementation MoneyDateView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setModel:(OrderListModel *)model
{
    _model = model;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@{@"title":@"Loan amount",@"value":model.istatwelvecNc}];
    UIColor *bgColro = kHexColor(0xF7F7F7);
    if ([model.exertwelveiencelessNc isReal]) {
        [array addObject:@{@"title":@"Repayment Time",@"value":model.exertwelveiencelessNc}];
        bgColro = kHexColor(0xECF3FF);
    }
    self.backgroundColor = bgColro;
    CGFloat itemWidth = self.width / array.count;
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dic = array[i];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth * i, 13, itemWidth, 30)];
        [titleLabel pp_setPropertys:@[dic[@"value"],kBoldFontSize(22),@(NSTextAlignmentCenter),kBlueColor_0053FF]];
        [self addSubview:titleLabel];
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth * i, titleLabel.bottom, itemWidth, 19)];
        [valueLabel pp_setPropertys:@[dic[@"title"],kFontSize(14),@(NSTextAlignmentCenter),kGrayColor_999999]];
        [self addSubview:valueLabel];
    }
    if (array.count == 2) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(itemWidth, (self.height - 33) / 2.0, 1, 33)];
        lineView.backgroundColor = kHexColor(0xB5C7E9);
        [self addSubview:lineView];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
