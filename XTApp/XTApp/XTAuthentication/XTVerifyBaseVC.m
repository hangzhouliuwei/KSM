//
//  XTVerifyBaseVC.m
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import "XTVerifyBaseVC.h"
#import "XTVerifyViewModel.h"
#import "XTVerifyBaseModel.h"
#import "XTItemsModel.h"
#import "XTListModel.h"
#import "XTNoteModel.h"
#import "XTVerifyHeadView.h"
#import "XTTextCell.h"
#import "XTSelectCell.h"
#import "XTSelectDayView.h"
#import <YFPopView/YFPopView.h>
#import "XTSelectView.h"
#import "XTLocationManger.h"
#import "XTSetAltView.h"

@interface XTVerifyBaseVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) XTVerifyViewModel *viewModel;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *submitBtn;
@property(nonatomic,strong) NSMutableArray *cellList;
@property(nonatomic,copy) NSString *startTime;

@end

@implementation XTVerifyBaseVC

- (instancetype)initWithProductId:(NSString *)productId
                          orderId:(NSString *)orderId {
    self = [super init];
    if(self) {
        self.productId = productId;
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([NSString xt_isEmpty:[XTLocationManger xt_share].xt_longitude] || [NSString xt_isEmpty:[XTLocationManger xt_share].xt_latitude]) {
        [[XTLocationManger xt_share] xt_startLocation];
    }
    self.startTime = [[XTUtility xt_share] xt_nowTimeStamp];
    self.xt_title = @"Basic";
    self.xt_title_color = [UIColor whiteColor];
    self.view.backgroundColor = XT_RGB(0xF7F7F7, 1.0f);
    [self xt_UI];
    @weakify(self)
    [self.viewModel xt_person:self.productId success:^{
        @strongify(self)
        [self creatCell];
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

- (void)xt_UI {
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-XT_Bottom_Height-20);
        make.height.equalTo(@48);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.xt_navView.mas_bottom);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(-20);
    }];
    
    self.tableView.tableHeaderView = [[XTVerifyHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 94) type:XT_Verify_Base];
    
}

-(void)creatCell {
    for(XTItemsModel *sectionModel in self.viewModel.baseModel.items){
        if(sectionModel.xt_more) {
            sectionModel.hiddenChild = YES;
        }
        for(XTListModel *model in sectionModel.list){
            UITableViewCell *cell;
            if([model.xt_cate isEqualToString:@"AASIXTENBG"] || [model.xt_cate isEqualToString:@"AASIXTENBL"]){
                cell = [[XTTextCell alloc] init];
            }
            else{
                cell = [[XTSelectCell alloc] init];
            }
            [self.cellList addObject:cell];
            model.cell = cell;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.baseModel.items.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XTItemsModel *sectionModel = self.viewModel.baseModel.items[section];
    if(sectionModel.xt_more && sectionModel.hiddenChild){
        return 0;
    }
    return sectionModel.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTItemsModel *sectionModel = self.viewModel.baseModel.items[indexPath.section];
    XTListModel *model = sectionModel.list[indexPath.row];
    if([model.xt_cate isEqualToString:@"AASIXTENBG"] || [model.xt_cate isEqualToString:@"AASIXTENBL"]){
        XTTextCell *cell = (XTTextCell *)model.cell;
        cell.model = model;
        return cell;
    }
    XTSelectCell *cell = (XTSelectCell *)model.cell;
    @weakify(self)
    cell.model = model;
    __weak UITableViewCell *weakCell = cell;
    cell.selectBlock = ^(XTDicBlock block) {
        @strongify(self)
        ///选择日期
        if([model.xt_cate isEqualToString:@"AASIXTENBJ"]){
            [self xt_selectDay:model block:^(NSDictionary *dic) {
                @strongify(self)
                [self xt_nextCell:weakCell];
                if(block){
                    block(dic);
                }
            }];
            return;
        }
        [self xt_select:model block:^(NSDictionary *dic) {
            @strongify(self)
            [self xt_nextCell:weakCell];
            if(block){
                block(dic);
            }
        }];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XTItemsModel *sectionModel = self.viewModel.baseModel.items[section];
    UIView *view = [UIView new];
    UILabel *lab = [UILabel xt_lab:CGRectZero text:sectionModel.xt_title font:XT_Font_M(12) textColor:XT_RGB(0x02CC56, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    [view addSubview:lab];
    
    if(section == 0) {
        view.backgroundColor = self.view.backgroundColor;
        
        [view xt_rect:CGRectMake(0, 0, self.view.width, 32) corners:UIRectCornerTopLeft|UIRectCornerTopRight size:CGSizeMake(20, 20)];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(20);
            make.right.equalTo(view.mas_right).offset(-20);
            make.top.equalTo(view.mas_top).offset(10);
            make.height.equalTo(@22);
        }];
    }
    else if(sectionModel.xt_more) {
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(20);
            make.right.equalTo(view.mas_right).offset(-20);
            make.centerY.equalTo(view);
        }];
        view.backgroundColor = XT_RGB(0x02CC56, 1.0f);
        lab.attributedText = [NSString xt_strs:@[sectionModel.xt_title,sectionModel.xt_sub_title] fonts:@[XT_Font_M(14),XT_Font(9)] colors:@[XT_RGB(0xF8FFC7, 1.0f),[UIColor blackColor]]];
        
        NSString *tit = @"More";
        if(!sectionModel.hiddenChild) {
            tit = @"Hidden";
        }
        
        UIButton *moreBtn = [UIButton xt_btn:@"" font:nil textColor:[UIColor blackColor] cornerRadius:5 tag:0];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:tit attributes:@{
            NSFontAttributeName:XT_Font_M(12),
            NSForegroundColorAttributeName:[UIColor blackColor],
            NSUnderlineStyleAttributeName:[NSString stringWithFormat:@"%ld", NSUnderlineStyleSingle],
        }];
        moreBtn.backgroundColor = XT_RGB(0xFDFF00, 1.0f);
        moreBtn.layer.cornerRadius = 5;
        [moreBtn setAttributedTitle:str forState:UIControlStateNormal];
        [view addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view.mas_right).offset(-20);
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(43, 26));
        }];
        @weakify(self)
        moreBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            sectionModel.hiddenChild = !sectionModel.hiddenChild;
            
            for(XTListModel *item in sectionModel.list) {
                item.isHiddenCell = sectionModel.hiddenChild;
            }
            
            [self.tableView reloadData];
            return [RACSignal empty];
        }];
    }
    else {
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(20);
            make.right.equalTo(view.mas_right).offset(-20);
            make.centerY.equalTo(view);
        }];
    }
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    XTItemsModel *sectionModel = self.viewModel.baseModel.items[section];
    if(section == 0) {
        return 32;
    }
    if(sectionModel.xt_more) {
        return 40;
    }
    return 22;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(void)xt_selectDay:(XTListModel *)model block:(XTDicBlock)block{
    XTSelectDayView *view = [[XTSelectDayView alloc] initTit:model.xt_title];
    [view xt_value:model.value];
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:view];
    __weak YFPopView *weakView = popView;
    popView.animationStyle = YFPopViewAnimationStyleBottomToTop;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    view.closeBlock = ^{
        [weakView removeSelf];
    };
    view.sureBlock = ^(NSDictionary *dic) {
        if(block){
            block(dic);
        }
    };
}

-(void)xt_select:(XTListModel *)model block:(XTDicBlock)block {
    XTSelectView *view = [[XTSelectView alloc] initTit:model.xt_title arr:model.noteList];
    [view xt_value:model.value];
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:view];
    __weak YFPopView *weakView = popView;
    popView.animationStyle = YFPopViewAnimationStyleBottomToTop;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    view.closeBlock = ^{
        [weakView removeSelf];
    };
    view.sureBlock = ^(NSDictionary *dic) {
        if(block){
            block(dic);
        }
    };
}

-(void)xt_nextCell:(UITableViewCell *)indexCell {
    NSInteger index = [self.cellList indexOfObject:indexCell];
    if((index + 1) < self.cellList.count) {
        UITableViewCell *nextCell = self.cellList[index + 1];
        if([nextCell isKindOfClass:[XTSelectCell class]]) {
            if(!((XTSelectCell *)nextCell).model.isHiddenCell && [NSString xt_isEmpty:((XTSelectCell *)nextCell).model.value]) {
                [((XTSelectCell *)nextCell) becomeFirst];
            }
        }
        else if([nextCell isKindOfClass:[XTTextCell class]]) {
            if(!((XTTextCell *)nextCell).model.isHiddenCell && [NSString xt_isEmpty:((XTTextCell *)nextCell).model.value]) {
                [((XTTextCell *)nextCell) becomeFirst];
            }
        }
    }
}

-(void)xt_back {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    XTSetAltView *altView = [[XTSetAltView alloc] initWithAlt:@"Are you sure you want to\n leave?"];
    altView.center = self.view.center;
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:altView];
    popView.animationStyle = YFPopViewAnimationStyleFade;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    __weak YFPopView *weakView = popView;
    @weakify(self)
    altView.sureBlock = ^{
        [weakView removeSelf];
        weakView.didDismiss = ^(YFPopView *popView) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        };
    };
    altView.cancelBlock = ^{
        [weakView removeSelf];
    };
}

-(void)goSubmit {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for(XTItemsModel *sectionModel in self.viewModel.baseModel.items){
        for(XTListModel *model in sectionModel.list) {
            if(!model.xt_optional && [NSString xt_isEmpty:model.value]) {
                [XTUtility xt_showTips:model.xt_subtitle view:self.view];
                return;
            }
            if(![NSString xt_isEmpty:model.value]) {
                [dic setObject:XT_Object_To_Stirng(model.value) forKey:XT_Object_To_Stirng(model.xt_code)];
            }
        }
    }
    [dic setObject:XT_Object_To_Stirng(self.productId) forKey:@"lietsixusNc"];
    
    NSDictionary *point = @{
        @"deamsixatoryNc":XT_Object_To_Stirng(self.startTime),
        @"munisixumNc":XT_Object_To_Stirng(self.productId),
        @"hyrasixrthrosisNc":@"22",
        @"boomsixofoNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_latitude),
        @"unulsixyNc":XT_Object_To_Stirng([[XTUtility xt_share] xt_nowTimeStamp]),
        @"cacosixtomyNc":XT_Object_To_Stirng([XTDevice xt_share].xt_idfv),
        @"unevsixoutNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_longitude),
    };
    [dic setObject:point forKey:@"point"];
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_person_next:dic success:^(NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [self goNext:str];
        
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
    
}

-(void)goNext:(NSString *)str{
    
//    if([XTUserManger xt_share].xt_user.xt_is_aduit){
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
    
    @weakify(self)
    if([NSString xt_isEmpty:str]) {
        [XTUtility xt_showProgress:self.view message:@"loading..."];
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
        return;
    }
    [[XTRoute xt_share] goVerifyItem:str productId:self.productId orderId:self.orderId success:^(BOOL success) {
        @strongify(self)
        if(success){
            [self xt_removeSelf];
        }
    }];
}
-(void)xt_removeSelf {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [arr removeObject:self];
    self.navigationController.viewControllers = arr;
}

- (XTVerifyViewModel *)viewModel {
    if(!_viewModel){
        _viewModel = [XTVerifyViewModel new];
    }
    return _viewModel;
}

#pragma mark 列表
- (UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.estimatedRowHeight = 50;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//如果cell不能铺满屏幕，下面的分割线没有
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        _tableView = tableView;
    }
    return _tableView;
}

- (UIButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [UIButton xt_btn:@"Next" font:XT_Font_B(24) textColor:[UIColor whiteColor] cornerRadius:24 tag:0];
        _submitBtn.backgroundColor = XT_RGB(0x02CC56, 1.0f);
        @weakify(self)
        _submitBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [self goSubmit];
            return [RACSignal empty];
        }];
    }
    return _submitBtn;
}

- (NSMutableArray *)cellList {
    if(!_cellList) {
        _cellList = [NSMutableArray array];
    }
    return _cellList;
}

//UIButton *btn = [UIButton new];
//btn.backgroundColor = [UIColor redColor];
//[self.view addSubview:btn];
//[btn mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.center.equalTo(self.view);
//    make.size.mas_equalTo(CGSizeMake(80, 80));
//}];
//@weakify(self)
//btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
//    @strongify(self)
//    [[XTRoute xt_share] goVerifyItem:@"AASIXTENBA" productId:self.productId orderId:self.orderId];
//    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//    [arr removeObject:self];
//    self.navigationController.viewControllers = arr;
//    return [RACSignal empty];
//}];

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
