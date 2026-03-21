//
//  BagVerifyPickerView.m
//  NewBag
//
//  Created by Jacky on 2024/4/7.
//

#import "BagContactPickerView.h"
#import "BagVerifyPickerCell.h"
#import "BagVerifyContactModel.h"
@interface BagContactPickerView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, assign) NSInteger selectIndex;

@end
@implementation BagContactPickerView

- (instancetype)initWithTitleArray:(NSArray<PUBContactRelationEnumModel *> *)titles headerTitle:(NSString *)header
{
    if (self = [super init]) {
        _titles = titles;
        _headerTitle = header;
        _selectIndex = -1;
        [self setupUI];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBg)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)clickBg{
    [self hiddenWithAnimation];
}
- (void)setupUI{
    self.backgroundColor = [UIColor br_colorWithRGB:0x010E0B alpha:0.5];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.bgView.frame = CGRectMake(0, kScreenHeight - kBottomSafeHeight - 361, kScreenWidth, kBottomSafeHeight + 361);
    [self addSubview:self.bgView];
    
    CGFloat height = [self.headerTitle br_getTextHeight:[UIFont boldSystemFontOfSize:14] width:kScreenWidth - 118];

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    [self.bgView addSubview:header];
    
    UILabel *tipLabel = [[UILabel alloc] qmui_initWithFont:[UIFont boldSystemFontOfSize:14] textColor:[UIColor whiteColor]];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.numberOfLines = 0;
    tipLabel.frame = CGRectMake(20, 15.f, kScreenWidth - 118.f, height);
    tipLabel.text = self.headerTitle;
    [self.bgView addSubview:tipLabel];
    header.height = height + 30;
    
    
    self.tableView.frame = CGRectMake(0, header.height, kScreenWidth, self.bgView.height - header.height);
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.bgView addSubview:self.tableView];
    [self.tableView reloadData];
}
- (void)showWithAnimation{
    CGRect rect = self.bgView.frame;
    self.bgView.frame = CGRectMake(rect.origin.x, kScreenHeight, rect.size.width, rect.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = rect;
    }];
    [UIApplication.sharedApplication.windows.firstObject addSubview:self];
}
- (void)hiddenWithAnimation{
    CGRect rect = self.bgView.frame;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(rect.origin.x, kScreenHeight, rect.size.width, rect.size.height);;
    }completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
#pragma mark - table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BagVerifyPickerCell *cell  =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagVerifyPickerCell.class)];
    PUBContactRelationEnumModel *model = self.titles[indexPath.row];
//    [cell updateUIWithModel:model.uporfourteennNc isSelected:indexPath.row == self.selectIndex];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    [self.tableView reloadData];
    PUBContactRelationEnumModel *model = self.titles[indexPath.row];
    if (self.clickBlock) {
        self.clickBlock(model);
    }
    [self hiddenWithAnimation];
}
#pragma mark - gatter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[BagVerifyPickerCell class] forCellReuseIdentifier:NSStringFromClass(BagVerifyPickerCell.class)];
    }
    return _tableView;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor br_colorWithRGB:0x1E59A2];
    }
    return _bgView;
}
- (void)dealloc
{
    
}
@end
