//
//  PesoBasicSectionHeader.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoBasicSectionHeader : UIView
- (void)updateUIWithTitle:(NSString *)title Subtitle:(NSString*)subtitle more:(BOOL)more isSelected:(BOOL)isSelected;
@property (nonatomic, copy) void(^click)(BOOL selected);

@end

NS_ASSUME_NONNULL_END
