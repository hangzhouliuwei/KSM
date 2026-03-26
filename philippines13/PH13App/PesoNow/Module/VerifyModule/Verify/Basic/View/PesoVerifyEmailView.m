//
//  PesoVerifyEmailView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/14.
//

#import "PesoVerifyEmailView.h"
#import "PesoVerifyEmailViewCell.h"
@interface PesoVerifyEmailView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *tapBgView;
@property (nonatomic, assign) NSInteger selectIndex;
@end
@implementation PesoVerifyEmailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setupUI];
        self.selectIndex = -1;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.tapBgView];
    [self addSubview:self.tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [self.tapBgView addGestureRecognizer:tap];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    self.tableView.mj_y = self.topMargin;
    self.tableView.height = _dataArray.count > 4 ?  ((48.f * 4) + 15) : (_dataArray.count * 48.f );;
    [self.tableView reloadData];
    if (dataArray.count <= 0){
        [self dismiss];
    }
}

- (void)showView:(UIView*)view;
{
    self.tableView.mj_y = self.topMargin;
    
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
    PesoVerifyEmailViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PesoVerifyEmailViewCell" forIndexPath:indexPath];
    [cell configtile:self.dataArray[indexPath.row] indx:indexPath.row isSelect:self.selectIndex == indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _dataArray.count){
        self.selectIndex = indexPath.row;
        [self.tableView reloadData];
        if (self.selectBlock){
            self.selectBlock(self.dataArray[indexPath.row]);
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.f;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, 192.f) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        _tableView.layer.cornerRadius = 16;
//        _tableView.layer.masksToBounds = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:PesoVerifyEmailViewCell.class forCellReuseIdentifier:NSStringFromClass(PesoVerifyEmailViewCell.class)];
        [_tableView br_setBorderType:BRBorderSideTypeAll borderColor:[UIColor qmui_colorWithHexString:@"#D9E0E6"] borderWidth:1];
        [_tableView br_setLayerShadowColor:[UIColor qmui_colorWithHexString:@"#6E7882"] offset:CGSizeMake(0, 4) radius:4];
    }
    return _tableView;
}

- (UIView *)tapBgView{
    if(!_tapBgView){
        _tapBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _tapBgView.backgroundColor = [UIColor clearColor];
    }
    return _tapBgView;
}
- (void)dealloc
{
    
}

@end
