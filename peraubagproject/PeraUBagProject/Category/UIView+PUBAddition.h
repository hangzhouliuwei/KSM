//
//  UIView+PBAddition.h
//  PerabagProject
//
//  Created by cxn on 2023/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LineType) {
    LineTypeTop = 0,
    LineTypeBottom,
    LineTypeLeft,
    LineTypeRight,
    LineTypeMiddle,
    LineTypeLeftRight,//左右两边间距12
};
@interface UIView (PUBAddition)
- (CGFloat)height;
- (CGFloat)width;
- (CGFloat)x;
- (CGFloat)y;
- (CGSize)size;
- (CGPoint)origin;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGFloat)bottom;
- (CGFloat)right;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setWidthEqualToView:(UIView *)view;
- (void)setHeightEqualToView:(UIView *)view;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)setCenterXEqualToView:(UIView *)view;
- (void)setCenterYEqualToView:(UIView *)view;
- (void)setTopEqualToView:(UIView *)view;
- (void)setBottomEqualToView:(UIView *)view;
- (void)setLeftEqualToView:(UIView *)view;
- (void)setRightEqualToView:(UIView *)view;
- (void)setSize:(CGSize)size;
- (void)setSizeEqualToView:(UIView *)view;

- (void)fillSuperView;
- (UIView *)topSuperView;

- (void)addLine:(LineType)type;
- (void)addLine:(LineType)type color:(UIColor *)color;
- (void)addLine:(LineType)type color:(UIColor *)color width:(CGFloat)lineBold;
- (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;
- (void)showShadow;
- (void)showShadow:(UIColor *)color;
- (void)showBottomShadow:(UIColor *)color;
- (void)showShadow:(UIColor *)color radius:(CGFloat)radius;
- (void)showRadius:(CGFloat)radius;
- (void)showTopRarius:(CGFloat)radius;
- (void)showLeftTopRarius:(CGFloat)radius;
- (void)showLeftRarius:(CGFloat)radius;
- (void)showBottomRarius:(CGFloat)radius;
- (void)showTopShadow:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
