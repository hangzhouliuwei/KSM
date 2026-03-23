//
//  LocationAlertView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/29.
//

#import "LocationAlertView.h"

@implementation LocationAlertView




-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 50, self.width - 28, 46)];
        [_infoLabel pp_setPropertys:@[kFontSize(16),kBlackColor_333333,@"To be able to use our app, please turn on yourdevice location services."]];
        _infoLabel.numberOfLines = 0;
        [self clipTopLeftAndTopRightCornerRadius: 16];
        
        self.okButton= [UIButton buttonWithType:UIButtonTypeCustom];
        self.okButton.frame = CGRectMake(14, self.height - 16 - 47, self.width - 28, 47);
        self.okButton.backgroundColor = kBlueColor_0053FF;
        self.okButton.layer.cornerRadius = self.okButton.height / 2;
        [self.okButton setTitle:@"Ok" forState:UIControlStateNormal];
        [self.okButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [self.okButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.okButton];
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeButton.frame = CGRectMake(self.width - 32 - 5, 13, 32, 32);
//        self.closeButton.backgroundColor = kBlueColor_0053FF;
        [self.closeButton setImage:kImageName(@"alert_close") forState:UIControlStateNormal];
        [self.closeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closeButton];
    }
    return self;
}
-(void)buttonAction:(UIButton *)button
{
    if ([button isEqual:self.closeButton]) {
        [self plp_dismiss];
    }else if ([button isEqual:self.okButton]) {
        if (self.okBlk) {
            self.okBlk();
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
