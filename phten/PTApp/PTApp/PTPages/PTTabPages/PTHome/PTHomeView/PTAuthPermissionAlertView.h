//
//  PTAuthPermissionAlertView.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTAuthPermissionAlertView : UIView
@property(nonatomic, copy) PTBlock confirmClickBlock;

-(instancetype)initWithTitleStr:(NSString*)titleStr
                    subTitleStr:(NSString*)subTitleStr;

-(void)show;

@end

NS_ASSUME_NONNULL_END
