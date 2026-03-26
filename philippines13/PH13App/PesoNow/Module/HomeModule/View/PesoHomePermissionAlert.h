//
//  PesoHomePermissionAlert.h
//  PesoApp
//
//  Created by Jacky on 2024/9/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoHomePermissionAlert : UIView
@property(nonatomic, copy) dispatch_block_t agreeBlock;
@property(nonatomic, copy) NSString *title;
-(void)show;
@end

NS_ASSUME_NONNULL_END
