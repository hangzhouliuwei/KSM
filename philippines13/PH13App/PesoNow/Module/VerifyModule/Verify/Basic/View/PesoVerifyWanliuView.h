//
//  PesoVerifyWanliuView.h
//  PesoApp
//
//  Created by Jacky on 2024/9/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoVerifyWanliuView : UIView
@property (nonatomic, assign) NSInteger step;//1 基础 2 联系人 3 身份 4 活体 5 银行卡
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) dispatch_block_t confirmBlock;
@property (nonatomic, copy) dispatch_block_t cancelBlock;

- (void)show;
@end

NS_ASSUME_NONNULL_END
