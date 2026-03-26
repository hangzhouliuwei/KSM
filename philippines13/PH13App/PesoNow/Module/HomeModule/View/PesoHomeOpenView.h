//
//  PesoHomeOpenView.h
//  PesoApp
//
//  Created by Jacky on 2024/9/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoHomeOpenView : UIView
@property (nonatomic, copy) dispatch_block_t clickBlock;
- (void)updatePopWithIconURL:(NSString *)url;
- (void)show;
@end

NS_ASSUME_NONNULL_END
