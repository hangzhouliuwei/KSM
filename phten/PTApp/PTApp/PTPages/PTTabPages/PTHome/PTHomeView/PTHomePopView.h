//
//  PTHomePopView.h
//  PTApp
//
//  Created by Jacky on 2024/8/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTHomePopView : UIView
@property (nonatomic, copy) PTBlock clickBlock;
- (void)updatePopWithIconURL:(NSString *)url;
- (void)show;
@end

NS_ASSUME_NONNULL_END
