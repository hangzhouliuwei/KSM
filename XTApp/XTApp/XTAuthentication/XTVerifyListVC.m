//
//  XTVerifyListVC.m
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import "XTVerifyListVC.h"
#import "XTVerifyViewModel.h"
#import "XTVerifyListModel.h"

@interface XTVerifyListVC ()

@property(nonatomic,strong) XTVerifyViewModel *viewModel;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,strong) UIScrollView *scrollView;

@end

@implementation XTVerifyListVC

- (instancetype)initWithProductId:(NSString *)productId {
    self = [super init];
    if(self) {
        self.productId = productId;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self xt_detail:NO showProgress:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)xt_detail:(BOOL)goNext showProgress:(BOOL)showProgress{
    @weakify(self)
    if(showProgress){
        [XTUtility xt_showProgress:self.view message:@"loading..."];
    }
    
    [self.viewModel xt_detail:self.productId success:^(NSString * _Nonnull code, NSString * _Nonnull orderId) {
        @strongify(self)
        if(showProgress){
            [XTUtility xt_atHideProgress:self.view];
        }
        self.orderId = orderId;
        [self xt_UI];
        if(goNext && ![NSString xt_isEmpty:code]) {
            [[XTRoute xt_share] goVerifyItem:code productId:self.productId orderId:self.orderId success:nil];
        }
        else if(goNext) {
            [self xt_push];
        }
    } failure:^{
        if(showProgress){
            [XTUtility xt_atHideProgress:self.view];
        }
    }];
}

-(void)xt_push {
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_push:self.orderId success:^(NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [[XTRoute xt_share] goHtml:str success:^(BOOL success) {
            @strongify(self)
            if(success){
                [self xt_removeSelf];
            }
        }];
        
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}
-(void)xt_removeSelf {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [arr removeObject:self];
    self.navigationController.viewControllers = arr;
}
-(void)xt_UI{
    @weakify(self)
    if(_scrollView) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
    }
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.xt_navView.mas_bottom);
    }];
    
    UIView *contentView = [UIView new];
    [self.scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    UIView *lastView;
    
    UIView *topView = [UIView xt_frame:CGRectZero color:XT_RGB(0x0BB559, 1.0f)];
    [contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.top.equalTo(contentView);
    }];
    lastView = topView;
    
    UIImageView *topImg = [UIImageView xt_img:@"xt_verify_list_top_bg" tag:0];
    [topView addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(topView.mas_top).offset(14);
        make.left.right.bottom.equalTo(topView);
    }];
    
    UIView *bgView = [UIView xt_frame:CGRectZero color:[UIColor redColor]];
    bgView.layer.cornerRadius = 20;
    bgView.clipsToBounds = YES;
    [contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(topView.mas_bottom).offset(-25);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(555);
    }];
    [bgView.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0xF3FF9B, 1.0f).CGColor,(__bridge id)XT_RGB(0xFFFFFF, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 0.48) size:CGSizeMake(self.view.width, 555)]];
    lastView = bgView;
    
    BOOL haveSuccess = NO;
    
    for(NSInteger i = 0 ; i < self.viewModel.list.count ; i ++) {
        XTVerifyListModel *model = self.viewModel.list[i];
        UIButton *btn = [UIButton new];
        [contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make){
            if(i == 0){
                make.top.equalTo(lastView.mas_top).offset(7);
            }
            else {
                make.top.equalTo(lastView.mas_bottom).offset(4);
            }
            make.left.right.equalTo(contentView);
            make.height.mas_equalTo(92);
        }];
        
        UIImageView *bgImg = [UIImageView xt_img:@"xt_verify_list_item_bg" tag:0];
        [btn addSubview:bgImg];
        [bgImg mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.bottom.equalTo(btn);
            make.left.equalTo(btn.mas_left).offset(7);
            make.right.equalTo(btn.mas_right).offset(-7);
        }];
        
        UIImageView *logoImg = [UIImageView new];
        [btn addSubview:logoImg];
        [logoImg mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(btn.mas_top).offset(32);
            make.left.equalTo(btn.mas_left).offset(25);
            make.size.mas_equalTo(CGSizeMake(42, 42));
        }];
        [logoImg sd_setImageWithURL:[NSURL URLWithString:model.doabsixleNc] placeholderImage:XT_Img(@"xt_img_def")];
        
        UIImageView *tagImg = [UIImageView xt_img:@"xt_cell_acc" tag:0];
        [btn addSubview:tagImg];
        [tagImg mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(logoImg);
            make.right.equalTo(btn.mas_right).offset(-25);
        }];
        if(model.frllsixyNc) {
            tagImg.image = XT_Img(@"xt_cell_sure");
            haveSuccess = YES;
        }
        
        UILabel *lab = [UILabel xt_lab:CGRectZero text:[NSString stringWithFormat:@"%ld.%@",i+1,model.fldgsixeNc] font:XT_Font_M(16) textColor:XT_RGB(0x161616, 1.0f) alignment:NSTextAlignmentLeft tag:0];
        [btn addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(logoImg);
            make.left.equalTo(logoImg.mas_right).offset(15);
            make.right.equalTo(tagImg.mas_left).offset(-5);
        }];
        
        btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(model.frllsixyNc) {
                [[XTRoute xt_share] goVerifyItem:model.noassixsessabilityNc productId:self.productId orderId:self.orderId success:nil];
            }
            else {
                [self xt_detail:YES showProgress:YES];
            }
            return [RACSignal empty];
        }];
        
        lastView = btn;
    }
    
    UIButton *submitBtn = [UIButton xt_btn:@"Apply" font:XT_Font_B(20) textColor:[UIColor whiteColor] cornerRadius:24 tag:0];
    [contentView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(lastView.mas_bottom).offset(18);
        make.left.equalTo(contentView.mas_left).offset(20);
        make.right.equalTo(contentView.mas_right).offset(-20);
        make.height.mas_equalTo(48);
    }];
    submitBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [self xt_detail:YES showProgress:YES];
        return [RACSignal empty];
    }];
    if(haveSuccess) {
        submitBtn.backgroundColor = XT_RGB(0x02CC56, 1.0f);
    }
    else {
        submitBtn.backgroundColor = XT_RGB(0xD9D9D9, 1.0f);
    }
    
    lastView = submitBtn;
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom).offset(20 + XT_Bottom_Height);
    }];
}

- (UIScrollView *)scrollView {
    if(!_scrollView){
        _scrollView = [UIScrollView new];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (XTVerifyViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [XTVerifyViewModel new];
    }
    return _viewModel;
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
