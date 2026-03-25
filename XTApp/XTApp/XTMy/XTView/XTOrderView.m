//
//  XTOrderView.m
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import "XTOrderView.h"
#import "XTOrderListApi.h"
#import "XTOrderModel.h"
#import "XTOrderCell.h"
#import "XTVerifyViewModel.h"

@interface XTOrderView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy) NSString *xt_order_type;
@property(nonatomic,strong) XTOrderListApi *api;
@property(nonatomic,strong) NSMutableArray <XTOrderModel *>*list;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *emptyView;
@property(nonatomic,strong) XTVerifyViewModel *viewModel;

@end

@implementation XTOrderView

- (instancetype)initWithFrame:(CGRect)frame xt_order_type:(NSString *)xt_order_type {
    self = [super initWithFrame:frame];
    if(self) {
        self.xt_order_type = xt_order_type;
        self.api.xt_order_type = xt_order_type;
        [self xt_list];
        
        [self addSubview:self.tableView];
        [self addSubview:self.emptyView];
    }
    return self;
}

-(void)xt_reload {
    self.api.xt_page_num = 1;
    [self xt_list];
}

-(void)xt_list {
    [XTUtility xt_showProgress:self message:@"loading..."];
    @weakify(self)
    [self.api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if(self.api.xt_page_num == 1){
            [self.list removeAllObjects];
        }
        if([dic isKindOfClass:[NSDictionary class]] && [dic[@"xathsixosisNc"] isKindOfClass:[NSArray class]]) {
            self.api.xt_page_num ++;
            NSArray <XTOrderModel *>*arr = [NSArray yy_modelArrayWithClass:XTOrderModel.class json:dic[@"xathsixosisNc"]];
            [self.list addObjectsFromArray:arr];
            if(arr.count != self.api.xt_page_size) {
                self.tableView.mj_footer.hidden = YES;
            }
            else {
                self.tableView.mj_footer.hidden = NO;
            }
        }
        if(self.list.count == 0){
            self.emptyView.hidden = NO;
        }
        else{
            self.emptyView.hidden = YES;
        }
        [self.tableView reloadData];
        
    } failure:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self];
        [XTUtility xt_showTips:str view:self];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } error:^(NSError * _Nonnull error) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"XTOrderCell";
    XTOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[XTOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    XTOrderModel *model = self.list[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XTOrderModel *model = self.list[indexPath.row];
    if([NSString xt_isValidateUrl:model.xt_loanDetailUrl]) {
        [[XTRoute xt_share] goHtml:model.xt_loanDetailUrl success:nil];
        return;
    }
//    if(model.xt_showVerification) {
//        [[XTRoute xt_share] goVerifyList:model.xt_productId];
//        return;
//    }
    @weakify(self)
    [XTUtility xt_showProgress:self message:@"loading..."];
    [self.viewModel xt_detail:model.xt_productId success:^(NSString * _Nonnull code, NSString * _Nonnull orderId) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self];
        if(![NSString xt_isEmpty:code]) {
            [[XTRoute xt_share] goVerifyItem:code productId:model.xt_productId orderId:orderId success:nil];
        }
        else {
            [self xt_push_productId:model.xt_productId orderId:orderId];
        }
        
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self];
    }];
}
-(void)xt_push_productId:(NSString *)productId orderId:(NSString *)orderId {
    [XTUtility xt_showProgress:self message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_push:orderId success:^(NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self];
        [[XTRoute xt_share] goHtml:str success:^(BOOL success) {
        }];
        
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self];
    }];
}


- (XTOrderListApi *)api {
    if(!_api) {
        _api = [[XTOrderListApi alloc] init];
    }
    return _api;
}

- (NSMutableArray<XTOrderModel *> *)list {
    if(!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

#pragma mark 列表
- (UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//如果cell不能铺满屏幕，下面的分割线没有
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, XT_Bottom_Height + 22, 0);
        @weakify(self)
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            self.api.xt_page_num = 1;
            [self xt_list];
        }];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self xt_list];
        }];
        // 默认先隐藏footer
        tableView.mj_footer.hidden = YES;
        _tableView = tableView;
    }
    return _tableView;
}

- (UIView *)emptyView {
    if(!_emptyView) {
        UIView *view = [UIView xt_frame:CGRectMake(0, 0, self.width, self.height) color:[UIColor clearColor]];
        
        UIButton *btn = [UIButton xt_btn:@"Apply Now" font:XT_Font_M(20) textColor:XT_RGB(0x010000, 1.0f) cornerRadius:25 tag:0];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(40);
            make.right.equalTo(view.mas_right).offset(-40);
            make.top.equalTo(view.mas_centerY);
            make.height.equalTo(@50);
        }];
        [btn.layer insertSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0x02CC56, 1.0f).CGColor,(__bridge id)XT_RGB(0xC6FF95, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.54, 0.85) endPoint:CGPointMake(0.54, 0) size:CGSizeMake(XT_Screen_Width - 80, 50)] atIndex:0];
        @weakify(self)
        btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(self.block) {
                self.block();
            }
            return [RACSignal empty];
        }];
        
        UILabel *titLab = [UILabel xt_lab:CGRectZero text:@"You have no order record" font:XT_Font(18) textColor:XT_RGB(0x999999, 1.0f) alignment:NSTextAlignmentCenter tag:0];
        [view addSubview:titLab];
        [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.bottom.equalTo(btn.mas_top).offset(-22);
            make.height.equalTo(@25);
        }];
        
        UIImageView *img = [UIImageView xt_img:@"xt_order_empty_logo" tag:0];
        [view addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.bottom.equalTo(titLab.mas_top).offset(-22);
        }];
        view.hidden = YES;
        _emptyView = view;
    }
    return _emptyView;
}

- (XTVerifyViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [[XTVerifyViewModel alloc] init];
    }
    return _viewModel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
