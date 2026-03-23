//
//  UIView+Frame.h
//  MexicoLoanProject
//
//  Created by developer on 2024/08/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat    x;
@property (nonatomic) CGFloat    y;
@property (nonatomic) CGPoint    origin;
@property (nonatomic) CGSize size;


-(void)addRoundRadius;
-(void)clipTopLeftAndTopRightCornerRadius:(CGFloat)radius;
-(void)clipBottomLeftAndBottomRightCornerRadius:(CGFloat)radius;

-(void)pp_setPropertys:(NSArray *)array;

@end


NS_ASSUME_NONNULL_END
