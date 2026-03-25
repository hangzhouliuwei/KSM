//
//  PUBBaseTabBarView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBBaseTabBarView : UIView

@property(nonatomic, copy) void(^itemBtnClickBlock)(NSInteger index);

- (void)updataItmebtnSelectedIndex:(NSInteger)selectedIndex;

@end

NS_ASSUME_NONNULL_END
