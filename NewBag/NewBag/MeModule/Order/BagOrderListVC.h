//
//  BagOrderListVC.h
//  NewBag
//
//  Created by Jacky on 2024/4/1.
//

#import "BagBaseVC.h"
#import <JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagOrderListVC : BagBaseVC<JXCategoryListContentViewDelegate>
@property(nonatomic, assign) NSInteger  tag;

@end

NS_ASSUME_NONNULL_END
