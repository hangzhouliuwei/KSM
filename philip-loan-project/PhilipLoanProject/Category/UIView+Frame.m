//
//  UIView+Frame.m
//  MexicoLoanProject
//
//  Created by developer on 2024/08/23.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
@dynamic x;
@dynamic y;

-(void)pp_setPropertys:(NSArray *)array
{
    UILabel *label = (UILabel *)self;
    if ([label isMemberOfClass:[UILabel class]]) {
        for (id prop in array) {
            if ([prop isKindOfClass:[UIFont class]]) {
                label.font = prop;
            }else if ([prop isKindOfClass:[UIColor class]]) {
                label.textColor = prop;
            }else if ([prop isKindOfClass:[NSNumber class]]) {
                label.textAlignment = [prop integerValue];
            }else if ([prop isKindOfClass:[NSString class]]) {
                label.text = prop;
            }else if ([prop isKindOfClass:[NSArray class]]) {
                label.text = [NSString stringWithFormat:@"%@",prop];
            }else if ([prop isKindOfClass:[NSDictionary class]]) {
                NSString *hexStr = [NSString stringWithFormat:@"%@",prop];
                label.textColor = kStringHexColor(hexStr);
            }else if ([prop isKindOfClass:[NSMutableArray class]]) {
                label.text = [NSString stringWithFormat:@"%@",prop];
            }
        }
    }
    
}


-(void)addRoundRadius
{
    self.layer.shadowRadius = 14;
    self.layer.shadowColor = kAlphaHexColor(0x333333, 0.1).CGColor;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 1;
}
-(void)clipTopLeftAndTopRightCornerRadius:(CGFloat)radius
{
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}
-(void)clipBottomLeftAndBottomRightCornerRadius:(CGFloat)radius
{
    UIRectCorner corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setTop:(CGFloat)t
{
    self.frame = CGRectMake(self.left, t, self.width, self.height);
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)b
{
    self.frame = CGRectMake(self.left, b - self.height, self.width, self.height);
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLeft:(CGFloat)l
{
    self.frame = CGRectMake(l, self.top, self.width, self.height);
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)r
{
    self.frame = CGRectMake(r - self.width, self.top, self.width, self.height);
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWidth:(CGFloat)w
{
    self.frame = CGRectMake(self.left, self.top, w, self.height);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)h
{
    self.frame = CGRectMake(self.left, self.top, self.width, h);
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}
@end
