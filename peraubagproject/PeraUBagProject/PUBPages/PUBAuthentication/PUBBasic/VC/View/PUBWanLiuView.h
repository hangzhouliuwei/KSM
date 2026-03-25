//
//  PUBWanLiuView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, WanLiuType) {
    BasicType = 0,
    ContactType,
    IdentifictionType,
    FacialType,
    WithdrawType
};

@interface PUBWanLiuView : UIView
@property (nonatomic, copy) ReturnNoneBlock cancelBlock;
@property (nonatomic, copy) ReturnNoneBlock confirmBlock;
- (void)show:(WanLiuType)type;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
