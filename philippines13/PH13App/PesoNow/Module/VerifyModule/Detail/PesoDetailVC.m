//
//  PesoDetailVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/12.
//

#import "PesoDetailVC.h"
#import "PesoDetailCollectionCell.h"
#import "PesoHomeViewModel.h"
#import "PesoDetailModel.h"
@interface PesoDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) PesoHomeViewModel *viewModel;
@property (nonatomic, strong) PesoDetailModel *model;
@property (nonatomic, strong) QMUIButton *nextBtn;
@end

@implementation PesoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel loadProductDetailRequest:self.productId callback:^(PesoDetailModel *model) {
        self.model = model;
        [self.collectionView reloadData];
    }];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self bringNavToFront];
}

- (void)createUI
{
    [super createUI];
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_bg"]];
    bgImage.contentMode = UIViewContentModeScaleAspectFill;
    bgImage.frame = CGRectMake(0, 0, kScreenWidth, 340);
    [self.view addSubview:bgImage];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake((kScreenWidth - 30 - 16)/3, 130);
    layout.sectionInset = UIEdgeInsetsMake(20, 15, 0, 15);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 262, kScreenWidth, kScreenHeight - kBottomSafeHeight - 262) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.layer.cornerRadius = 16;
    _collectionView.layer.masksToBounds = YES;
    
    [_collectionView registerClass:[PesoDetailCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass(PesoDetailCollectionCell.class)];
    [self.view addSubview:self.collectionView];
    
    QMUIButton *btn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, kScreenHeight - kBottomSafeHeight - 50 - 30, kScreenWidth-60, 50);;
    btn.centerX = kScreenWidth/2;
    [btn setTitle:@"Apply" forState:UIControlStateNormal];
    btn.backgroundColor = ColorFromHex(0xFCE815);
    btn.titleLabel.font = PH_Font_B(18);
    [btn setTitleColor:ColorFromHex(0x000000) forState:UIControlStateNormal];
    btn.layer.cornerRadius = 25;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)nextClick{
    if (br_isEmptyObject(self.model.heisthirteentopNc.relothirteenomNc)) {
        [self.viewModel loadPushRequestWithOrderId:PesoUserCenter.sharedPesoUserCenter.order product_id:self.productId callback:^(NSString *url) {
            if (br_isEmptyObject(url)) {
                return;
            }
            [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:[url pinProductId:self.productId]];
        }];
        return;
    }
    [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:[self.model.heisthirteentopNc.relothirteenomNc pinProductId:self.productId]];
}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.atesthirteeniaNc.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PesoDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(PesoDetailCollectionCell.class) forIndexPath:indexPath];
    PesoVerifyListModel *model = self.model.atesthirteeniaNc[indexPath.row];
    [cell configUIWithModel:model.doabthirteenleNc];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PesoVerifyListModel *model = self.model.atesthirteeniaNc[indexPath.row];
    //认证完成
    if(model.frllthirteenyNc){
        [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:[model.relothirteenomNc pinProductId:self.productId]];
    }else{
        [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:[self.model.heisthirteentopNc.relothirteenomNc pinProductId:self.productId]];
    }
}
- (PesoHomeViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [PesoHomeViewModel new];
    }
    return _viewModel;
}
@end
