//
//  PPDefaultCardPopView.h
// FIexiLend
//
//  Created by jacky on 2024/11/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPDefaultCardPopView : UIView
@property (nonatomic, strong) UIImageView *suspendImageView;
@property (nonatomic, copy) CallBackNone clickBlock;
- (id)initWithFrame:(CGRect)frame image:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
