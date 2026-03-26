//
//  EmailPopView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmailPopView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)UITableView *tableView;
@property(nonatomic)NSMutableArray *dataSource;


@property(nonatomic)void(^tapItemBlk)(NSString *emailAddress);

-(void)reloadEmaiViewWithStr:(NSString *)valueStr;

@end

NS_ASSUME_NONNULL_END
