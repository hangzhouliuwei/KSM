//
//  UIView+XTCategory.m
//  XTApp
//
//  Created by xia on 2024/7/12.
//

#import "UIView+XTCategory.h"

@implementation UIView (XTCategory)

/**
 *  Custom initialization method
 *
 *  @param frame         frame
 *  @param color  颜色
 *
 */
+(UIView *)xt_frame:(CGRect)frame
              color:(UIColor * __nullable)color {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

/**
 *  渐变图层
 *
 *  @param colors         颜色数组
 *  @param startPoint 起始点
 *  @param endPoint 结束点
 *  @param size 大小
 *
 */
+(CAGradientLayer *)xt_layer:(NSArray <id>*)colors
                   locations:(NSArray *)locations
                  startPoint:(CGPoint)startPoint
                    endPoint:(CGPoint)endPoint
                        size:(CGSize)size {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = colors;
    layer.locations = locations;
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    return layer;
}

/**
 *  给view加圆角
 *
 *  @param rect 大小
 *  @param corners 圆角类型
 *  @param size 圆角大小
 *
 */
-(void)xt_rect:(CGRect)rect
       corners:(UIRectCorner)corners
          size:(CGSize)size {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners  cornerRadii:size];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    //设置大小
    layer.frame = rect;
    //设置图形样子
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

+ (UIImageView *)xt_img:(NSString *)name
                    tag:(NSInteger)tag{
    UIImageView *img = [UIImageView new];
    [img setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [img setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [img setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [img setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    img.tag = tag;
    if([name isKindOfClass:[NSString class]] && name.length > 0)
    {
        [img setImage:[UIImage imageNamed:name]];
    }
    
    return img;
}

+ (UIButton *)xt_btn:(NSString *)title
                font:(UIFont *)font
           textColor:(UIColor *)textColor
        cornerRadius:(float)cornerRadius
         borderColor:(UIColor *)borderColor
         borderWidth:(float)borderWidth
     backgroundColor:(UIColor *)backgroundColor
                 tag:(NSInteger)tag {
    UIButton *btn = [UIButton new];
    [btn setBackgroundColor:[UIColor clearColor]];
    if (title)
        [btn setTitle:title forState:UIControlStateNormal];
    if (font)
        [btn.titleLabel setFont:font];
    if (textColor)
        [btn setTitleColor:textColor forState:UIControlStateNormal];
    if (cornerRadius > 0)
        btn.layer.cornerRadius = cornerRadius;
    if (borderColor)
        btn.layer.borderColor = borderColor.CGColor;
    if (borderWidth > 0)
        btn.layer.borderWidth = borderWidth;
    if (backgroundColor)
        btn.backgroundColor = backgroundColor;
    [btn setTag:tag];
    return btn;
}

+(UIButton *)xt_btn:(NSString * __nullable)title
               font:(UIFont * __nullable)font
          textColor:(UIColor * __nullable)textColor
       cornerRadius:(float)cornerRadius
                tag:(NSInteger)tag {
    UIButton *btn = [UIButton new];
    [btn setBackgroundColor:[UIColor clearColor]];
    if (title)
        [btn setTitle:title forState:UIControlStateNormal];
    if (font)
        [btn.titleLabel setFont:font];
    if (textColor)
        [btn setTitleColor:textColor forState:UIControlStateNormal];
    if (cornerRadius > 0) {
        btn.layer.cornerRadius = cornerRadius;
        btn.clipsToBounds = YES;
    }
    [btn setTag:tag];
    return btn;
}

+(UITextField *)xt_textField:(BOOL)secureText
                 placeholder:(NSString *)placeholder
                        font:(UIFont *)font
                   textColor:(UIColor *)textColor
                withdelegate:(id)delegate {
    UITextField *textField = [UITextField new];
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (secureText)
        textField.secureTextEntry = YES;
    if (placeholder) {
        [textField xt_placeholder:placeholder placeholderColor:XT_RGB(0xB0B0B0, 1.0f)];
    }
    if(textColor) {
        textField.textColor = textColor;
    }
    textField.font = font;
    
    if(delegate)
    {
        textField.delegate = delegate;
    }
    return textField;
}

+ (UILabel *)xt_lab:(CGRect)frame
               text:(NSString *)text
               font:(UIFont *)font
          textColor:(UIColor *)textColor
          alignment:(NSTextAlignment)alignment
                tag:(NSInteger)tag {
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    [lab setText:text];
    [lab setTextColor:textColor];
    [lab setFont:font];
    lab.textAlignment = alignment;
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setTag:tag];
    return lab;
}

+ (UILabel *)xt_lab:(NSString *)text
               font:(UIFont *)font
          textColor:(UIColor *)textColor
          alignment:(NSTextAlignment)alignment
         isPriority:(BOOL)isPriority
                tag:(NSInteger)tag {
    UILabel *lab = [UILabel xt_lab:CGRectZero text:text font:font textColor:textColor alignment:alignment tag:tag];
    
    if(isPriority){
        [lab setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [lab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [lab setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [lab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return lab;
}

//画虚线 - draw dash line.
- (void)xt_drawLineFromPoint:(CGPoint)fPoint
                     toPoint:(CGPoint)tPoint
                   lineColor:(UIColor *)color
                   lineWidth:(CGFloat)width
                  lineHeight:(CGFloat)height
                   lineSpace:(CGFloat)space
                    lineType:(NSInteger)type {
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (color) {
        shapeLayer.strokeColor = color.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:fPoint];
        [path addLineToPoint:tPoint];
        path.CGPath;
    });
    //第一格虚线缩进多少 - the degree of indent of the first cell
    //shapeLayer.lineDashPhase = 4;
    shapeLayer.lineWidth = height < 0 ? 1 : height;
    shapeLayer.lineCap = kCALineCapButt;
    width = width < 0 ? 1 : width;
    shapeLayer.lineDashPattern = @[@(width),@(space)];
    if (type == 1) {
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineDashPattern = @[@(width),@(space+width)];
    }
    [self.layer addSublayer:shapeLayer];
}

@end

@implementation UITextField (XTCategory)

- (void)xt_placeholder:(NSString *)placeholder
      placeholderColor:(UIColor *)placeholderColor {
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:placeholderColor}];
}

@end

@implementation UIViewController (XTCategory)

- (void)xt_presentViewController:(UIViewController *)viewControllerToPresent
                        animated: (BOOL)flag
                      completion:(void (^ __nullable)(void))completion
          modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle {
    viewControllerToPresent.modalPresentationStyle = modalPresentationStyle;
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
