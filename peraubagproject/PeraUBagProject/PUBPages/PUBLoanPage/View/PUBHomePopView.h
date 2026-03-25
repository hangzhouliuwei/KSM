//
//  PUBHomePopView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBHomePopModel;
@interface PUBHomePopView : UIView
@property (nonatomic, copy) ReturnNoneBlock cancelBlock;
@property (nonatomic, copy) ReturnNoneBlock confirmBlock;
- (void)show:(PUBHomePopModel*)model;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
