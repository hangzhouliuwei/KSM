//
//  BagVerifyPickerView.h
//  NewBag
//
//  Created by Jacky on 2024/4/7.
//

#import <UIKit/UIKit.h>
@class PUBContactRelationEnumModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagContactPickerView : UIView
- (instancetype)initWithTitleArray:(NSArray <PUBContactRelationEnumModel *>*)titles headerTitle:(NSString *)header;
- (void)showWithAnimation;
@property (nonatomic, copy) void(^clickBlock)(PUBContactRelationEnumModel *model);
@end

NS_ASSUME_NONNULL_END
