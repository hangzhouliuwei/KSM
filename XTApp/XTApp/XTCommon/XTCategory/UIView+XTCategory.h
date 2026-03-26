//
//  UIView+XTCategory.h
//  XTApp
//
//  Created by xia on 2024/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XTCategory)

/**
 *  Custom initialization method
 *
 *  @param frame         frame
 *  @param color  颜色
 *
 */
+(UIView *)xt_frame:(CGRect)frame
              color:(UIColor * __nullable)color;

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
                        size:(CGSize)size;

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
          size:(CGSize)size;

+ (UIImageView *)xt_img:(NSString * __nullable)name
                    tag:(NSInteger)tag;

+ (UIButton *)xt_btn:(NSString * __nullable)title
                font:(UIFont * __nullable)font
           textColor:(UIColor * __nullable)textColor
        cornerRadius:(float)cornerRadius
         borderColor:(UIColor * __nullable)borderColor
         borderWidth:(float)borderWidth
     backgroundColor:(UIColor * __nullable)backgroundColor
                 tag:(NSInteger)tag;

+ (UIButton *)xt_btn:(NSString * __nullable)title
               font:(UIFont * __nullable)font
          textColor:(UIColor * __nullable)textColor
       cornerRadius:(float)cornerRadius
                tag:(NSInteger)tag;

+ (UITextField *)xt_textField:(BOOL)secureText
                 placeholder:(NSString *)placeholder
                        font:(UIFont *)font
                   textColor:(UIColor *)textColor
                withdelegate:(id)delegate;

+ (UILabel *)xt_lab:(CGRect)frame
               text:(NSString *)text
               font:(UIFont *)font
          textColor:(UIColor *)textColor
          alignment:(NSTextAlignment)alignment
                tag:(NSInteger)tag;

+ (UILabel *)xt_lab:(NSString *)text
               font:(UIFont *)font
          textColor:(UIColor *)textColor
          alignment:(NSTextAlignment)alignment
         isPriority:(BOOL)isPriority
                tag:(NSInteger)tag;

//画虚线 - draw dash line.
- (void)xt_drawLineFromPoint:(CGPoint)fPoint
                     toPoint:(CGPoint)tPoint
                   lineColor:(UIColor *)color
                   lineWidth:(CGFloat)width
                  lineHeight:(CGFloat)height
                   lineSpace:(CGFloat)space
                    lineType:(NSInteger)type;
@end

@interface UITextField (XTCategory)

- (void)xt_placeholder:(NSString *)placeholder
      placeholderColor:(UIColor *)placeholderColor;

@end

@interface UIViewController (XTCategory)

- (void)xt_presentViewController:(UIViewController *)viewControllerToPresent
                        animated: (BOOL)flag
                      completion:(void (^ __nullable)(void))completion
          modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle;

@end

NS_ASSUME_NONNULL_END
