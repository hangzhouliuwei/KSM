//
//  XTBaseVC.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTBaseVC.h"
#import "XTAssistiveView.h"

@interface XTBaseVC ()

@property(nonatomic,strong) UILabel *xt_titLab;
@property(nonatomic,weak) UIImageView *xt_bk_img;

@end

@implementation XTBaseVC

- (void)dealloc {
    XTLog(@"dealloc:%@",[self class]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(
       [self isKindOfClass:NSClassFromString(@"XTHtmlVC")] ||
       [self isKindOfClass:NSClassFromString(@"XTLoginCodeVC")] ||
       [self isKindOfClass:NSClassFromString(@"XTLoginVC")]
       ){
        [XTAssistiveView xt_share].hidden = YES;
    }
    else {
        [XTAssistiveView xt_share].hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.xt_navView];
    [self.xt_navView addSubview:self.xt_bkBtn];
    [self.xt_bkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.xt_navView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(XT_NavBar_Height);
    }];
    
    [self.xt_navView addSubview:self.xt_titLab];
    [self.xt_titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.xt_bkBtn);
        make.centerX.mas_equalTo(self.xt_navView);
    }];
}

- (void)xt_back {
    if(![self.navigationController popViewControllerAnimated:YES]){
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void)setXt_title:(NSString *)xt_title{
    _xt_title = xt_title;
    self.xt_titLab.text = xt_title;
}

- (void)setXt_title_color:(UIColor *)xt_title_color {
    _xt_title_color = xt_title_color;
    self.xt_titLab.textColor = xt_title_color;
}

- (void)setXt_backType:(XT_BackType)xt_backType {
    _xt_backType = xt_backType;
    if(xt_backType == XT_BackType_B){
        self.xt_bk_img.image = XT_Img(@"xt_nav_back_b");
    }
}

- (UIView *)xt_navView {
    if(!_xt_navView){
        _xt_navView = [UIView xt_frame:CGRectMake(0, 0, XT_Screen_Width, XT_Nav_Height) color:XT_RGB(0x0BB559, 1.0f)];
    }
    return _xt_navView;
}

- (UIButton *)xt_bkBtn{
    if(!_xt_bkBtn){
        UIButton *btn = [UIButton new];
        
        UIImageView *img = [UIImageView xt_img:@"xt_nav_back_w" tag:0];
        [btn addSubview:img];
        self.xt_bk_img = img;
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(btn.mas_left).offset(16);
            make.centerY.equalTo(btn);
        }];
        
        @weakify(self)
        btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [self xt_back];
            return [RACSignal empty];
        }];
        _xt_bkBtn = btn;
    }
    return _xt_bkBtn;
}

- (UILabel *)xt_titLab{
    if(!_xt_titLab){
        _xt_titLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_B(18) textColor:[UIColor blackColor] alignment:NSTextAlignmentCenter tag:0];
    }
    return _xt_titLab;
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
