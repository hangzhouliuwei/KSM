//
//  PesoEnumPicker.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoEnumPicker.h"
#import "PesoEnumPickerCell.h"
#import "PesoBasicModel.h"
@interface PesoEnumPicker()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) UIButton *cancel;
@end
@implementation PesoEnumPicker

- (instancetype)initWithTitleArray:(NSArray<id> *)titles headerTitle:(NSString *)headerTitle
{
    if (self = [super init]) {
        _titles = titles;
        _headerTitle = headerTitle;
        _selectIndex = -1;
        [self setupUI];
    }
    return self;
}
- (void)clickBg{
    [self hiddenWithAnimation];
}
- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
  
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBg)];
    UIView *bg = [[UIView alloc] initWithFrame:self.frame];
    bg.backgroundColor = [UIColor clearColor];
    [bg addGestureRecognizer:tap];

    [self addSubview:bg];
    self.bgView.frame = CGRectMake(0, kScreenHeight - kBottomSafeHeight - 361, kScreenWidth, kBottomSafeHeight + 361);
    [self br_setRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadius:CGSizeMake(24, 24) viewRect:CGRectMake(0, kScreenHeight - kBottomSafeHeight - 361, kScreenWidth, kBottomSafeHeight + 361)];
    [self addSubview:self.bgView];
    
    CGFloat height = [self.headerTitle br_getTextHeight:[UIFont qmui_mediumSystemFontOfSize:17] width:kScreenWidth - 80];
    

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 69)];
    [self.bgView addSubview:header];
    [header br_setGradientColor:ColorFromHex(0xE5FFCB) toColor:ColorFromHex(0xffffff) direction:BRDirectionTypeTopToBottom];
    UILabel *tipLabel = [[UILabel alloc] qmui_initWithFont:[UIFont qmui_mediumSystemFontOfSize:17] textColor:ColorFromHex(0x0B2C04)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    tipLabel.frame = CGRectMake(40, 16.f, kScreenWidth - 80, height);
    tipLabel.text = self.headerTitle;
    [self.bgView addSubview:tipLabel];
    header.height = height + 30;
    
    QMUIButton *closeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"baisc_single_close"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(kScreenWidth - 40.f, 10.f, 25.f, 25.f);
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:closeBtn];
    closeBtn.centerY = tipLabel.centerY;
    
    self.tableView.frame = CGRectMake(0, header.height + 5, kScreenWidth, self.bgView.height - header.height -5);
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
- (void)closeBtnClick{
    [self hiddenWithAnimation];
}
#pragma mark - table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PesoEnumPickerCell *cell  =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PesoEnumPickerCell.class)];
    id model = self.titles[indexPath.section];
    if ([model isKindOfClass: PesoBaseModel.class]) {
        PesoBasicEnumModel *enumModel = (PesoBasicEnumModel *)model;
        [cell updateUIWithModel:enumModel.uporthirteennNc isSelected:indexPath.section == self.selectIndex];
    }
    if ([model isKindOfClass:[NSString class]]) {
        [cell updateUIWithModel:model isSelected:indexPath.section == self.selectIndex];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.section;
    [self.tableView reloadData];
    id model = self.titles[indexPath.section];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.clickBlock) {
            self.clickBlock(model);
        }
        [self hiddenWithAnimation];
    });
}
#pragma mark - gatter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PesoEnumPickerCell class] forCellReuseIdentifier:NSStringFromClass(PesoEnumPickerCell.class)];
   
    }
    return _tableView;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor br_colorWithRGB:0xffffff];
    }
    return _bgView;
}
- (void)dealloc
{
    
}

@end
