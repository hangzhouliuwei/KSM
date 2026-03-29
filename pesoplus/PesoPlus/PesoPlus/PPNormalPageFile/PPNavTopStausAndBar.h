//
//  PPNavTopStausAndBar.h
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPNavTopStausAndBar : UIView

@property (nonatomic, copy) CallBackNone backBtnClick;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UIButton *backBtn;

- (id)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
