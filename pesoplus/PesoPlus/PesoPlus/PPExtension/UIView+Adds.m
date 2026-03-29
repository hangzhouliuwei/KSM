//
//  UIView+Adds.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "UIView+Adds.h"

@implementation UIView (Adds)

- (CGFloat)h {
    return self.frame.size.height;
}

- (CGFloat)w {
    return self.frame.size.width;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)right {
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (void)setW:(CGFloat)width {
    CGRect newFrame = CGRectMake(self.x, self.y, width, self.h);
    self.frame = newFrame;
}

- (void)setH:(CGFloat)height {
    CGRect newFrame = CGRectMake(self.x, self.y, self.w, height);
    self.frame = newFrame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.y = centerY;
    self.center = center;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (void)ppConfigAddViewShadow {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = rgba(1, 38, 85, 0.10).CGColor;
    self.layer.shadowOffset = CGSizeMake(0,4);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4;
}

- (void)ppAddViewToshowShadow:(UIColor *)color {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4;
}

- (void)showBottomShadow:(UIColor *)color {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,4);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4;
}

- (void)showAddToRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)showCponfigRadiusTop:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.w, self.h) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius,radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)showPPReallyRadiusBottom:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.w, self.h) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(radius,radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)removeAllViews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)addGradient:(NSArray *)colors start:(CGPoint)start end:(CGPoint)end {
    NSMutableArray *colorArr = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorArr addObject:(id)color.CGColor];
    }
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [colorArr copy];
    gradient.startPoint = start;
    gradient.endPoint = end;
    [self.layer insertSublayer:gradient atIndex:0];
}

@end
