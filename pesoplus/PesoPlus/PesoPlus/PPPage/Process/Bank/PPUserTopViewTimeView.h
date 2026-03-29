//
//  PPUserTopViewTimeView.h
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPUserTopViewTimeView : UIView
@property (nonatomic, copy) CallBackNone finishBlock;
- (id)initWithFrame:(CGRect)frame;
- (void)start:(NSInteger)time;
@end

NS_ASSUME_NONNULL_END
