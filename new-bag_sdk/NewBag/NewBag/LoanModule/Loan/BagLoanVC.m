//
//  BagLoanVC.m
//  NewBag
//
//  Created by Jacky on 2024/4/5.
//

#import "BagLoanVC.h"
#import "BagLoanCell.h"
#import "BagHomePresenter.h"
#import "BagLoanPresenter.h"
#import "BagLoanDeatilModel.h"
@interface BagLoanVC ()<UITableViewDelegate,UITableViewDataSource,BagLoanProtocol>
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *greenImageView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BagLoanPresenter *presenter;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) BagLoanDeatilModel *model;
@property (nonatomic, copy) NSArray *dataArray;
@end

@implementation BagLoanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#F4F7FA"];
    
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(267);
    }];
    [self.view addSubview:self.greenImageView];
    [self.greenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.right.mas_equalTo(-14);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.topImageView.mas_bottom);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImageView.mas_bottom);
        make.left.mas_equalTo(14);
        make.right.mas_equalTo(-14);
        make.height.mas_equalTo(463.f);
    }];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.right.mas_equalTo(-14);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.tableView.mas_bottom).offset(-20);
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.presenter sendGetProductDetailRequestWithProductId:self.productId];
}
#pragma mark - next
- (void)onNextClick{
    if ([NotNull(self.model.peacemongerF.nonvoterF) br_isBlankString]) {
        [self.presenter sendOrderPushRequestWithOrderId:BagUserManager.shareInstance.order_numer product_id:self.productId];
        return;
    }
    [[BagRouterManager shareInstance] routeWithUrl:[self.model.peacemongerF.nonvoterF br_pinProductId:self.productId]];
}
#pragma mark - BagHomePresenterProtocol
- (void)updateUIWithModel:(BagLoanDeatilModel *)model
{
    _model = model;
    _dataArray = model.sportyF;
    [self.tableView reloadData];
}
- (void)router:(NSString *)url
{
    [[BagRouterManager shareInstance] routeWithUrl:url];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
- (void)removeViewController
{
    NSMutableArray *VCArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [VCArr removeObject:self];
    self.navigationController.viewControllers =VCArr;
}
#pragma mark - table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BagLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BagLoanCell.class)];
    BagVerifyItemModel *model = self.dataArray[indexPath.row];
    [cell updateUIWithModel:model isLast:indexPath.row == self.dataArray.count- 1 ? YES : NO];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BagVerifyItemModel *model = [self.model.sportyF objectAtIndex:indexPath.row];
    if(model.thermionicF){
        [[BagRouterManager shareInstance] routeWithUrl:[model.nonvoterF br_pinProductId:_productId]];
    }else{
        [[BagRouterManager shareInstance] routeWithUrl:[self.model.peacemongerF.nonvoterF br_pinProductId:_productId]];
    }
}
#pragma mark - getter
- (UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loan_bg"]];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.layer.masksToBounds = YES;
    }
    return _topImageView;
}
- (UIImageView *)greenImageView
{
    if (!_greenImageView) {
        _greenImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loan_green"]];
        _greenImageView.contentMode = UIViewContentModeScaleAspectFill;
        _greenImageView.layer.masksToBounds = YES;
    }
    return _greenImageView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //[_tableView registerClass:[BagLoanCell class] forCellReuseIdentifier:NSStringFromClass(BagLoanCell.class)];
        [_tableView registerNib:[Util getNibFromeBundle:NSStringFromClass(BagLoanCell.class)] forCellReuseIdentifier:NSStringFromClass(BagLoanCell.class)];
        _tableView.scrollEnabled = NO;
        [_tableView br_setRoundedCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, kScreenWidth - 28, 463.f)];
    }
    return _tableView;
}
- (BagLoanPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [BagLoanPresenter new];
        _presenter.delegate = self;
    }
    return _presenter;
}
- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _nextBtn.titleLabel.textColor = [UIColor whiteColor];
        [_nextBtn setTitle:@"Apply" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#205EAC"] toColor:[UIColor qmui_colorWithHexString:@"#154685"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth - 26, 44)];
        [_nextBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, kScreenWidth - 28, 44)];
    }
    return _nextBtn;
}
@end
