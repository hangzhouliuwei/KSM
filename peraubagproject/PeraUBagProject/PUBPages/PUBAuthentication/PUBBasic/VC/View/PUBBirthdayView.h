//
//  PUBBirthdayView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBBirthdayView : UIView

@property (nonatomic, copy) ReturnObjectBlock confirmBlock;
- (instancetype)init;
- (void)loadUITitle:(NSString *)title;
- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
