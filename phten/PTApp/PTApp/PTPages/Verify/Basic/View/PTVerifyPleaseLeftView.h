//
//  PTVerifyPleaseLeftView.h
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTVerifyPleaseLeftView : UIView
@property (nonatomic, assign) NSInteger step;//1 基础 2 联系人 3 身份 4 活体 5 银行卡
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) dispatch_block_t confirmBlock;
@property (nonatomic, copy) dispatch_block_t cancelBlock;

- (void)show;
@end

NS_ASSUME_NONNULL_END
