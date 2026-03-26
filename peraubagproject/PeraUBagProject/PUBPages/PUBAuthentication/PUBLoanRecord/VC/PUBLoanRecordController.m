//
//  PUBLoanRecordController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import "PUBLoanRecordController.h"
#import "PUBLoanRecordCell.h"
#import "PUBLoanViewModel.h"
#import "PUBProductDetailModel.h"

@interface PUBLoanRecordController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) QMUIButton *nextBtn;
@property(nonatomic, strong) UIImageView *nextTopImageView;
@property(nonatomic, strong) QMUILabel *tipLabel;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) PUBLoanViewModel *viewModel;
@property(nonatomic, strong) PUBProductDetailModel *model;
@end

@implementation PUBLoanRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.navBar.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    [self.navBar showtitle:@"Loan Record" isLeft:YES];
    [self creatUI];
    [self reponseData];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reponseData];
}

- (void)backBtnClick:(UIButton *)btn
{
    [self.navigationController qmui_popViewControllerAnimated:YES completion:nil];
}

- (void)creatUI
{
    self.contentView.height = KSCREEN_HEIGHT - self.navBar.bottom;
    [self.contentView addSubview:self.nextTopImageView];
    [self.contentView addSubview: self.tipLabel];
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.nextBtn];
    
}

- (void)reponseData
{
    NSDictionary *dic = @{
                          @"perikaryon_eg": NotNull(self.productId),
                          };
    WEAKSELF
    [self.viewModel getProductDetailView:self.view dic:dic finish:^(PUBProductDetailModel * _Nonnull detailModel) {
        STRONGSELF
        strongSelf.model = detailModel;
        [strongSelf.collectionView reloadData];
    } failture:^{
        
    }];
}

- (void)nexBtnCkick
{
    if([PUBTools isBlankString:self.model.specifiable_eg.excuse]){
        [self orderGenJinRequest];
        return;
    }
    
    [PUBRouteManager routeWitheNextPage:self.model.specifiable_eg.excuse productId:NotNull(self.productId)];
}

- (void)orderGenJinRequest
{
    Config.hypokinesis_eg = NotNull(self.model.hexobiose_eg.checker_eg);
    NSDictionary *dic = @{
                          @"order_no":NotNull(self.model.hexobiose_eg.checker_eg),
                          @"furnisher_eg":@"dddd",
                          @"billyboy_eg":@"houijhyus",
                         };
    WEAKSELF
    [self.viewModel getproductPushView:self.view dic:dic finish:^(NSString * _Nonnull url) {
        STRONGSELF
        [PUBRouteManager routeWitheNextPage:url productId:@""];
        [strongSelf removeViewController];
    } failture:^{
        
    }];
}

- (void)removeViewController
{
    NSMutableArray *VCArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [VCArr removeObject:self];
    self.navigationController.viewControllers =VCArr;
}

#pragma mark - UICollectionViewDelegate UICollectionViewDataSource UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.allochthonous_eg.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(KSCREEN_WIDTH/2.f, 140.f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *basecell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    if (indexPath.row >= self.model.allochthonous_eg.count) {
        return basecell;
    }
    PUBLoanRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PUBLoanRecordCellID" forIndexPath:indexPath];
    [cell configModel:[self.model.allochthonous_eg objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PUBVerifyItemModel *model = [self.model.allochthonous_eg objectAtIndex:indexPath.row];
    if(model.vertebration_eg){
        [PUBRouteManager routeWitheNextPage:model.kumpit_eg productId:NotNull(self.productId)];
    }else{
        [PUBRouteManager routeWitheNextPage:self.model.specifiable_eg.excuse productId:NotNull(self.productId)];
    }
    
}



#pragma mark - lazy
- (QMUIButton *)nextBtn{
    if(!_nextBtn){
        _nextBtn = [QMUIButton buttonWithType:UIButtonTypeSystem];
        [_nextBtn addTarget:self action:@selector(nexBtnCkick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.frame = CGRectMake(32.f,self.contentView.height - KSafeAreaBottomHeight - 48.f, KSCREEN_WIDTH - 64.f, 48.f);
        _nextBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
        _nextBtn.cornerRadius = 24.f;
        _nextBtn.titleLabel.font = FONT(20.f);
        [_nextBtn setTitle:@"Apply now" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#13062A"] forState:UIControlStateNormal];
    }
    return _nextBtn;
}

- (UIImageView *)nextTopImageView{
    if(!_nextTopImageView){
        _nextTopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_loanRecord_next"]];
        _nextTopImageView.frame = CGRectMake(20.f, 8, KSCREEN_WIDTH - 40.f , 83.f);
        _nextTopImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _nextTopImageView;
}

-(QMUILabel *)tipLabel{
    if(!_tipLabel){
        _tipLabel = [[QMUILabel alloc] qmui_initWithFont:FONT(12.f) textColor:[UIColor whiteColor]];
        _tipLabel.frame = CGRectMake(20.f, _nextTopImageView.bottom + 24.f, KSCREEN_WIDTH - 40.f, 36.f);
        _tipLabel.textAlignment = NSTextAlignmentLeft;
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = @"complete the informa below, and help to determin your servics";
    }
    return _tipLabel;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 12;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.tipLabel.bottom + 20.f, KSCREEN_WIDTH, self.contentView.height - self.nextBtn.height - KSafeAreaBottomHeight - self.tipLabel.bottom - 20.f) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        [_collectionView registerClass:[PUBLoanRecordCell class] forCellWithReuseIdentifier:@"PUBLoanRecordCellID"];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1D2B"];
    }
    return _collectionView;
}

- (PUBLoanViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PUBLoanViewModel alloc] init];
    }
    return _viewModel;
}

@end
