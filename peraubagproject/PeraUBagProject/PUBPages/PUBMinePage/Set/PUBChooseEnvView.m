//
//  PUBChooseEnvView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/5/28.
//

#import "PUBChooseEnvView.h"

@interface PUBChooseEnvView()
@property(nonatomic, strong) QMUITextField *textField;
@property(nonatomic, strong) UIButton *btn;
@end

@implementation PUBChooseEnvView

- (instancetype)init{
    self = [super init];
    if(self){
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews
{  
    self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgClick)];
    [self addGestureRecognizer:tap];
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = UIColor.whiteColor;
    backView.layer.cornerRadius = 8.f;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(KSCREEN_WIDTH - 60.f, 160.f));
        
    }];
    
    [backView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20.f);
        make.left.mas_equalTo(10.f);
        make.right.mas_equalTo(-10.f);
        make.height.mas_equalTo(44.f);
    }];
    
    [backView addSubview: self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(10.f);
        make.right.mas_equalTo(-10.f);
        make.height.mas_equalTo(44.f);
        make.bottom.mas_equalTo(-10.f);
    }];
}

- (void)show
{
    
    [UIApplication.sharedApplication.windows.firstObject addSubview:self];
}

- (void)bgClick
{
    [self removeFromSuperview];
}

- (void)btnClick
{
    if ([self.textField.text isEqual:@"ksm2023"]){
        self.clickBlock(YES);
        [self bgClick];
        return;
    }
    
    self.clickBlock(NO);
    [self bgClick];
    
}

-(QMUITextField *)textField{
    if(!_textField){
        _textField = [[QMUITextField alloc] init];
        _textField.layer.borderColor = [UIColor blackColor].CGColor;
        _textField.layer.cornerRadius = 6.f;
        _textField.layer.borderWidth = 0.8f;
    }
    return _textField;
}

- (UIButton *)btn{
    if(!_btn){
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor blueColor];
        _btn.titleLabel.font = FONT(18.f);
        _btn.layer.cornerRadius = 8.f;
        [_btn setTitle:@"Submit" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn;
}

@end
