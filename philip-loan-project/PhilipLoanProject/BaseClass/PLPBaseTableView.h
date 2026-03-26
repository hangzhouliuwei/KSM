//
//  BaseTableView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/25.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PLPBaseTableView : UITableView<JXCategoryListContentViewDelegate>

@property(nonatomic)NSInteger pageIndex;
@property(nonatomic)UIView *tipView;
@property(nonatomic)NSString *type;
@property(nonatomic,strong)NSMutableArray *dataList;

@property(nonatomic,copy)void(^applyButtonBlk)(void);


@end

NS_ASSUME_NONNULL_END
