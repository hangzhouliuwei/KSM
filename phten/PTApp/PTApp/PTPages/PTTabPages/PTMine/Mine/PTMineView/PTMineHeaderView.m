//
//  PTMineHeaderView.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/12.
//

#import "PTMineHeaderView.h"

@interface PTMineHeaderView ()
@property(nonatomic, strong) QMUILabel *memberLabel;
@property(nonatomic, strong) QMUILabel *phoneLabel;
@property(nonatomic, strong) UIImageView *userImage;
@end

@implementation PTMineHeaderView

-(void)updataMemberStr:(NSString*)memberStr
{
    self.phoneLabel.text = [PTTools hideMiddleDigitsForPhoneNumber:PTUser.username];
    
    if([PTTools isBlankString:memberStr]){
        self.memberLabel.hidden = YES;
        [self.phoneLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.userImage.mas_centerY);
            make.left.mas_equalTo(self.userImage.mas_right).offset(12.f);
            make.height.mas_equalTo(22.f);
        }];
        return;
    }
       self.memberLabel.hidden = YES;
        [self.memberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.userImage.mas_top);
            make.left.mas_equalTo(self.userImage.mas_right).offset(12.f);
            make.height.mas_equalTo(14.f);
        }];
        [self.phoneLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.userImage.mas_bottom);
            make.left.mas_equalTo(self.userImage.mas_right).offset(12.f);
            make.height.mas_equalTo(22.f);
        }];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = UIColor.clearColor;
        [self createSubUI];
    }
    return self;
}

- (void)createSubUI
{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_mine_heardback"]];
    backImage.userInteractionEnabled = YES;
    [self addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(48.f);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(150.f);
    }];
    
    UIImageView *bottmeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_mine_heardbottm"]];
    [self addSubview:bottmeImage];
    [bottmeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backImage.mas_bottom);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.bottom.mas_equalTo(0);
    }];
    
    self.userImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_usericon"]];
    [backImage addSubview:self.userImage];
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16.f);
        make.left.mas_equalTo(16.f);
        make.size.mas_equalTo(CGSizeMake(50.f, 50.f));
    }];
    
    [backImage addSubview:self.memberLabel];
    [backImage addSubview:self.phoneLabel];
    
    UIImageView *borrwImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_mine_heardborrow"]];
    borrwImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *borrwTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(borrwTapClick)];
    [borrwImage addGestureRecognizer:borrwTap];
    [backImage addSubview:borrwImage];
    [borrwImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userImage.mas_bottom).offset(24.f);
        make.left.mas_equalTo(16.f);
        make.size.mas_equalTo(CGSizeMake(148.f, 40.f));
    }];
    
    QMUILabel *borrwLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_SD(12.f) textColor:PTUIColorFromHex(0x000000)];
    borrwLabel.text = @"Borrowing";
    borrwLabel.textAlignment = NSTextAlignmentCenter;
    [borrwImage addSubview:borrwLabel];
    [borrwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.height.mas_equalTo(14.f);
    }];
    
    
    UIImageView *orderImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_mine_heardorder"]];
    orderImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *orderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderTapClick)];
    [orderImage addGestureRecognizer:orderTap];
    [backImage addSubview:orderImage];
    [orderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10.f);
        make.centerY.mas_equalTo(borrwImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(148.f, 40.f));
    }];
    
    QMUILabel *orderLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_SD(12.f) textColor:PTUIColorFromHex(0x000000)];
    orderLabel.text = @"Order";
    orderLabel.textAlignment = NSTextAlignmentCenter;
    [orderImage addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.height.mas_equalTo(14.f);
    }];
}

- (void)borrwTapClick
{
    if(self.orderClick){
        self.orderClick(0);
    }
}

- (void)orderTapClick
{
    if(self.orderClick){
        self.orderClick(1);
    }
}

#pragma mark - lazy

-(QMUILabel *)memberLabel{
    if(!_memberLabel){
        _memberLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12.f) textColor:PTUIColorFromHex(0x000000)];
        _memberLabel.textAlignment = NSTextAlignmentLeft;
        _memberLabel.text = @"Hello,Esteemed Member";
    }
    return _memberLabel;
}

-(QMUILabel *)phoneLabel{
    if(!_phoneLabel){
        _phoneLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_H(20.f) textColor:PTUIColorFromHex(0x000000)];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _phoneLabel;
}

@end
