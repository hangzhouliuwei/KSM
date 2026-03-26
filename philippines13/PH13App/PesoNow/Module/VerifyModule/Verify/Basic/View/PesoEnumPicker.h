//
//  PesoEnumPicker.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoEnumPicker : UIView
- (instancetype)initWithTitleArray:(NSArray <id>*)titles headerTitle:(NSString *)headerTitle;
- (void)showWithAnimation;
@property (nonatomic, copy) void(^clickBlock)(id model);
@end

NS_ASSUME_NONNULL_END
