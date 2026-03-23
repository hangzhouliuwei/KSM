//
//  XTSegBtn.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTSegBtn.h"

@implementation XTSegBtn

- (instancetype)initTit:(NSString *)tit
                   font:(UIFont *)font
             selectFont:(UIFont *)selectFont
                  color:(UIColor *)color
            selectColor:(UIColor *)selectColor
                bgColor:(UIColor *)bgColor
          selectBgColor:(UIColor *)selectBgColor {
    self = [super init];
    if(self) {
        [self setTitle:tit forState:UIControlStateNormal];
        self.titleLabel.font = font;
        [self setTitleColor:color forState:UIControlStateNormal];
        self.backgroundColor = bgColor;
        @weakify(self)
        [[[RACObserve(self,self.enabled) distinctUntilChanged] skip:1] subscribeNext:^(NSNumber *isNoData) {
            @strongify(self);
            if (self.enabled) {
                self.titleLabel.font = font;
                [self setTitleColor:color forState:UIControlStateNormal];
                self.backgroundColor = bgColor;
            }
            else {
                self.titleLabel.font = selectFont;
                [self setTitleColor:selectColor forState:UIControlStateNormal];
                self.backgroundColor = selectBgColor;
            }
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
