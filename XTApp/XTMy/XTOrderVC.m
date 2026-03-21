//
//  XTOrderVC.m
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import "XTOrderVC.h"
#import "XTSegView.h"
#import "XTOrderView.h"

#define viewTag 1000

@interface XTOrderVC ()<UIScrollViewDelegate>

@property(nonatomic) NSInteger viewIndex;
@property(nonatomic,strong) XTSegView *segView;
@property(nonatomic,strong) NSArray <NSDictionary *>*segList;
@property(nonatomic,strong) UIScrollView *scrollView;

@end

@implementation XTOrderVC

- (instancetype)init {
    return [self initWithIndex:0];
}

- (instancetype)initWithIndex:(NSInteger)index {
    self = [super init];
    if(self) {
        self.viewIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.xt_navView.backgroundColor = [UIColor clearColor];
    self.xt_backType = XT_BackType_B;
    self.xt_title = @"Loan Record";;
    
    UIView *topView = [UIView xt_frame:CGRectMake(0, 0, self.view.width, XT_Nav_Height + 97) color:[UIColor clearColor]];
    [self.view addSubview:topView];
    [topView.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0x0BB559, 1.0f).CGColor,(__bridge id)[UIColor whiteColor].CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 0.6) size:topView.size]];
    [self.view bringSubviewToFront:self.xt_navView];
    
    [self.view addSubview:self.segView];
    //    [self.segView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.view.mas_left).offset(5);
    //        make.right.equalTo(self.view.mas_right).offset(-5);
    //        make.top.equalTo(self.xt_navView.mas_bottom).offset(25);
    //        make.height.equalTo(@34);
    //    }];
    @weakify(self)
    self.segView.block = ^(NSInteger index) {
        @strongify(self)
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.width * index, 0)];
        [self creatView:index];
    };
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width * self.viewIndex, 0)];
    [self creatView:self.viewIndex];
}

-(void)creatView:(NSInteger)index{
    XTOrderView *view = [self.scrollView viewWithTag:viewTag + index];
    if(!view) {
        NSDictionary *dic = self.segList[index];
        XTOrderView *view = [[XTOrderView alloc] initWithFrame:CGRectMake(self.scrollView.width * index, 0, self.scrollView.width, self.scrollView.height) xt_order_type:dic[@"value"]];
        view.tag = viewTag + index;
        [self.scrollView addSubview:view];
        @weakify(self)
        view.block = ^{
            @strongify(self)
            UITabBarController *tabbar = [self.navigationController.viewControllers firstObject];
            if([tabbar isKindOfClass:[UITabBarController class]]) {
                [self.navigationController popToViewController:tabbar animated:YES];
                tabbar.selectedIndex = 0;
            }
        };
    }
    else {
        [view xt_reload];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    self.viewIndex = index;
    [self.segView reloadSeg:index];
    [self creatView:self.viewIndex];
}

- (XTSegView *)segView {
    if(!_segView) {
        _segView = [[XTSegView alloc] initArr:self.segList font:XT_Font(14) selectFont:XT_Font_SD(15) color:XT_RGB(0x303030, 1.0f) selectColor:[UIColor whiteColor] bgColor:[UIColor clearColor] selectBgColor:XT_RGB(0x0BB559, 1.0f) cornerRadius:17 select:self.viewIndex];
        _segView.frame = CGRectMake(5, CGRectGetMaxY(self.xt_navView.frame), self.view.width - 10, 34);
    }
    return _segView;
}

- (NSArray<NSDictionary *> *)segList {
    if(!_segList) {
        _segList = @[
            @{
                @"name":@"Borrowing",
                @"value":@"7",
            },
            @{
                @"name":@"Order",
                @"value":@"4",
            },
            @{
                @"name":@"Not fnished",
                @"value":@"6",
            },
            @{
                @"name":@"Repaid",
                @"value":@"5",
            }
        ];
    }
    return _segList;
}

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segView.frame), self.view.width, self.view.height - CGRectGetMaxY(self.segView.frame))];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(self.view.width * self.segList.count, _scrollView.height);
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
