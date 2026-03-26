//
//  EmailAlertView.h
//  DailyLoan
//
//  Created by gqshHD on 2023/8/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmailAlertView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *tapBgView;
@property (weak, nonatomic) IBOutlet UIView *conView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightMargin;

///
@property (nonatomic,strong) NSArray * dataArray;

///
@property (nonatomic,copy)void (^selectBlock)(NSString * title);

@property (nonatomic,copy)void (^cancelBlock)(void);

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
