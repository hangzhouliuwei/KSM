//
//  PTBasicVerifySectionHeader.h
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTBasicVerifySectionHeader : UIView
- (void)updateUIWithTitle:(NSString *)title Subtitle:(NSString*)subtitle more:(BOOL)more isSelected:(BOOL)isSelected;
@property (nonatomic, copy) PTBoolBlock click;

@end

NS_ASSUME_NONNULL_END
