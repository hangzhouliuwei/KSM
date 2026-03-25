//
//  PTOrderListVC.h
//  PTApp
//
//  Created by Jacky on 2024/8/28.
//

#import "PTBaseVC.h"
#import <JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTOrderListVC : UIViewController<JXCategoryListContentViewDelegate>
@property(nonatomic, assign) NSInteger  tag;

@end

NS_ASSUME_NONNULL_END
