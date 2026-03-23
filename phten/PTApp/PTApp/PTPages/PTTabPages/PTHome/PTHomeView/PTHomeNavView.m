//
//  PTHomeNavView.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/1.
//

#import "PTHomeNavView.h"

@interface PTHomeNavView()
@property(nonatomic, strong) QMUILabel *memberLabel;
@property(nonatomic, strong) QMUILabel *phoneLabel;
@property(nonatomic, strong) UIImageView *userIocnImageView;
@end

@implementation PTHomeNavView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self createSubUI];
    }
    return self;
}

-(void)updataShowMember:(BOOL)showMember
{

}


-(void)createSubUI
{
    self.userIocnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(36.f, kStatusBarHeight + PTAUTOSIZE(12.f), 42.f, 42.f)];
    self.userIocnImageView.image = [UIImage imageNamed:@"PT_setting_logo"];
    [self addSubview:self.userIocnImageView];
    
    self.memberLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_SD(14.f) textColor:PTUIColorFromHex(0x000000)];
    self.memberLabel.text = AppName;
    self.memberLabel.frame = CGRectMake(self.userIocnImageView.right + 8.f, kStatusBarHeight + PTAUTOSIZE(16.f), 140.f, 14.f);
    self.memberLabel.centerY = self.userIocnImageView.centerY;
    [self addSubview:self.memberLabel];
//    
//    self.phoneLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_H(20.f) textColor:PTUIColorFromHex(0x000000)];
//    self.phoneLabel.text = [PTTools hideMiddleDigitsForPhoneNumber:PTUser.username];
//    self.phoneLabel.frame = CGRectMake(self.userIocnImageView.right + 8.f, kStatusBarHeight + PTAUTOSIZE(36.f), kScreenWidth - 82.f, 22.f);
//    [self addSubview:self.phoneLabel];
//    self.phoneLabel.centerY = self.userIocnImageView.centerY;
}




@end
