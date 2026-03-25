//
//  PTAuthPermissionAlertView.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import "PTAuthPermissionAlertView.h"

@interface PTAuthPermissionAlertView ()
@property(nonatomic, strong) UIView *alertView;
@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) QMUILabel *subTitleLabel;
@end

@implementation PTAuthPermissionAlertView

-(instancetype)initWithTitleStr:(NSString*)titleStr subTitleStr:(NSString*)subTitleStr{
    self = [super init];
    if(self){
        [self createSubUITitleStr:titleStr subTitleStr:subTitleStr];
    }
    return self;
}

- (void)createSubUITitleStr:(NSString*)titleStr subTitleStr:(NSString*)subTitleStr
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    UIView *bgGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgGrayView.alpha = 0.7f;
    bgGrayView.backgroundColor = [UIColor blackColor];
    [self addSubview:bgGrayView];
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 198.f - kSafeAreaBottomHeight, kScreenWidth, 198.f + kSafeAreaBottomHeight)];
    self.alertView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.alertView];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_permission"]];
    backImageView.userInteractionEnabled = YES;
    [self.alertView addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(16.f) textColor:PTUIColorFromHex(0x09121F)];
    self.titleLabel.backgroundColor = PTUIColorFromHex(0x64F6FE);
    self.titleLabel.text = PTNotNull(titleStr);
    [self.alertView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(52.f);
        make.height.mas_equalTo(18.f);
    }];
    
    self.subTitleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(14.f) textColor:PTUIColorFromHex(0x09121F)];
    self.subTitleLabel.text = PTNotNull(subTitleStr);
    self.subTitleLabel.numberOfLines = 2.f;
    [self.alertView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabel.mas_leading);
        make.right.mas_equalTo(-16.f);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(24.f);
    }];
    
    QMUIButton *nextBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.backgroundColor = PTUIColorFromHex(0xE2FFAB);
    [nextBtn showRadius:21.f];
    nextBtn.titleLabel.font = PT_Font_B(16.f);
    [nextBtn setTitle:@"ok" forState:UIControlStateNormal];
    [nextBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo( self.subTitleLabel.mas_bottom).offset(16.f);
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(-16.f);
        make.height.mas_equalTo(42.f);
    }];
    
}

-(void)nextBtnClick
{
    [self hide];
    if(self.confirmClickBlock){
        self.confirmClickBlock();
    }
}

-(void)show
{
    CGRect rect = _alertView.frame;
    _alertView.frame = CGRectMake(rect.origin.x, kScreenHeight, rect.size.width, rect.size.height);
    WEAKSELF;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.frame = rect;
    }completion:^(BOOL finished) {
        
    }];
    self.alpha = 1;
    [TOP_WINDOW addSubview:self];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
