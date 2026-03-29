//
//  DayPPNormalCardAlert.h
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DayPPNormalCardAlert : UIView
@property (nonatomic, copy) CallBackStr selectBlock;
- (id)initWithData:(nullable NSString *)dateStr title:(NSString *)titleStr;
- (void)show;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
