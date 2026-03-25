//
//  PUBBaseButton.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, NLButtonType) {
    NLButtonTypeNormal = 0,
    NLButtonTypeDisable,
    NLButtonTypeBorder,
    NLButtonTypeSimple,
    NLButtonTypeGray,
    NLButtonTypeGrayWhiteText,
    NLButtonTypeGrayBorder,
    NLButtonTypeGoldGary,
    NLButtonTypeMember,
    NLButtonTypeNoMember,
    NLButtonTypeRedOrange,
    NLButtonTypeOrangeRed,
    NLButtonTypeBlackWhite,
    NLButtonTypeDiscontWhite,
    NLButtonTypeConfirm,
    NLButtonTypeCancel
};
@interface PUBBaseButton : UIButton

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NLButtonType type;
@property (nonatomic, strong) CAGradientLayer *gradient;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame radius:(CGFloat)radius;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)setTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
