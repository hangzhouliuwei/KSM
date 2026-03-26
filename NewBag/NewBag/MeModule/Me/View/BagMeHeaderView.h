//
//  BagMeHeaderView.h
//  NewBag
//
//  Created by Jacky on 2024/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagMeHeaderView : UIView

@property (nonatomic, copy) dispatch_block_t goSettingBlock;
@property (nonatomic, copy) dispatch_block_t goBorringOrderBlock;
@property (nonatomic, copy) dispatch_block_t goAllOrderBlock;

+ (instancetype)createHeader;
- (void)updateUIWithPhone:(NSString *)phone;
@end

NS_ASSUME_NONNULL_END
