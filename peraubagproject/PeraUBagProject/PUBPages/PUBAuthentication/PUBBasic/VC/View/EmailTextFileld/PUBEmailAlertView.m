//
//  PUBEmailAlertView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/17.
//

#import "PUBEmailAlertView.h"
#import "EmailAlertListCell.h"
@interface PUBEmailAlertView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) CGFloat  heightMargin;
@property(nonatomic, strong) UIView *tapBgView;
@end

@implementation PUBEmailAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self certUI];
    }
    
    return self;
}

- (void)certUI
{
    [self.tableView registerNib:[UINib nibWithNibName:@"EmailAlertListCell" bundle:nil] forCellReuseIdentifier:@"EmailAlertListCell"];
    [self addSubview:self.tapBgView];
    [self addSubview:self.tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [self.tapBgView addGestureRecognizer:tap];
    
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    self.tableView.y = self.topMargin;
    
    self.heightMargin = _dataArray.count > 4 ?  ((36.f * 4) + 15) : (_dataArray.count * 36.f + 15);
    self.tableView.height = self.heightMargin;
    [self.tableView reloadData];
    if (dataArray.count <= 0){
        [self dismiss];
    }
    
    
}

- (void)showView:(UIView*)view;
{
    self.tableView.y = self.topMargin;
//    UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.anyObject;
//    UIWindow *keyWindow = windowScene.windows.firstObject;
    [view addSubview:self];
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36.f;
}

- (void)cancel
{
    if (self.cancelBlock){
        self.cancelBlock();
    }
}

#pragma mark - lazy
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 0, KSCREEN_WIDTH - 40.f, 96.f) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#494F5D"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView showRadius:8.f];
    }
    return _tableView;
}

- (UIView *)tapBgView{
    if(!_tapBgView){
        _tapBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _tapBgView.backgroundColor = [UIColor clearColor];
    }
    return _tapBgView;
}

@end
