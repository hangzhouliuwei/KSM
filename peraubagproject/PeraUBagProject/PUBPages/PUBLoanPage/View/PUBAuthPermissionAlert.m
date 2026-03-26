//
//  PUBAuthPermissionAlert.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/27.
//

#import "PUBAuthPermissionAlert.h"

@interface PUBAuthPermissionAlert ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, copy)   NSString *logoStr;
@property (nonatomic, copy)   NSString *textStr;
@property (nonatomic, copy)   NSString *btnText;
@property (nonatomic,strong)  PUBBaseButton *confirmBtn;
@end

@implementation PUBAuthPermissionAlert
- (instancetype)initWith:(NSString *)logoStr textStr:(NSString *)textStr btnText:(NSString *)btnText {
    self = [super init];
    if (self) {
        self.logoStr = logoStr;
        self.textStr = textStr;
        self.btnText = btnText;
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIButton *bgGrayView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgGrayView.frame = self.frame;
    bgGrayView.alpha = 0.7;
    bgGrayView.backgroundColor = [UIColor blackColor];
    [bgGrayView addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgGrayView];
    
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 198 - KSafeAreaBottomHeight, SCREEN_WIDTH, 198 + KSafeAreaBottomHeight)];
    _alertView.backgroundColor = [UIColor whiteColor];
    [_alertView showTopRarius:12];
    [self addSubview:_alertView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(_alertView.width - 55, 0, 55, 55);
    [closeBtn setImage:ImageWithName(@"ic_close_alert") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:closeBtn];
    
    UIImageView *logoImageV = [[UIImageView alloc]initWithImage:ImageWithName(self.logoStr)];
    logoImageV.frame = CGRectMake(14, 14, 40, 40);
    [_alertView addSubview:logoImageV];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(14, logoImageV.bottom + 8, _alertView.width - 2*14*WScale, 21)];
    title.text = self.textStr;
    title.textColor = COLOR(102, 102, 102);
    title.font = FONT(15);
    title.numberOfLines = 0;
    [title sizeToFit];
    title.textAlignment = NSTextAlignmentLeft;
    [_alertView addSubview:title];
    title.height = title.height;
    
    _confirmBtn = [[PUBBaseButton alloc] initWithFrame:CGRectMake(14, title.bottom + 30, _alertView.width - 2*14, 48) title:self.btnText];
    _confirmBtn.type = NLButtonTypeCancel;
    [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_confirmBtn];
    
    _alertView.height = _confirmBtn.bottom + 16 +KSafeAreaBottomHeight;
    _alertView.frame = CGRectMake(0, SCREEN_HEIGHT - _confirmBtn.bottom - 16 - KSafeAreaBottomHeight, KSCREEN_WIDTH, _confirmBtn.bottom + 16 + KSafeAreaBottomHeight);
}

- (void)confirmBtnClick:(UIButton *)btn {
    if(self.confirmBlock){
        self.confirmBlock();
    }
    [self hide];
}

- (void)show {
    CGRect rect = _alertView.frame;
    _alertView.frame = CGRectMake(rect.origin.x, KSCREEN_HEIGHT, rect.size.width, rect.size.height);
    WEAKSELF;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.frame = rect;
    }completion:^(BOOL finished) {
        
    }];
    self.alpha = 1;
    if (IOS_VRESION_13) {
        [TOP_WINDOW addSubview:self];
    }else {
        [[VCManager topViewController].view addSubview:self];
    }
}

- (void)showWithText:(NSString *)String {
    CGRect rect = _alertView.frame;
    _alertView.frame = CGRectMake(rect.origin.x, KSCREEN_HEIGHT, rect.size.width, rect.size.height);
    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.frame = rect;
    }completion:^(BOOL finished) {

    }];
    self.alpha = 1;
    if (IOS_VRESION_13) {
        [TOP_WINDOW addSubview:self];
    }else {
        [[VCManager topViewController].view addSubview:self];
    }
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)bgBtnClick:(UIButton *)btn {
    [self hide];
}

@end
