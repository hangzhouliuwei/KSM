//
//  PTSettingLogoutView.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTSettingLogoutView : UIView
@property(nonatomic, copy) PTBlock confirmClickBlock;
-(void)showTitleStr:(NSString*)titleStr
        subTitleStr:(NSString*)subTitleStr;
@end

NS_ASSUME_NONNULL_END
