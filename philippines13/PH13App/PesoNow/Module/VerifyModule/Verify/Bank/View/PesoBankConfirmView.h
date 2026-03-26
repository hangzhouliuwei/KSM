//
//  PesoBankConfirmView.h
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoBankConfirmView : UIView
- (void)show;
@property (nonatomic, copy) dispatch_block_t confirmBlock;
@property (nonatomic, copy) dispatch_block_t cancelBlock;
@property (nonatomic, copy) NSString *bank;
@property (nonatomic, copy) NSString *bankNumber;
@end

NS_ASSUME_NONNULL_END
