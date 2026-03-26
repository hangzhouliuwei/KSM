//
//  PesoBaseVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoBaseVC.h"

@interface PesoBaseVC ()
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) QMUIButton *backBtn;
@property (nonatomic, strong) QMUILabel *titleL;

@end

@implementation PesoBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startTime = [NSDate br_timestamp];

    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarAndStatusBarHeight)];
    _backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_backView];
    
    [_backView addSubview:self.backBtn];
    [_backView addSubview:self.titleL];
    [self createUI];
    
    self.titleL.text = self.titleString;
    self.hiddenBackBtn = NO;
    
    // Do any additional setup after loading the view.
}
- (void)setHiddenBackBtn:(BOOL)hiddenBackBtn
{
    _hiddenBackBtn = hiddenBackBtn;
    self.backBtn.hidden = hiddenBackBtn;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    _titleL.text = titleString;
}
- (NSDictionary *)getaSomeApiParam:(NSString *)product_id sceneType:(NSString *)type
{
    NSDictionary *dic = @{
                                @"deamthirteenatoryNc":@(self.startTime.integerValue),
                                @"munithirteenumNc":NotNil(product_id),
                                @"hyrathirteenrthrosisNc": NotNil(type),
                                @"boomthirteenofoNc": NotNil([PesoLocationCenter.sharedPesoLocationCenter latitude]),
                                @"unevthirteenoutNc": NotNil([PesoLocationCenter.sharedPesoLocationCenter longitude]),
                                @"cacothirteentomyNc": NotNil([PesoDeviceTool idfv]),
                                @"unulthirteenyNc": @([NSDate br_timestamp].integerValue)
                              };
    return dic;
}
- (void)bringNavToFront
{
    [self.view bringSubviewToFront:self.backView];
}
- (void)createUI{

    
}
//返回
- (void)backClickAction{
    [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
        
    }];
}
/**手势**/
- (BOOL)forceEnableInteractivePopGestureRecognizer
{
    return YES;
}

- (void)removeViewController
{
    NSMutableArray *VCArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [VCArr removeObject:self];
    self.navigationController.viewControllers =VCArr;
}
- (QMUIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"ph_navigation_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClickAction) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.frame = CGRectMake(0,kNavBarAndStatusBarHeight - kNavBarHeight, 60, kNavBarHeight);
    }
    return _backBtn;
}
- (QMUILabel *)titleL
{
    if (!_titleL) {
        _titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_SD(18) textColor:ColorFromHex(0x0B2C04)];
        _titleL.frame = CGRectMake(60.f, kNavBarAndStatusBarHeight - kNavBarHeight, kScreenWidth - 120, kNavBarHeight);
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}
@end
