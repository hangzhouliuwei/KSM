//
//  PesoOrderItemVC.h
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoBaseVC.h"
#import <JXCategoryView.h>
NS_ASSUME_NONNULL_BEGIN

@interface PesoOrderItemVC : UIViewController<JXCategoryListContentViewDelegate>
@property(nonatomic, assign) NSInteger  tag;
@end

NS_ASSUME_NONNULL_END
