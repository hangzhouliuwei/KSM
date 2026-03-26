//
//  BasicHeadView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/29.
//

#import "BasicHeadView.h"

@implementation BasicHeadView
-(instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        self.layer.cornerRadius = 12;
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = @[
            (__bridge id)kHexColor(0xFFFED1).CGColor,  // #2964F6
            (__bridge id)kHexColor(0xFFFFFF).CGColor   // #F9F9F9
        ];
        gradientLayer.startPoint = CGPointMake(0.5, 0.0);
        gradientLayer.endPoint = CGPointMake(0.5, 1.0);
        gradientLayer.cornerRadius = 12;
        [self.layer insertSublayer:gradientLayer atIndex:0];
        NSArray *titleArray = @[@"Basic",@"Contact",@"identihcation"];
        NSArray *nameArray = @[@"auth_base",@"auth_contact",@"auth_identifi"];
        CGFloat itemWidth = self.width / 3;
        for (int i = 0; i < 3; i++) {
            NSString *title = titleArray[i];
            NSString *name = nameArray[i];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(itemWidth * i, 0, itemWidth, self.height)];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((itemWidth - 37) / 2.0, 12, 37, 37);
            [view addSubview:button];
            NSString *name_0 = [NSString stringWithFormat:@"%@_0",name];
            NSString *name_1 = [NSString stringWithFormat:@"%@_1",name];
            [button setBackgroundImage:kImageName(name_0) forState:UIControlStateNormal];
            [button setBackgroundImage:kImageName(name_1) forState:UIControlStateSelected];
            [view addSubview:button];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 4 + button.bottom, itemWidth, 20)];
            [label pp_setPropertys:@[title,kFontSize(14),@(NSTextAlignmentCenter)]];
            [view addSubview:label];
            label.tag = 200 + i;
            button.tag = 100 + i;
            if (i == index) {
                label.textColor = kBlueColor_0053FF;
                button.selected = true;
            }else
            {
                label.textColor = kGrayColor_999999;
                button.selected = false;
            }
            [self addSubview:view];
//            view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(<#selector#>)]
        }
    }
    return self;
}
//-(void)tapAction:(UITapGestureRecognizer *)tap
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
