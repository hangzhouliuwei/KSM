//
//  BagVerifyPickerView.h
//  NewBag
//
//  Created by Jacky on 2024/4/7.
//

#import <UIKit/UIKit.h>
@class BagBasicEnumModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyPickerView : UIView
- (instancetype)initWithTitleArray:(NSArray <id> *)titles headerTitle:(NSString *)header;
- (void)showWithAnimation;
@property (nonatomic, copy) void(^clickBlock)(id model);
@end

NS_ASSUME_NONNULL_END
