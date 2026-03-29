//
//  PPIconTitleButtonView.h
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HaoBtnType) {
    HaoBtnType1 = 0,//HaoBtnType1
    HaoBtnType2,//HaoBtnType2
    HaoBtnType3,//HaoBtnType3
    HaoBtnType4,//HaoBtnType4
    HaoBtnType5,//HaoBtnType5
    HaoBtnType6,//HaoBtnType6
    HaoBtnType7,//HaoBtnType7
    HaoBtnType8,//HaoBtnType8
    HaoBtnType9,//HaoBtnType9
};

@interface PPIconTitleButtonView : UIButton

@property (nonatomic, assign) HaoBtnType type;
@property (nonatomic, copy) NSString *title;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title  color:(UIColor *)color  font:(CGFloat)font icon:(NSString *)icon;

@end


NS_ASSUME_NONNULL_END
