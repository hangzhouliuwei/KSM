//
//  PPNormalCardOrderPage.h
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import "PPBasePageController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPNormalCardOrderPage : PPBasePageController
@property (nonatomic, assign) NSInteger selectTabIndex;
@property (nonatomic, copy) NSString *orderType;
@end

NS_ASSUME_NONNULL_END
