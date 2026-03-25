//
//  XTMyHeadView.h
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XTMyModel;
@interface XTMyHeadView : UIView

@property(nonatomic,weak) XTMyModel *model;

@property(nonatomic,copy) XTBlock block;

@end

NS_ASSUME_NONNULL_END
