//
//  AuthCertificationController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/6.
//

#import "PLPAuthCertificationController.h"
#import "AuthCertViewCell.h"
#import "AuthCertHeaderReusableView.h"
@interface PLPAuthCertificationController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>


@property(nonatomic)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSDictionary *info;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation PLPAuthCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Certifcation";
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchInterNetInfo];
}
-(void)BASE_GenerateSubview
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 283);
    gradientLayer.colors = @[
        (__bridge id)kBlueColor_0053FF.CGColor,  // #2964F6
        (__bridge id)kHexColor(0xF5F5F5).CGColor   // #F9F9F9
    ];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(14, kScreenH - 47 - kBottomSafeHeight - 16, kScreenW - 28, 47);
    [nextButton setTitle:@"Apply" forState:UIControlStateNormal];
    [nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    nextButton.backgroundColor = kBlueColor_0053FF;
    nextButton.layer.cornerRadius = nextButton.height / 2.0;
    [nextButton addTarget:self action:@selector(handleNextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, kTopHeight + 16, kScreenW - 30, nextButton.top - 10 - (kTopHeight + 16)) collectionViewLayout:flowLayout];
    CGFloat itemWidth = (self.collectionView.width - 18 * 2 - 14) / 2.0;
    flowLayout.minimumInteritemSpacing = 14;
    kWeakSelf
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchInterNetInfo];
    }];
    flowLayout.minimumLineSpacing = 18;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 17, 0, 17);
    flowLayout.itemSize = CGSizeMake(itemWidth, 115);
    self.collectionView.layer.cornerRadius = 12;
    _collectionView.backgroundColor = UIColor.whiteColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.collectionView registerClass:[AuthCertViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[AuthCertHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:self.collectionView];
    
    
    
}
-(void)handleNextButtonAction:(UIButton *)button
{
    AuthCertModel *model;
    for (AuthCertModel *temp in self.dataSource) {
        if (!temp.frlltwelveyNc) {
            model = temp;
            break;
        }
    }
    if (model) {
        Class cls = NSClassFromString([PLPDataManager manager].controllerMap[model.noastwelvesessabilityNc]);
        PLPBaseViewController *vc = [cls new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        NSString *orderId = [NSString stringWithFormat:@"%@",self.dataDic[@"leontwelveishNc"][@"coketwelvetNc"]];
        if ([self.dataDic[@"heistwelvetopNc"] isReal] && [self.dataDic[@"heistwelvetopNc"][@"excuse"] isReal]) {
            [PLPCommondTools pushToPage:self.dataDic[@"heistwelvetopNc"][@"excuse"] productID:[PLPDataManager manager].productId];
            return;
        }
        [PLPDataManager manager].orderId = orderId;
        kShowLoading
        [PLPCommondTools queryURLWithOrderNo:[PLPDataManager manager].orderId];
        return;
    }
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AuthCertViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = _dataSource[indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    AuthCertHeaderReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    if (self.info) {
        view.valueLabel.text = [NSString stringWithFormat:@"%@",[PLPCommondTools formatterUnitValue:self.info[@"geertwelvealitatNc"]]];
        view.tipLabel.text = [NSString stringWithFormat:@"%@",self.info[@"oplitwelveneNc"]];
    }else
    {
        view.valueLabel.text = @"";
        view.tipLabel.text = @"";
    }
    return view;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.width, 230);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AuthCertModel *model = _dataSource[indexPath.row];
    NSString *name = [PLPDataManager manager].controllerMap[model.noastwelvesessabilityNc];
    if ([name isReal]) {
        Class cls = NSClassFromString(name);
        PLPBaseViewController *vc = [cls new];
        vc.shouldPopHome = true;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(void)fetchInterNetInfo
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvenv2/gce/detail" paramsInfo:@{@"liettwelveusNc":[PLPDataManager manager].productId} successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        [self.collectionView.mj_header endRefreshing];
        [self.dataSource removeAllObjects];
        NSDictionary *data = responseObject[@"viustwelveNc"];
        self.info = data[@"leontwelveishNc"];
        for (NSDictionary *dic in data[@"atestwelveiaNc"]) {
            AuthCertModel *model = [AuthCertModel yy_modelWithDictionary:dic];
            [self.dataSource addObject:model];
        }
        [self.collectionView reloadData];
        self.dataDic = data;
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
