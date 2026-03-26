//
//  XTMyVC.m
//  XTApp
//
//  Created by xia on 2024/9/4.
//

#import "XTMyVC.h"
#import "XTMyHeadView.h"
#import "XTMyViewModel.h"
#import "XTMyModel.h"
#import "XTExtendListModel.h"
#import "XTRepaymentModel.h"
#import "XTOrderVC.h"

@interface XTMyVC ()

@property(nonatomic,strong) XTMyViewModel *viewModel;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) XTMyHeadView *headView;

@end

@implementation XTMyVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    @weakify(self)
    [self.viewModel xt_home:^{
        @strongify(self)
        [self xt_UI];
    } failure:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.xt_bkBtn.hidden = YES;
    self.view.backgroundColor = XT_RGB(0xF2F5FA, 1.0f);
    UIButton *setBtn = [UIButton new];
    [setBtn setImage:XT_Img(@"xt_my_set_logo") forState:UIControlStateNormal];
    [self.xt_navView addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.xt_navView);
        make.centerY.equalTo(self.xt_bkBtn);
    }];
    @weakify(self)
    setBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [self.navigationController pushViewController:XT_Controller_Init(@"XTSetVC") animated:YES];
        return [RACSignal empty];
    }];
}

-(void)xt_UI {
    if([_scrollView superview]) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
    }
    if([self.headView superview]) {
        [self.headView removeFromSuperview];
        self.headView = nil;
    }
    [self.view addSubview:self.scrollView];
    self.xt_navView.backgroundColor = [UIColor clearColor];
    XTMyHeadView *headView = [[XTMyHeadView alloc] init];
    [self.view addSubview:headView];
    headView.model = self.viewModel.myModel;
    [self.view bringSubviewToFront:self.xt_navView];
    self.headView = headView;
    @weakify(self)
    headView.block = ^{
        @strongify(self)
        [self goOrderVC:0];
    };
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(headView.mas_bottom);
    }];
    
    UIView *contentView = [UIView new];
    [self.scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    UIView *lastView;
    
    UIView *orderView = [UIView xt_frame:CGRectMake(0, -6, self.view.width, 162) color:[UIColor clearColor]];
    [contentView addSubview:orderView];
    
    UIImageView *orderBgImg = [UIImageView xt_img:@"xt_my_order_bg" tag:0];
    orderBgImg.image = [XT_Img(@"xt_my_order_bg") stretchableImageWithLeftCapWidth:30 topCapHeight:0];
    [orderView addSubview:orderBgImg];
    [orderBgImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(orderView.mas_left).offset(7);
        make.right.equalTo(orderView.mas_right).offset(-7);
        make.top.bottom.equalTo(orderView);
    }];
    
    UILabel *orderTitLab = [UILabel xt_lab:CGRectZero text:@"Loan Record" font:XT_Font_M(16) textColor:XT_RGB(0x161616, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    [orderView addSubview:orderTitLab];
    [orderTitLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(orderView.mas_left).offset(35);
        make.top.equalTo(orderView.mas_top).offset(18);
        make.height.mas_equalTo(19);
    }];
    
    UIImageView *accImg = [UIImageView xt_img:@"xt_cell_acc" tag:0];
    [orderView addSubview:accImg];
    [accImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(orderView.mas_right).offset(-35);
        make.centerY.equalTo(orderTitLab);
    }];
    
    UILabel *orderSubLab = [UILabel xt_lab:CGRectZero text:@"View All Orders" font:XT_Font_M(14) textColor:XT_RGB(0x565656, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    [orderView addSubview:orderSubLab];
    [orderSubLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(accImg.mas_left).offset(-3);
        make.centerY.equalTo(orderTitLab);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *allBtn = [UIButton new];
    [orderView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(orderSubLab.mas_left);
        make.right.equalTo(orderView.mas_right);
        make.centerY.equalTo(orderSubLab);
        make.height.mas_equalTo(30);
    }];
    allBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [self goOrderVC:0];
        return [RACSignal empty];
    }];
    
    UIButton *leftBtn = [UIButton new];
    [orderView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(orderView);
        make.top.equalTo(orderTitLab.mas_bottom).offset(12);
        make.width.equalTo(orderView.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(113);
    }];
    leftBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [self goOrderVC:0];
        return [RACSignal empty];
    }];
    
    UIImageView *orderItem1Img = [UIImageView xt_img:@"xt_my_order_item_1" tag:0];
    [leftBtn addSubview:orderItem1Img];
    [orderItem1Img mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(leftBtn);
        make.top.equalTo(leftBtn);
    }];
    
    UILabel *orderItem1Lab = [UILabel xt_lab:CGRectZero text:@"Borrowing" font:XT_Font(15) textColor:XT_RGB(0x00302F, 1.0f) alignment:NSTextAlignmentCenter tag:0];
    [leftBtn addSubview:orderItem1Lab];
    [orderItem1Lab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(leftBtn);
        make.top.equalTo(orderItem1Img.mas_bottom);
        make.height.mas_equalTo(21);
    }];
    
    UIButton *rightBtn = [UIButton new];
    [orderView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(orderView);
        make.top.equalTo(orderTitLab.mas_bottom).offset(12);
        make.width.equalTo(orderView.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(113);
    }];
    rightBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [self goOrderVC:1];
        return [RACSignal empty];
    }];
    
    UIImageView *orderItem2Img = [UIImageView xt_img:@"xt_my_order_item_2" tag:0];
    [rightBtn addSubview:orderItem2Img];
    [orderItem2Img mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(rightBtn);
        make.top.equalTo(rightBtn);
    }];
    
    UILabel *orderItem2Lab = [UILabel xt_lab:CGRectZero text:@"Order" font:XT_Font(15) textColor:XT_RGB(0x00302F, 1.0f) alignment:NSTextAlignmentCenter tag:0];
    [leftBtn addSubview:orderItem2Lab];
    [orderItem2Lab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(rightBtn);
        make.top.equalTo(orderItem2Img.mas_bottom);
        make.height.mas_equalTo(21);
    }];
    
    lastView = orderView;
    float space = 0;
    
//    XTRepaymentModel *repayment = [[XTRepaymentModel alloc] init];
//    repayment.xt_date = @"May 1, 2024";
//    repayment.xt_icon = @"https://perajet-ios-test-2024.oss-ap-southeast-6.aliyuncs.com/icon/main_product.png";
//    repayment.xt_product_name = @"Product";
//    repayment.xt_amount = @"₱500,000";
//    repayment.xt_url = @"https://www.baidu.com";
//    self.viewModel.myModel.repayment = repayment;
    if(self.viewModel.myModel.repayment) {
        space = 4;
        UIView *repaymentView = [UIView xt_frame:CGRectZero color:[UIColor clearColor]];
        [contentView addSubview:repaymentView];
        repaymentView.layer.cornerRadius = 16;
        repaymentView.clipsToBounds = YES;
        [repaymentView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(contentView.mas_left).offset(15);
            make.right.equalTo(contentView.mas_right).offset(-15);
            make.top.equalTo(lastView.mas_bottom);
            make.height.mas_equalTo(174);
        }];
        
        [repaymentView.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0xFFBC9B, 1.0f).CGColor,(__bridge id)XT_RGB(0xFFFFFF, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 0.48) size:CGSizeMake(self.view.width - 30, 174)]];
        
        UIImageView *logoImg = [UIImageView xt_img:@"" tag:0];
        [repaymentView addSubview:logoImg];
        [logoImg mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(repaymentView.mas_left).offset(8);
            make.top.equalTo(repaymentView.mas_top).offset(16);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
        
        [logoImg sd_setImageWithURL:[NSURL URLWithString:self.viewModel.myModel.repayment.xt_icon] placeholderImage:XT_Img(@"xt_img_def")];
        
        UIButton *stateBtn = [UIButton xt_btn:@"Overdue payment" font:XT_Font_M(12) textColor:XT_RGB(0xE83B30, 1.0f) cornerRadius:6 tag:0];
        stateBtn.backgroundColor = XT_RGB(0xFFEEED, 1.0f);
        stateBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
        [repaymentView addSubview:stateBtn];
        [stateBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(repaymentView.mas_right).offset(-9);
            make.top.equalTo(repaymentView.mas_top).offset(16);
            make.height.mas_equalTo(24);
        }];
        
        UILabel *nameLab = [UILabel xt_lab:CGRectZero text:self.viewModel.myModel.repayment.xt_product_name font:XT_Font_SD(17) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
        [repaymentView addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(logoImg.mas_right).offset(8);
            make.right.equalTo(stateBtn.mas_left).offset(-5);
            make.centerY.equalTo(logoImg);
        }];
        
        UIView *priceView = [UIView xt_frame:CGRectZero color:[UIColor clearColor]];
        [repaymentView addSubview:priceView];
        [priceView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(repaymentView.mas_left);
            make.top.equalTo(nameLab.mas_bottom).offset(11);
            make.width.equalTo(repaymentView.mas_width).multipliedBy(0.5f);
            make.height.mas_equalTo(52);
        }];
        
        UILabel *priceLab = [UILabel xt_lab:CGRectZero text:self.viewModel.myModel.repayment.xt_amount font:XT_Font_B(22) textColor:XT_RGB(0x030903, 1.0f) alignment:NSTextAlignmentCenter tag:0];
        [priceView addSubview:priceLab];
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(priceView);
            make.top.equalTo(priceView.mas_top);
            make.height.mas_equalTo(26);
        }];
        
        UILabel *priceSubLab = [UILabel xt_lab:CGRectZero text:@"Loan amount" font:XT_Font(15) textColor:XT_RGB(0x676A69, 1.0f) alignment:NSTextAlignmentCenter tag:0];
        [priceView addSubview:priceSubLab];
        [priceSubLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(priceLab);
            make.top.equalTo(priceLab.mas_bottom);
            make.height.mas_equalTo(26);
        }];

        
        
        UIView *dayView = [UIView xt_frame:CGRectZero color:[UIColor clearColor]];
        [repaymentView addSubview:dayView];
        [dayView mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(repaymentView.mas_right);
            make.top.equalTo(nameLab.mas_bottom).offset(11);
            make.width.equalTo(repaymentView.mas_width).multipliedBy(0.5f);
            make.height.mas_equalTo(52);
        }];
        
        UILabel *dayLab = [UILabel xt_lab:CGRectZero text:self.viewModel.myModel.repayment.xt_date font:XT_Font_M(17) textColor:XT_RGB(0x030903, 1.0f) alignment:NSTextAlignmentCenter tag:0];
        [dayView addSubview:dayLab];
        [dayLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(dayView);
            make.top.equalTo(dayView.mas_top);
            make.height.mas_equalTo(26);
        }];
        
        UILabel *daySubLab = [UILabel xt_lab:CGRectZero text:@"Repayment date" font:XT_Font(15) textColor:XT_RGB(0x676A69, 1.0f) alignment:NSTextAlignmentCenter tag:0];
        [dayView addSubview:daySubLab];
        [daySubLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(dayLab);
            make.top.equalTo(dayLab.mas_bottom);
            make.height.mas_equalTo(26);
        }];
        
        UIButton *refundBtn = [UIButton xt_btn:@"Refund" font:XT_Font_M(20) textColor:[UIColor whiteColor] cornerRadius:25 tag:0];
        [repaymentView addSubview:refundBtn];
        [refundBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(repaymentView);
            make.bottom.equalTo(repaymentView.mas_bottom).offset(-13);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(self.view.width - 80);
        }];
        [refundBtn.layer insertSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0xFF0C00, 1.0f).CGColor,(__bridge id)XT_RGB(0xFF9595, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.54, 0.85) endPoint:CGPointMake(0.54, 0) size:CGSizeMake(self.view.width - 80, 50)] atIndex:0];
        refundBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            [[XTRoute xt_share] goHtml:self.viewModel.myModel.repayment.xt_url success:nil];
            return [RACSignal empty];
        }];
        
        lastView = repaymentView;
    }
    
    float itemH = 48;
    float itemTop = 10;
    
    UIView *extendsView = [UIView xt_frame:CGRectZero color:[UIColor whiteColor]];
    [contentView addSubview:extendsView];
    extendsView.layer.cornerRadius = 16;
    extendsView.layer.shadowColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:0.4600].CGColor;
    extendsView.layer.shadowOffset = CGSizeMake(0,2);
    extendsView.layer.shadowOpacity = 1;
    extendsView.layer.shadowRadius = 8;
    [extendsView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(contentView.mas_left).offset(16);
        make.right.equalTo(contentView.mas_right).offset(-16);
        make.top.equalTo(lastView.mas_bottom).offset(space);
        make.height.mas_equalTo(itemH * self.viewModel.myModel.extendLists.count + itemTop * 2);
    }];
    
    for(NSInteger i = 0 ; i < self.viewModel.myModel.extendLists.count ; i ++) {
        XTExtendListModel *model = self.viewModel.myModel.extendLists[i];
        UIButton *view = [UIButton new];
        [extendsView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.right.equalTo(extendsView);
            if(i == 0){
                make.top.equalTo(extendsView.mas_top).offset(itemTop);
            }
            else {
                make.top.equalTo(extendsView.mas_top).offset(itemTop + itemH * i);
            }
            make.height.mas_equalTo(itemH);
        }];
        
        UIImageView *icon = [UIImageView xt_img:@"" tag:0];
        [view addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(view.mas_left).offset(20);
            make.centerY.mas_equalTo(view);
            make.size.mas_equalTo(CGSizeMake(21, 21));
        }];
        
        [icon sd_setImageWithURL:[NSURL URLWithString:model.xt_icon] placeholderImage:XT_Img(@"xt_img_def")];
        
        UIImageView *itemAccImg = [UIImageView xt_img:@"xt_cell_acc" tag:0];
        [view addSubview:itemAccImg];
        [itemAccImg mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(view.mas_right).offset(-21);
            make.centerY.equalTo(view);
        }];
        
        UILabel *itemTitLab = [UILabel xt_lab:CGRectZero text:model.xt_title font:XT_Font(14) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
        [view addSubview:itemTitLab];
        [itemTitLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(icon.mas_right).offset(13);
            make.centerY.mas_equalTo(view);
        }];
        view.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            [[XTRoute xt_share] goHtml:model.xt_url success:nil];
            return [RACSignal empty];
        }];
    }
    
    lastView = extendsView;
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom).offset(20 + XT_Tabbar_Height);
    }];
}

-(void)goOrderVC:(NSInteger)index {
    XTOrderVC *vc = [[XTOrderVC alloc] initWithIndex:index];
    [self.navigationController pushViewController:vc animated:YES];
}

- (XTMyViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [XTMyViewModel new];
    }
    return _viewModel;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
