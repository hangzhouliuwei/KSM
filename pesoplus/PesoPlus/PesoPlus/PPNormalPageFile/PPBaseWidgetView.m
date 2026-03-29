//
//  PPBaseWidgetView.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPBaseWidgetView.h"

@implementation PPBaseWidgetView

- (void)fitView:(UIView *)view {
    self.contentSize = CGSizeMake(self.w, MAX(view.bottom + SafeBottomHeight, self.h + 1));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
