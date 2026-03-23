//
//  XTSegView.h
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XTSegBtn;
@interface XTSegView : UIView

@property(nonatomic,weak) XTSegBtn *indexBtn;
@property(nonatomic,copy) XTIntBlock block;

- (instancetype)initArr:(NSArray <NSDictionary *>*)arr
                   font:(UIFont *)font
             selectFont:(UIFont *)selectFont
                  color:(UIColor *)color
            selectColor:(UIColor *)selectColor
                bgColor:(UIColor *)bgColor
          selectBgColor:(UIColor *)selectBgColor
                 select:(NSInteger)select;

- (instancetype)initArr:(NSArray <NSDictionary *>*)arr
                   font:(UIFont *)font
             selectFont:(UIFont *)selectFont
                  color:(UIColor *)color
            selectColor:(UIColor *)selectColor
                bgColor:(UIColor *)bgColor
          selectBgColor:(UIColor *)selectBgColor
           cornerRadius:(NSInteger)cornerRadius
                 select:(NSInteger)select;

-(void)reloadSeg:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
