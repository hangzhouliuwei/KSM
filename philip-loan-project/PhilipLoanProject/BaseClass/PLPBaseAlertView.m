//
//  BaseAlertView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/29.
//

#import "PLPBaseAlertView.h"
#import "TFPopup.h"
@implementation PLPBaseAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)plp_dismiss
{
    [self tf_remove];
}
-(void)popAlertViewOnBottom
{
    TFPopupParam *popParam = [TFPopupParam new];
    popParam.disuseBackgroundTouchHide = NO;
    [self tf_showSlide:[UIApplication sharedApplication].keyWindow direction:PopupDirectionBottom popupParam:popParam];
}
-(void)popAlertViewOnCenter
{
    TFPopupParam *popParam = [TFPopupParam new];
    popParam.disuseBackgroundTouchHide = NO;
    [self tf_showSlide:[UIApplication sharedApplication].keyWindow direction:PopupDirectionContainerCenter popupParam:popParam];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
