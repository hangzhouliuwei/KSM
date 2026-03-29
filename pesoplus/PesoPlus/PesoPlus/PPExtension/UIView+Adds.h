//
//  UIView+Adds.h
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Adds)

- (CGFloat)h;
- (CGFloat)w;
- (CGFloat)x;
- (CGFloat)y;
- (CGSize)size;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGFloat)bottom;
- (CGFloat)right;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setW:(CGFloat)width;
- (void)setH:(CGFloat)height;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)setSize:(CGSize)size;

- (void)ppConfigAddViewShadow;
- (void)ppAddViewToshowShadow:(UIColor *)color;
- (void)showBottomShadow:(UIColor *)color;
- (void)showAddToRadius:(CGFloat)radius;
- (void)showCponfigRadiusTop:(CGFloat)radius;
- (void)showPPReallyRadiusBottom:(CGFloat)radius;
- (void)removeAllViews;
- (void)addGradient:(NSArray *)colors start:(CGPoint)start end:(CGPoint)end;
@end

NS_ASSUME_NONNULL_END
