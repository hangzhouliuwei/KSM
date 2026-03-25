//
//  PUBSetView.h
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBSetView : UIView

+(instancetype)createSetView;

@property (nonatomic, copy) dispatch_block_t logoutBlock;
@property (nonatomic, copy) dispatch_block_t cancelBlock;
@property(nonatomic, copy) ReturnNoneBlock logImageBlock;

@end

NS_ASSUME_NONNULL_END
