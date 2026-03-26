//
//  PUBEnvironmentViewController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/23.
//

#import "PUBEnvironmentViewController.h"
#import "PUBEnvironmentManager.h"

@interface PUBEnvironmentViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField * textField;
@end

@implementation PUBEnvironmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar showtitle:@"Set up" isLeft:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

- (void)backBtnClick:(UIButton *)btn
{
    [self.navigationController qmui_popViewControllerAnimated:YES completion:nil];
    
}

- (void)setupViews {
    UIView * formView = [[UIView alloc] init];
    [self.view addSubview:formView];
    formView.layer.cornerRadius = 8;
    formView.layer.masksToBounds = true;
    formView.layer.borderColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    formView.layer.borderWidth = 1.0;


    [formView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.view).offset(self.navBar.bottom + 20.f);
    }];

    UITextField * textField = [[UITextField alloc] init];
    [formView addSubview:textField];

    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(formView).offset(8);
        make.right.equalTo(formView).offset(-8);
        make.top.bottom.equalTo(formView);
    }];

    textField.placeholder = @"host";
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    textField.delegate = self;
    textField.textColor = [UIColor blackColor];

    textField.tintColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    textField.font = FONT_BOLD(14);
    textField.textAlignment = NSTextAlignmentLeft;

    textField.text = PUBEnvironment.host;

    self.textField = textField;

    UIButton * switchBtn = [[UIButton alloc] init];
    [self.view addSubview:switchBtn];

    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(formView.mas_bottom).offset(30);
        make.height.mas_equalTo(44);
        make.left.right.equalTo(formView);
    }];

    switchBtn.backgroundColor = LoginSelectColor;
    [switchBtn setTitle:@"switch" forState:UIControlStateNormal];
    [switchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    switchBtn.titleLabel.font = FONT_BOLD(20);
    switchBtn.layer.cornerRadius = 8;
    switchBtn.layer.masksToBounds = true;
    [switchBtn addTarget:self action:@selector(clickSwitch) forControlEvents:UIControlEventTouchUpInside];


    UIButton * formalBtn = [[UIButton alloc] init];
    [self.view addSubview:formalBtn];

    [formalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(switchBtn.mas_bottom).offset(20);
        make.left.right.height.equalTo(switchBtn);
    }];

    formalBtn.backgroundColor = LoginSelectColor;
    [formalBtn setTitle:@"switch Formal" forState:UIControlStateNormal];
    [formalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    formalBtn.titleLabel.font = FONT_BOLD(20);
    formalBtn.layer.cornerRadius = 8;
    formalBtn.layer.masksToBounds = true;
    [formalBtn addTarget:self action:@selector(clickFormalBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * testBtn = [[UIButton alloc] init];
    [self.view addSubview:testBtn];

    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(formalBtn.mas_bottom).offset(20);
        make.left.right.height.equalTo(switchBtn);
    }];

    testBtn.backgroundColor = LoginSelectColor;
    [testBtn setTitle:@"switch Test" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    testBtn.titleLabel.font = FONT_BOLD(20);
    testBtn.layer.cornerRadius = 8;
    testBtn.layer.masksToBounds = true;
    [testBtn addTarget:self action:@selector(clickTestBtn) forControlEvents:UIControlEventTouchUpInside];

}

- (void)clickSwitch {
    if (self.textField.text == nil || self.textField.text.length == 0) {
        [PUBTools showToast:@"host illegality"];
        return;
    }

    if (![self.textField.text hasPrefix:@"https://"] && ![self.textField.text hasPrefix:@"http://"]) {
        [PUBTools showToast:@"host illegality"];
        return;
    }

    //PUBEnvironment.host = self.textField.text;
    
    [PUBCache cacheYYObject:self.textField.text withKey:PUBhost];
    [User logoutCallServer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
}

- (void)clickFormalBtn {
    //PUBEnvironment.host = @"https://api.peraubagios.com";
    NSString *url = [PUBCache getcacheYYObjectWithKey:PUBhost];
    if ([url isEqual:@"https://api.peraubagios.com"]) {
        [PUBTools showToast:@"当前已经是正式环境!" time:1];
        return;
    }
    
    [PUBCache cacheYYObject:@"https://api.peraubagios.com" withKey:PUBhost];
    [User logoutCallServer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
}

- (void)clickTestBtn
{
    //PUBEnvironment.host = @"http://api-pubi.ph.dev.ksmdev.top";
    NSString *url = [PUBCache getcacheYYObjectWithKey:PUBhost];
    if ([url isEqual:@"http://api-pubi.ph.dev.ksmdev.top"]) {
        [PUBTools showToast:@"当前已经是测试环境!" time:1];
        return;
    }
    
    [PUBCache cacheYYObject:@"http://api-pubi.ph.dev.ksmdev.top" withKey:PUBhost];
    [User logoutCallServer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!string || string.length == 0) {
        return true;
    }

    return string.length < 50;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return true;
}



@end
