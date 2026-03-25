//
//  BagVerifyBasicSectionHeader.h
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyBasicSectionHeader : UIView
+ (instancetype)createView;
- (void)updateUIWithTitle:(NSString *)title Subtitle:(NSString*)subtitle more:(BOOL)more isSelected:(BOOL)isSelected;
@property (nonatomic, copy) void(^clickMore)(BOOL value);
@end

NS_ASSUME_NONNULL_END
