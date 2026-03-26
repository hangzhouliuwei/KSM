//
//  BaseButton.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/27.
//

#import "EnlargeButton.h"

@implementation EnlargeButton
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGRect expandedBounds = CGRectInset(bounds, -self.hitTestEdgeInsets.left, -self.hitTestEdgeInsets.top);
    expandedBounds = CGRectInset(expandedBounds, -self.hitTestEdgeInsets.right, -self.hitTestEdgeInsets.bottom);
    NSLog(@"%@",NSStringFromCGRect(expandedBounds));
    return CGRectContainsPoint(expandedBounds, point);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
