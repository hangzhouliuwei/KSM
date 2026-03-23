//
//  PTVerifyPickerView.h
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTVerifyPickerView : UIView
- (instancetype)initWithTitleArray:(NSArray <id>*)titles headerTitle:(NSString *)headerTitle;
- (void)showWithAnimation;
@property (nonatomic, copy) void(^clickBlock)(id model);
@end

NS_ASSUME_NONNULL_END
