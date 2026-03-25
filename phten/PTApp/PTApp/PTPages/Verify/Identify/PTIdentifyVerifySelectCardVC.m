//
//  PTIdentifyVerifySelectCardVC.m
//  PTApp
//
//  Created by Jacky on 2024/8/25.
//

#import "PTIdentifyVerifySelectCardVC.h"
#import "PTIdentifyVerifySelectCardCell.h"
#import "PTIdentifyModel.h"
@interface PTIdentifyVerifySelectCardVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PTIdentifyVerifySelectCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showtitle:@"Upload Photos" isLeft:YES disPlayType:PTDisplayTypeBlack];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarAndStatusBarHeight + 20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    [self.tableView reloadData];
}
   
- (void)setData:(NSArray<PTIdentifyListModel *> *)data
{
    _data = data;
    [self.tableView reloadData];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTIdentifyListModel *model = self.data[indexPath.row];
    PTIdentifyVerifySelectCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PTIdentifyVerifySelectCardCell.class)];
    [cell configUIWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56+(kScreenWidth-32)/342*219;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTIdentifyListModel *model = self.data[indexPath.row];
    if (self.selectBlock) {
        self.selectBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PTIdentifyVerifySelectCardCell class] forCellReuseIdentifier:NSStringFromClass(PTIdentifyVerifySelectCardCell.class)];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}
@end
