//
//  PTBaseVC.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/16.
//

#import "PTBaseVC.h"

@interface PTBaseVC ()

@end

@implementation PTBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.view.backgroundColor = PTUIColorFromHex(0xF5F9FF);
    self.startTime = [NSDate br_timestamp];
}

- (void)createUI
{   
    self.navigationController.navigationBarHidden = YES;
    UIImageView *homeBackImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 450.f)];
    homeBackImage.image = [UIImage imageNamed:@"PT_home_back"];
    homeBackImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:homeBackImage];
    
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.titleLabel];
    [self.navView addSubview:self.leftBtn];
    
}

- (void)leftBtnClick
{
    [self.navigationController qmui_popViewControllerAnimated:YES completion:nil];
    
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

#pragma mark - lazy
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavHeight)];
        _navView.backgroundColor = [UIColor qmui_colorWithHexString:@"#ffffff"];
        _navView.backgroundColor = UIColor.clearColor;
    }
    return _navView;
}

-(QMUILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_SD(18.f) textColor:RGBA_HEX(0x000000, 1.0f)];
        _titleLabel.frame = CGRectMake(60.f, self.navView.height - kNavBarHeight, kScreenWidth - 120, kNavBarHeight);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

- (QMUIButton *)leftBtn{
    if(!_leftBtn){
        _leftBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(0, self.navView.height - kNavBarHeight, 60, kNavBarHeight)];
        [_leftBtn setImage:[UIImage imageNamed:@"PT_navigation_back"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _leftBtn;
}


- (void)showtitle:(NSString*)title isLeft:(BOOL)isLeft disPlayType:(PTDisplayType)disPlayType
{
    self.titleLabel.textAlignment = isLeft ? NSTextAlignmentLeft : NSTextAlignmentCenter;
    self.titleLabel.text = PTNotNull(title);
    if(disPlayType == PTDisplayTypeBlack){
        [self.leftBtn setImage:[UIImage imageNamed:@"PT_navigation_back"] forState:UIControlStateNormal];
    }else if (disPlayType == PTDisplayTypeWhite){
        
    }
    
}
- (void)showToast:(NSString *)text
{
    [PTTools showToast:text];
}
- (void)showToast:(NSString *)title duration:(CGFloat)duration
{
    [PTTools showToast:title time:duration];
}

@end
