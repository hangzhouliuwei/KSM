//
//  BagBankSaveConfirmView.h
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagBankSaveConfirmView : UIView
+ (instancetype)createView;
- (void)show;
@property (nonatomic, copy) dispatch_block_t confirmBlock;
@property (nonatomic, copy) dispatch_block_t cancelBlock;
@property (nonatomic, copy) NSString *bank;
@property (nonatomic, copy) NSString *bankNumber;

@end

NS_ASSUME_NONNULL_END
