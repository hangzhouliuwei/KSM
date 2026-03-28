//
//  EmailAlertView.m
//  DailyLoan
//
//  Created by gqshHD on 2023/8/24.
//

#import "EmailAlertView.h"
#import "EmailAlertListCell.h"

@implementation EmailAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"EmailAlertView" owner:self options:nil][0];
        self.frame = frame;
        self.conView.backgroundColor = [UIColor clearColor];
        self.tableView.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [self.tapBgView addGestureRecognizer:tap];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 0.01)];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 0.01)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EmailAlertListCell" bundle:nil] forCellReuseIdentifier:@"EmailAlertListCell"];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
        
    [self.tableView reloadData];
    
    self.heightMargin.constant = _dataArray.count > 3 ?  ((27 * 3) + 15) : (_dataArray.count * 27 + 15);
    
    if (dataArray.count <= 0){
        [self dismiss];
    }
    
    
}

- (void)show
{
    UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.anyObject;
    UIWindow *keyWindow = windowScene.windows.firstObject;
    [keyWindow addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

//MARK: - tableViewDelegate / tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmailAlertListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmailAlertListCell" forIndexPath:indexPath];
    [cell configtile:self.dataArray[indexPath.row] indx:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _dataArray.count){
        if (self.selectBlock){
            self.selectBlock(_dataArray[indexPath.row]);
        }
        [self dismiss];
    }
}

- (void)cancel
{
    if (self.cancelBlock){
        self.cancelBlock();
    }
}

@end
