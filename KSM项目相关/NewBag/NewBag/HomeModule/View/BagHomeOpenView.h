//
//  BagHomeOpenView.h
//  NewBag
//
//  Created by Jacky on 2024/4/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagHomeOpenView : UIView
+ (instancetype)createView;
- (void)show;
- (void)updateUIWithIconUrl:(NSString *)url;

@property (nonatomic, copy)dispatch_block_t tapBlock;
@end

NS_ASSUME_NONNULL_END
