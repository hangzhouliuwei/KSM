//
//  PUBEmailAlertView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBEmailAlertView : UIView
@property(nonatomic, assign) CGFloat topMargin;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,copy)void (^selectBlock)(NSString * title);
@property (nonatomic,copy)void (^cancelBlock)(void);
- (void)showView:(UIView*)view;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
