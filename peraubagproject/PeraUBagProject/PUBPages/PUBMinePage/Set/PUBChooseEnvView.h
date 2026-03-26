//
//  PUBChooseEnvView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/5/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBChooseEnvView : UIView
- (void)show;
@property(nonatomic, copy) ReturnBoolBlock clickBlock;
@end

NS_ASSUME_NONNULL_END
