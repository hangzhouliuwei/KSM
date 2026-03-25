//
//  PUBAuthPermissionAlert.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBAuthPermissionAlert : UIView
@property (nonatomic, copy) ReturnNoneBlock confirmBlock;
- (instancetype)initWith:(NSString *)logoStr textStr:(NSString *)textStr btnText:(NSString *)btnText;
- (void)show;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
