//
//  XTSetVC.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTSetVC.h"
#import "XTCellModel.h"
#import "XTCell.h"
#import "XTLoginOutCell.h"
#import "XTCancelCell.h"
#import "XTSetAltView.h"
#import <YFPopView.h>
#import "XTDelAccountApi.h"
#import "XTLogoutApi.h"

@interface XTSetVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray <XTCellModel *>*list;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation XTSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.xt_backType = XT_BackType_B;
    self.xt_navView.backgroundColor = [UIColor clearColor];
    self.xt_title = @"Set Up";
    UIView *topBGView = [UIView xt_frame:CGRectMake(0, 0, self.view.width, 97 + XT_Nav_Height) color:[UIColor whiteColor]];
    [self.view addSubview:topBGView];
    [self.view bringSubviewToFront:self.xt_navView];
    [topBGView.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0x0BB559, 1.0f).CGColor,(__bridge id)XT_RGB(0xFFFFFF, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 0.6) size:topBGView.size]];
    
    [self.view addSubview:self.tableView];
    [self creatModel];
}

-(void)creatModel {
    
    XTCellModel *model = [XTCellModel xt_cellClassName:@"XTSetIconCell" height:251 model:nil];
    [self.list addObject:model];
    
    model = [XTCellModel xt_cellClassName:@"XTSetCell" height:48 model:@{
        @"title":@"Website",
        @"content":@"https://www.providence-lending-corp.com",
    }];
    [self.list addObject:model];
    
    [self.list addObject:[XTCellModel xt_cellClassName:@"XTSpaceCell" height:20 model:nil]];
    model = [XTCellModel xt_cellClassName:@"XTSetCell" height:48 model:@{
        @"title":@"Email",
        @"content":@"cs@providence-lending-corp.com",
    }];
    [self.list addObject:model];
    
    [self.list addObject:[XTCellModel xt_cellClassName:@"XTSpaceCell" height:20 model:nil]];
    model = [XTCellModel xt_cellClassName:@"XTSetCell" height:48 model:@{
        @"title":@"Edition",
        @"content":XT_App_Version,
    }];
    [self.list addObject:model];
    
    [self.list addObject:[XTCellModel xt_cellClassName:@"XTSpaceCell" height:65 model:nil]];
    
    model = [XTCellModel xt_cellClassName:@"XTLoginOutCell" height:48 model:nil];
    @weakify(self)
    ((XTLoginOutCell *)model.indexCell).block = ^{
        @strongify(self)
        [self nextLoginOut];
    };
    
    [self.list addObject:model];
    
    [self.list addObject:[XTCellModel xt_cellClassName:@"XTSpaceCell" height:22 model:nil]];
    
    model = [XTCellModel xt_cellClassName:@"XTCancelCell" height:48 model:nil];
    ((XTCancelCell *)model.indexCell).block = ^{
        @strongify(self)
        [self nextCancelAccount];
    };
    [self.list addObject:model];
    
    [self.list addObject:[XTCellModel xt_cellClassName:@"XTSpaceCell" height:20 model:nil]];
    
    if(XT_Bottom_Height > 0){
        [self.list addObject:[XTCellModel xt_cellClassName:@"XTSpaceCell" height:XT_Bottom_Height model:nil]];
    }
    
    [self.tableView reloadData];
    
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTCellModel *model = self.list[indexPath.row];
    return model.indexCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XTCellModel *model = self.list[indexPath.row];
    return model.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)nextLoginOut{
    [self showAlt:@"Are you sure you want to\n leave this software?" block:^{
        XTLogoutApi *api = [[XTLogoutApi alloc] init];
        [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
            [[XTUserManger xt_share] xt_loginOut];
        } failure:^(NSDictionary *dic, NSString *str) {
            
        } error:^(NSError * _Nonnull error) {
            
        }];
        
    }];
}

-(void)nextCancelAccount{
    [self showAlt:@"Are you sure you want to\n cancel account?" block:^{
        XTDelAccountApi *api = [[XTDelAccountApi alloc] init];
        [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
            [[XTUserManger xt_share] xt_loginOut];
        } failure:^(NSDictionary *dic, NSString *str) {
            
        } error:^(NSError * _Nonnull error) {
            
        }];
    }];
}

-(void)showAlt:(NSString *)alt block:(XTBlock)block{
    XTSetAltView *altView = [[XTSetAltView alloc] initWithAlt:alt];
    altView.center = self.view.center;
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:altView];
    popView.animationStyle = YFPopViewAnimationStyleFade;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    __weak YFPopView *weakView = popView;
    altView.sureBlock = ^{
        [weakView removeSelf];
        weakView.didDismiss = ^(YFPopView *popView) {
            if(block) {
                block();
            }
        };
    };
    altView.cancelBlock = ^{
        [weakView removeSelf];
    };
}

- (UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.xt_navView.frame),self.view.width, self.view.height - CGRectGetMaxY(self.xt_navView.frame)) style:UITableViewStylePlain];
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

- (NSMutableArray<XTCellModel *> *)list {
    if(!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
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
