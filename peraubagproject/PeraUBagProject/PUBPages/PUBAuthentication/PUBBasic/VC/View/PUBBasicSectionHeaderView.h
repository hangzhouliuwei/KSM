//
//  PUBBasicSectionHeaderView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBBasicSectionHeaderView : UIView

@property(nonatomic, copy) ReturnBoolBlock clicMoreBlock;

- (instancetype)initWithTitle:(NSString *)title Subtitle:(NSString*)subtitle more:(BOOL)more isHidde:(BOOL)isHidde;

@end

NS_ASSUME_NONNULL_END
