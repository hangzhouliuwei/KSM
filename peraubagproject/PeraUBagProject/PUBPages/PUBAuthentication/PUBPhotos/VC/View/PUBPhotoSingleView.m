//
//  PUBPhotoSingleView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/9.
//

#import "PUBPhotoSingleView.h"
#import "PUBPhotosModel.h"
#import "PUBSingleCell.h"
@interface PUBPhotoSingleView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UIView *alertView;
@property(nonatomic, copy) NSArray <PUBPhotosHorrificEgModel*>*dataArr;
@property(nonatomic, copy) NSString *title;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,assign) NSInteger index;
@end

@implementation PUBPhotoSingleView

- (void)show {
    CGRect rect = self.alertView.frame;
    self.alertView.frame = CGRectMake(rect.origin.x, SCREEN_HEIGHT, rect.size.width, rect.size.height);
    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        STRONGSELF
        strongSelf.alertView.frame = rect;
    }completion:^(BOOL finished) {
        
    }];
    self.alpha = 1;
    if (IOS_VRESION_13) {
        [TOP_WINDOW addSubview:self];
    }else {
        [[VCManager topViewController].view addSubview:self];
    }
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(instancetype)initWithData:(NSArray<PUBPhotosHorrificEgModel*>*)dataArr title:(NSString *)title
{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
        self.backgroundColor = [[UIColor qmui_colorWithHexString:@"#313848"] colorWithAlphaComponent:0.8f];
        self.title = NotNull(title);
        self.dataArr = dataArr;
        self.index = -1.f;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.alertView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT- 361.f*WScale - KSafeAreaBottomHeight, SCREEN_WIDTH, 361.f*WScale + KSafeAreaBottomHeight)];
    self.alertView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
    [self addSubview:self.alertView];
    [self.alertView showTopRarius:24.f];
    
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 64.f)];
    topBackView.backgroundColor = [UIColor qmui_colorWithHexString:@"#444959"];
    [self.alertView addSubview:topBackView];
    
    CGFloat Hehgit = [PUBTools getTextHeightWithString:self.title font:FONT_BOLD(14.f) maxWidth:KSCREEN_WIDTH - 118.f numOfLines:0];
    UILabel *tipLabel = [[UILabel alloc] qmui_initWithFont:FONT_BOLD(14.f) textColor:[UIColor whiteColor]];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.numberOfLines = 0;
    tipLabel.frame = CGRectMake(20, 15.f, KSCREEN_WIDTH - 118.f, Hehgit);
    tipLabel.text = self.title;
    [topBackView addSubview:tipLabel];
    topBackView.height = 30.f + Hehgit;
    
    QMUIButton *closeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"pub_baisc_single_close"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(KSCREEN_WIDTH - 64.f, 10.f, 60.f, 30.f);
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topBackView addSubview:closeBtn];
    
    
    QMUIButton *nextBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(32.f, self.alertView.height - 48.f*WScale - KSafeAreaBottomHeight, KSCREEN_WIDTH - 64.f, 48.f * WScale);
    nextBtn.cornerRadius = 24.f;
    nextBtn.titleLabel.font = FONT(20.f);
    nextBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
    [nextBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#13062A"] forState:UIControlStateNormal];
    [nextBtn setTitle:@"OK" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:nextBtn];
    
    
    CGFloat tabH = self.alertView.height - 48.f*WScale - KSafeAreaBottomHeight - topBackView.bottom;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topBackView.bottom, SCREEN_WIDTH, tabH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 52;
    self.tableView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.alertView addSubview:self.tableView];
}

- (void)closeBtnClick
{
    [self hide];
}

- (void)nextBtnClick
{
    if(self.index == -1){
        [PUBTools showToast:@"Please select"];
        return;
    }
    if(self.dataArr.count > self.index && self.confirmBlock){
        PUBPhotosHorrificEgModel *model = [self.dataArr objectAtIndex:self.index];
        self.confirmBlock(model);
        [self hide];
    }
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString*cellID = @"PUBSingleCellID";
    PUBSingleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[PUBSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    PUBPhotosHorrificEgModel *model = [self.dataArr objectAtIndex:indexPath.row];
    [cell configPhotosModel:model seleIndex:self.index index:indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.index = indexPath.row;
    [self.tableView reloadData];
}

@end
