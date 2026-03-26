//
//  XTSegBtn.h
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTSegBtn : UIButton

@property(nonatomic) NSInteger index;

- (instancetype)initTit:(NSString *)tit
                   font:(UIFont *)font
             selectFont:(UIFont *)selectFont
                  color:(UIColor *)color
            selectColor:(UIColor *)selectColor
                bgColor:(UIColor *)bgColor
          selectBgColor:(UIColor *)selectBgColor;

@end

NS_ASSUME_NONNULL_END
