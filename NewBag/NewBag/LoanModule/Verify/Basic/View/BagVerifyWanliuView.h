//
//  BagVerifyWanliuView.h
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, WanLiuType) {
    VerifyBasicType = 0,
    VerifyContactType,
    VerifyIdentifictionType,
    VerifyFacialType,
    VerifyWithdrawType
};
@interface BagVerifyWanliuView : UIView
+ (instancetype)createAlert;
- (void)showWithType:(WanLiuType)type;
@property (nonatomic, copy) dispatch_block_t confirmBlock;
@property (nonatomic, copy) dispatch_block_t cancelBlock;

@end

NS_ASSUME_NONNULL_END
