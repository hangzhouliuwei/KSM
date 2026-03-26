//
//  XTCodeAltView.m
//  XTApp
//
//  Created by xia on 2024/9/4.
//

#import "XTCodeAltView.h"

@implementation XTCodeAltView

- (instancetype)init {
    self = [super init];
    if(self) {
        self.frame = CGRectMake(0, 0, 290, 213);
        UIImageView *img = [UIImageView xt_img:@"xt_login_code_alt" tag:0];
        [self addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
